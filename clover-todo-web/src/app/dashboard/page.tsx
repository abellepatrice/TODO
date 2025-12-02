"use client";

import ProtectedRoute from "@/components/ProtectedRoute";
import Navbar from "../../components/Navbar";
import Sidebar from "@/components/Sidebar";
import Link from "next/link";

export default function DashboardPage() {
  return (
    <ProtectedRoute>
      <div className="min-h-screen flex flex-col bg-gray-50">
        <Navbar />

        <div className="flex flex-1">
          {/* Sidebar */}
          <Sidebar />

          {/* Main Content */}
          <main className="flex-1 p-6">
            <h1 className="text-2xl font-bold mb-4 text-gray-900">
              Dashboard
            </h1>

            <div className="space-y-4">
              <Link
                href="/tasks"
                className="block p-4 bg-white rounded-lg shadow hover:bg-gray-100 transition"
              >
                View Tasks →
              </Link>

              <Link
                href="/tasks/create"
                className="block p-4 bg-white rounded-lg shadow hover:bg-gray-100 transition"
              >
                Create New Task →
              </Link>
            </div>
          </main>
        </div>
      </div>
    </ProtectedRoute>
  );
}
