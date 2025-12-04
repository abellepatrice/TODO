"use client";

import { useEffect, useState } from "react";
import ProtectedRoute from "@/components/ProtectedRoute";
import Navbar from "@/components/Navbar";
import Sidebar from "@/components/Sidebar";
import { api } from "@/app/lib/api";
import { Task } from "@/types/task";
import TaskCard from "@/components/TaskCard";

export default function HistoryPage() {
  const [completedTasks, setCompletedTasks] = useState<Task[]>([]);
  const [editedTasks, setEditedTasks] = useState<Task[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedTab, setSelectedTab] = useState<"completed" | "edited">("completed");

  useEffect(() => {
    const fetchHistory = async () => {
      try {
        const completedRes = await api.getCompletedTasks();
        const editedRes = await api.getEditedTasks();

        setCompletedTasks(completedRes.data || []);
        setEditedTasks(editedRes.data || []);
      } catch (err) {
        console.error("Failed to fetch history:", err);
      } finally {
        setLoading(false);
      }
    };

    fetchHistory();
  }, []);

  const displayedTasks = selectedTab === "completed" ? completedTasks : editedTasks;

  return (
    <ProtectedRoute>
      <div className="min-h-screen flex bg-gray-50">
        {/* Sidebar */}
        <Sidebar />

        <div className="flex-1 flex flex-col">
          <Navbar />

          {/* <main className="p-6 flex-1">
            <h1 className="text-3xl font-bold mb-6 text-gray-900">History</h1>

            Tabs
            <div className="flex gap-3 mb-6">
              <button
                onClick={() => setSelectedTab("completed")}
                className={`px-4 py-2 rounded-full font-medium transition ${
                  selectedTab === "completed"
                    ? "bg-indigo-600 text-white shadow"
                    : "bg-white text-gray-700 hover:bg-gray-100"
                }`}
              >
                Completed Tasks
              </button>
              <button
                onClick={() => setSelectedTab("edited")}
                className={`px-4 py-2 rounded-full font-medium transition ${
                  selectedTab === "edited"
                    ? "bg-indigo-600 text-white shadow"
                    : "bg-white text-gray-700 hover:bg-gray-100"
                }`}
              >
                Edited Tasks
              </button>
            </div>

            {loading ? (
              <p className="text-gray-500">Loading tasks...</p>
            ) : displayedTasks.length === 0 ? (
              <p className="text-gray-500">
                No {selectedTab === "completed" ? "completed" : "edited"} tasks found.
              </p>
            ) : (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {displayedTasks.map((task) => (
                  <TaskCard key={task.id} task={task} />
                ))}
              </div>
            )}
          </main> */}
          <br />
          <br />
          <br />
          <br />
          <br />
          <br />
        <div className="text-center p-8  shadow-xl rounded-3xl">
      <h1 className="text-6xl font-extrabold text-gray-800 mb-4 animate-pulse">
        Coming Soon!
      </h1>
      <p className="text-gray-500 text-lg">
        We're working hard to bring you this feature. Stay tuned!
      </p>
    </div>
        </div>
      </div>
    </ProtectedRoute>
  );
}
