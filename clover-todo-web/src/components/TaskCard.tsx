"use client";

import { Task } from "@/types/task";
import Link from "next/link";
import { api } from "../app/lib/api";

export default function TaskCard({ task }: { task: Task }) {
  const deleteTask = async () => {
    await api.deleteTask(task.id);
    window.location.reload();
  };

  return (
    <div className="bg-white p-4 rounded-lg shadow">
      <div className="flex justify-between items-start">
        <h2 className="font-semibold">{task.title}</h2>

        <span
          className={`px-2 py-1 rounded text-xs ${
            task.priority === "high"
              ? "bg-red-200 text-red-800"
              : task.priority === "medium"
              ? "bg-yellow-200 text-yellow-800"
              : "bg-green-200 text-green-800"
          }`}
        >
          {task.priority}
        </span>
      </div>

      <p className="text-sm text-gray-600">{task.description}</p>

      <div className="mt-3 flex gap-3">
        <Link
          href={`/tasks/create?id=${task.id}`}
          className="text-blue-600 hover:underline"
        >
          Edit
        </Link>

        <button
          onClick={deleteTask}
          className="text-red-600 hover:underline"
        >
          Delete
        </button>
      </div>
    </div>
  );
}
