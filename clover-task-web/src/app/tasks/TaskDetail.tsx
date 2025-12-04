"use client";

import { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import ProtectedRoute from "@/components/ProtectedRoute";
import Navbar from "@/components/Navbar";
import { api } from "../lib/api";
import { Task } from "@/types/task";
import { PencilIcon, TrashIcon, CheckCircleIcon, CheckIcon } from "@heroicons/react/24/solid";

export default function TaskDetailPage() {
  const params = useParams() as { id: string }; 
  const router = useRouter();
  const [task, setTask] = useState<Task | null>(null);
  const [isEditing, setIsEditing] = useState(false);
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [priority, setPriority] = useState<"low" | "medium" | "high">("low");
  const [isCompleted, setIsCompleted] = useState(false);

  const taskId = params.id;

  useEffect(() => {
    if (!taskId) return;
    api.getTask(taskId).then(res => {
      const t = res.data;
      setTask(t);
      setTitle(t.title);
      setDescription(t.description);
      setPriority(t.priority);
      setIsCompleted(t.is_completed);
    });
  }, [taskId]);

  if (!task) return <p className="p-6 text-gray-700 dark:text-gray-200">Loading...</p>;

  // Handlers
  const handleSave = async () => {
    await api.updateTask(taskId, { title, description, priority, is_completed: isCompleted });
    setIsEditing(false);
    setTask({ ...task, title, description, priority, is_completed: isCompleted });
  };

  const handleDelete = async () => {
    if (confirm("Are you sure you want to delete this task?")) {
      await api.deleteTask(taskId);
      router.push("/dashboard");
    }
  };

  const toggleComplete = async () => {
    const newCompleted = !isCompleted;
    setIsCompleted(newCompleted);
    await api.updateTask(taskId, { is_completed: newCompleted });
    setTask({ ...task, is_completed: newCompleted });
  };

  return (
    <ProtectedRoute>
      <div className="min-h-screen bg-background-light dark:bg-background-dark">
        <Navbar />

        <main className="p-6 max-w-2xl mx-auto space-y-6">

          {/* Title & Actions */}
          <div className="flex items-center gap-4 bg-surface-dark p-4 rounded-xl">
            <input
              type="checkbox"
              checked={isCompleted}
              onChange={toggleComplete}
              className="h-6 w-6 rounded-full border-2 border-gray-400 checked:bg-primary focus:ring-2 focus:ring-primary/50"
            />
            {isEditing ? (
              <input
                value={title}
                onChange={e => setTitle(e.target.value)}
                className="flex-1 text-xl font-medium rounded-lg p-2 border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-text-primary-dark"
              />
            ) : (
              <h1 className={`flex-1 text-xl font-medium ${isCompleted ? "line-through text-gray-400" : "text-text-primary-dark"}`}>
                {title}
              </h1>
            )}

            {/* Edit / Save */}
            {isEditing ? (
              <button onClick={handleSave} className="p-2 rounded-lg bg-green-500 hover:bg-green-600 text-white">
                <CheckIcon className="h-5 w-5" />
              </button>
            ) : (
              <button onClick={() => setIsEditing(true)} className="p-2 rounded-lg bg-blue-500 hover:bg-blue-600 text-white">
                <PencilIcon className="h-5 w-5" />
              </button>
            )}

            {/* Delete */}
            <button onClick={handleDelete} className="p-2 rounded-lg bg-red-500 hover:bg-red-600 text-white">
              <TrashIcon className="h-5 w-5" />
            </button>
          </div>

          {/* Description */}
          <div>
            <label className="text-text-primary-dark font-medium mb-2 block">Description</label>
            {isEditing ? (
              <textarea
                value={description}
                onChange={e => setDescription(e.target.value)}
                className="w-full rounded-xl p-4 bg-white dark:bg-gray-800 text-text-primary-dark border border-gray-300 dark:border-gray-600 resize-none min-h-[120px]"
              />
            ) : (
              <p className="p-4 bg-white dark:bg-gray-800 rounded-xl border border-gray-300 dark:border-gray-600 min-h-[120px] text-text-primary-dark">{description}</p>
            )}
          </div>

          {/* Priority */}
          <div>
            <p className="text-text-primary-dark font-medium mb-2">Priority</p>
            <div className="flex gap-2">
              {["low", "medium", "high"].map(level => (
                <button
                  key={level}
                  disabled={!isEditing}
                  onClick={() => setPriority(level as "low" | "medium" | "high")}
                  className={`px-4 py-2 rounded-xl text-sm font-medium transition-colors duration-200 ${
                    priority === level ? "bg-primary text-background-dark" : "bg-surface-dark text-text-secondary-dark"
                  } ${!isEditing ? "opacity-50 cursor-not-allowed" : ""}`}
                >
                  {level.charAt(0).toUpperCase() + level.slice(1)}
                </button>
              ))}
            </div>
          </div>
        </main>
      </div>
    </ProtectedRoute>
  );
}
