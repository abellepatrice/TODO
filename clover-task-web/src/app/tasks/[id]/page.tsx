"use client";

import { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import ProtectedRoute from "@/components/ProtectedRoute";
import Navbar from "@/components/Navbar";
import Sidebar from "@/components/Sidebar";
import { api } from "@/app/lib/api";
import { Task } from "@/types/task";
import Link from "next/link";

export default function TaskDetailPage() {
  const { id } = useParams();
  const router = useRouter();

  const [task, setTask] = useState<Task | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    if (!id) return;

    api
      .getTask(id as string)
      .then((res) => {
        // Backend returns an ARRAY: [task]
        const data = Array.isArray(res.data) ? res.data[0] : res.data;

        if (!data) {
          setError("Task not found.");
        } else {
          setTask(data);
        }
      })
      .catch((err) => {
        console.error("ERROR FETCHING TASK:", err);
        setError("Failed to fetch task.");
      })
      .finally(() => setLoading(false));
  }, [id]);

  if (loading) {
    return <p className="p-6 text-gray-600 text-center">Loading task...</p>;
  }

  if (error) {
    return <p className="p-6 text-red-600 text-center">{error}</p>;
  }

  if (!task) {
    return <p className="p-6 text-gray-600 text-center">Task not found.</p>;
  }

  return (
    <ProtectedRoute>
      <div className="min-h-screen bg-gray-50 flex flex-col">
        <Navbar />

        <div className="flex flex-1">
          {/* Sidebar */}
          <Sidebar />

          {/* Main Content */}
          <main className="flex-1 p-6 max-w-4xl mx-auto space-y-6">
            {/* Task Header */}
            <div className="flex items-center gap-4 bg-white p-5 rounded-xl shadow">
              <input
                type="checkbox"
                checked={task.is_completed}
                readOnly
                className="h-6 w-6 border-gray-400"
              />

              <h1
                className={`flex-1 text-2xl font-semibold ${
                  task.is_completed ? "line-through text-gray-400" : "text-gray-800"
                }`}
              >
                {task.title}
              </h1>

              {/* Edit Button */}
              <Link
                href={`/tasks/${task.id}/edit`}
                className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition"
              >
                Edit
              </Link>
            </div>

            {/* Description */}
            <div className="bg-white p-5 rounded-xl shadow">
              <h2 className="text-gray-800 font-semibold mb-2">Description</h2>
              <p className="text-gray-700">{task.description || "No description provided."}</p>
            </div>

            {/* Priority */}
            <div className="bg-white p-5 rounded-xl shadow">
              <h2 className="text-gray-800 font-semibold mb-3">Priority</h2>
              <div className="flex gap-3">
                {["low", "medium", "high"].map((level) => (
                  <span
                    key={level}
                    className={`px-3 py-1 rounded-lg text-sm font-medium capitalize
                      ${
                        task.priority === level
                          ? "bg-blue-600 text-white"
                          : "bg-gray-200 text-gray-600"
                      }
                    `}
                  >
                    {level}
                  </span>
                ))}
              </div>
            </div>
          </main>
        </div>
      </div>
    </ProtectedRoute>
  );
}
