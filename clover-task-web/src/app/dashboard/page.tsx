"use client";

import { useEffect, useState } from "react";
import ProtectedRoute from "@/components/ProtectedRoute";
import Navbar from "../../components/Navbar";
import Sidebar from "@/components/Sidebar";
import TaskCard from "@/components/TaskCard";
import  { Task } from "@/types/task"
import { api } from "../lib/api";

export default function DashboardPage() {
  const [tasks, setTasks] = useState<Task[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedPriority, setSelectedPriority] = useState<"All" | "high" | "medium" | "low">("All");

  const priorities: ("All" | "high" | "medium" | "low")[] = ["All", "high", "medium", "low"];

  useEffect(() => {
    const fetchTasks = async () => {
      try {
        const res = await api.getTasks();
        setTasks(res.data);
      } catch (err) {
        console.error("Failed to fetch tasks:", err);
      } finally {
        setLoading(false);
      }
    };

    fetchTasks();
  }, []);

  const filteredTasks =
    selectedPriority === "All"
      ? tasks
      : tasks.filter((task) => task.priority === selectedPriority);

  return (
    <ProtectedRoute>
      <div className="min-h-screen flex flex-col bg-gray-50">
        <Navbar />

        <div className="flex flex-1">
          {/* Sidebar */}
          <Sidebar />

          {/* Main Content */}
          <main className="flex-1 p-6">
            <h1 className="text-3xl font-bold mb-6 text-gray-900">Dashboard</h1>

            {/* Priority Tabs */}
            <div className="flex flex-wrap gap-3 mb-6">
              {priorities.map((p) => (
                <button
                  key={p}
                  onClick={() => setSelectedPriority(p)}
                  className={`px-4 py-2 rounded-full font-medium transition ${
                    selectedPriority === p
                      ? "bg-indigo-600 text-white shadow"
                      : "bg-white text-gray-700 hover:bg-gray-100"
                  }`}
                >
                  {p.charAt(0).toUpperCase() + p.slice(1)}
                </button>
              ))}
            </div>

            {/* Task Grid */}
            {loading ? (
              <p className="text-gray-500">Loading tasks...</p>
            ) : filteredTasks.length === 0 ? (
              <p className="text-gray-500">No tasks found for this priority.</p>
            ) : (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {filteredTasks.map((task) => (
                  <TaskCard key={task.id} task={task} />
                ))}
              </div>
            )}

            {/* Quick Links */}
            <div className="mt-8 flex flex-wrap gap-4">
              <a
                href="/tasks"
                className="block px-6 py-3 bg-indigo-600 text-white rounded-lg shadow hover:bg-indigo-700 transition"
              >
                View All Tasks →
              </a>

              <a
                href="/tasks/create"
                className="block px-6 py-3 bg-green-600 text-white rounded-lg shadow hover:bg-green-700 transition"
              >
                Create New Task →
              </a>
            </div>
          </main>
        </div>
      </div>
    </ProtectedRoute>
  );
}

