"use client";

import { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import ProtectedRoute from "@/components/ProtectedRoute";
import Navbar from "@/components/Navbar";
import Sidebar from "@/components/Sidebar";
import { api } from "../../../lib/api";
import { Task } from "@/types/task";

export default function EditTaskPage() {
  const { id } = useParams();
  const router = useRouter();
  const [task, setTask] = useState<Task | null>(null);
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [priority, setPriority] = useState<"low" | "medium" | "high">("low");
  const [isCompleted, setIsCompleted] = useState(false);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    api.getTask(id).then(res => {
      const data = res.data;
      setTask(data);
      setTitle(data.title);
      setDescription(data.description);
      setPriority(data.priority);
      setIsCompleted(data.is_completed);
      setLoading(false);
    });
  }, [id]);

  const handleSave = async () => {
    if (!task) return;
    setSaving(true);
    try {
      await api.updateTask(id, {
        title,
        description,
        priority,
        is_completed: isCompleted,
      });
      router.push(`/tasks/${id}?edited=true`);
    } catch (err) {
      console.error("Failed to update task:", err);
    } finally {
      setSaving(false);
    }
  };

  const handleDelete = async () => {
    const confirmed = confirm("Are you sure you want to delete this task?");
    if (!confirmed) return;
    try {
      await api.deleteTask(id);
      router.push("/dashboard");
    } catch (err) {
      console.error("Failed to delete task:", err);
    }
  };

  if (loading) return <p className="p-6 text-gray-700">Loading...</p>;

  const priorityStyles = {
    low: "bg-blue-500 text-white",
    medium: "bg-yellow-400 text-black",
    high: "bg-red-500 text-white",
  };

  return (
    <ProtectedRoute>
      <div className="min-h-screen flex bg-gray-50">
        {/* Sidebar */}
        <Sidebar />

        <div className="flex-1 flex flex-col">
          {/* Navbar */}
          <Navbar />

          {/* Main Content */}
          <main className="p-6 max-w-2xl mx-auto space-y-6 w-full">
            <h1 className="text-2xl font-bold text-gray-900">Edit Task</h1>

            {/* Title */}
            <div className="flex flex-col">
              <label className="mb-2 font-medium text-gray-700">Title</label>
              <input
                type="text"
                value={title}
                onChange={e => setTitle(e.target.value)}
                className="w-full p-4 rounded-xl border border-gray-300 bg-white text-gray-900 focus:outline-none focus:ring-2 focus:ring-primary"
              />
            </div>

            {/* Description */}
            <div className="flex flex-col">
              <label className="mb-2 font-medium text-gray-700">Description</label>
              <textarea
                value={description}
                onChange={e => setDescription(e.target.value)}
                className="w-full p-4 rounded-xl border border-gray-300 bg-white text-gray-900 min-h-[120px] focus:outline-none focus:ring-2 focus:ring-primary"
              />
            </div>

            {/* Priority */}
            <div className="flex flex-col">
              <label className="mb-2 font-medium text-gray-700">Priority</label>
              <div className="flex gap-2">
                {(["low", "medium", "high"] as const).map(level => (
                  <button
                    key={level}
                    type="button"
                    onClick={() => setPriority(level)}
                    className={`px-4 py-2 rounded-xl font-medium transition ${
                      priority === level
                        ? `${priorityStyles[level]} shadow-md`
                        : "bg-gray-200 text-gray-700 hover:opacity-80"
                    }`}
                  >
                    {level.charAt(0).toUpperCase() + level.slice(1)}
                  </button>
                ))}
              </div>
            </div>

            {/* Completion */}
            <div className="flex items-center gap-4 mt-4">
              <label className="flex items-center gap-2 text-gray-700">
                <input
                  type="checkbox"
                  checked={isCompleted}
                  onChange={e => setIsCompleted(e.target.checked)}
                  className="h-6 w-6 rounded-full border-2 border-gray-400 checked:bg-primary focus:ring-0"
                />
                Mark as Completed
              </label>
            </div>

            {/* Action Buttons */}
            <div className="flex gap-4 mt-6">
              <button
                onClick={handleSave}
                disabled={saving}
                className="flex-1 bg-primary text-black py-4 rounded-xl font-bold hover:opacity-90 transition disabled:opacity-50"
              >
                {saving ? "Saving..." : "Save Changes"}
              </button>
              <button
                onClick={handleDelete}
                className="flex-1 bg-red-500 text-white py-4 rounded-xl font-bold hover:opacity-90 transition"
              >
                Delete Task
              </button>
            </div>
          </main>
        </div>
      </div>
    </ProtectedRoute>
  );
}
