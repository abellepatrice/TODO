"use client";

import { useEffect, useState, useCallback } from "react";
import ProtectedRoute from "@/components/ProtectedRoute";
import Navbar from "../../components/Navbar";
import Sidebar from "@/components/Sidebar";
import { api } from "../lib/api";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faUser } from "@fortawesome/free-solid-svg-icons";

interface User {
  id: string;
  email: string;
  username?: string | null;
  created_at?: string;
  last_sign_in_at?: string;
}

export default function ProfilePage() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);

  const fetchUserProfile = useCallback(async () => {
    setLoading(true);
    setError(false);
    try {
      const res = await api.getProfile();
      setUser(res.data.user);
    } catch (err) {
      console.error("Failed to fetch profile:", err);
      setError(true);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchUserProfile();
  }, [fetchUserProfile]);

  const formatDate = (dateStr?: string) => {
    if (!dateStr) return "-";
    const date = new Date(dateStr);
    return date.toLocaleString();
  };

  return (
    <ProtectedRoute>
      <div className="min-h-screen flex flex-col bg-gray-50">
        <Navbar />
        <div className="flex flex-1">
          <Sidebar />

          <main className="flex-1 p-6">
            <h1 className="text-2xl font-bold mb-6 text-gray-900">Profile</h1>

            {loading ? (
              <div className="flex justify-center items-center h-64">
                <p className="text-gray-600">Loading profile...</p>
              </div>
            ) : error ? (
              <div className="flex flex-col justify-center items-center h-64 space-y-2">
                <p className="text-gray-600">Failed to load profile information.</p>
                <button
                  className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700"
                  onClick={fetchUserProfile}
                >
                  Retry
                </button>
              </div>
            ) : user ? (
              <div className="bg-white rounded-lg shadow-md p-6 max-w-md w-full flex flex-col items-center space-y-6">
                {/* Profile Image Placeholder */}
                <div className="text-gray-400 w-20 h-20 flex items-center justify-center">
                    <FontAwesomeIcon icon={faUser} className="w-20 h-10" />
                </div>

                {/* User Information */}
                <div className="w-full space-y-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Username</label>
                    <p className="text-gray-900 bg-gray-50 px-3 py-2 rounded-md">
                      {user.username || "Username"}
                    </p>
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Email</label>
                    <p className="text-gray-900 bg-gray-50 px-3 py-2 rounded-md">
                      {user.email || "-"}
                    </p>
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Last Login</label>
                    <p className="text-gray-900 bg-gray-50 px-3 py-2 rounded-md">
                      {formatDate(user.last_sign_in_at)}
                    </p>
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Account Created</label>
                    <p className="text-gray-900 bg-gray-50 px-3 py-2 rounded-md">
                      {formatDate(user.created_at)}
                    </p>
                  </div>

                  <div>
                    
                  </div>
                </div>
              </div>
            ) : null}
          </main>
        </div>
      </div>
    </ProtectedRoute>
  );
}
