"use client";

import { useEffect, useState } from "react";
import { useParams } from "next/navigation";
import ProtectedRoute from "@/components/ProtectedRoute";
import Navbar from "@/components/Navbar";
import { api } from "../app/lib/api";
import { Task } from "@/types/task";

export default function TaskDetailPage() {
  const { id } = useParams();
  const [task, setTask] = useState<Task | null>(null);

  useEffect(() => {
    api.getTask(id).then(res => setTask(res.data));
  }, [id]);

  if (!task) return <p className="p-6 text-gray-700 dark:text-gray-200">Loading...</p>;

  return (
    <ProtectedRoute>
      <div className="min-h-screen bg-background-light dark:bg-background-dark">
        <Navbar />

        <main className="p-6 max-w-2xl mx-auto space-y-6">
          {/* Title & Completion */}
          <div className="flex items-center gap-4 bg-surface-dark p-4 rounded-xl">
            <input
              type="checkbox"
              checked={task.is_complete}
              className="h-6 w-6 rounded-full border-2 border-text-secondary-dark checked:bg-primary focus:ring-2 focus:ring-primary/50"
            />
            <h1 className={`flex-1 text-xl font-medium ${task.is_complete ? "line-through text-gray-400" : "text-text-primary-dark"}`}>
              {task.title}
            </h1>
          </div>

          {/* Description */}
          <div>
            <label className="text-text-primary-dark font-medium mb-2 block">Description</label>
            <textarea
              readOnly
              value={task.description}
              className="w-full rounded-xl p-4 bg-surface-dark text-text-primary-dark border-none resize-none min-h-[120px]"
            />
          </div>

          {/* Priority */}
          <div>
            <p className="text-text-primary-dark font-medium mb-2">Priority</p>
            <div className="flex gap-2">
              {["Low", "Medium", "High"].map(level => (
                <span
                  key={level}
                  className={`px-3 py-1 rounded-xl text-sm font-medium ${
                    task.priority === level ? "bg-primary text-background-dark" : "bg-surface-dark text-text-secondary-dark"
                  }`}
                >
                  {level}
                </span>
              ))}
            </div>
          </div>
        </main>
      </div>
    </ProtectedRoute>
  );
}
