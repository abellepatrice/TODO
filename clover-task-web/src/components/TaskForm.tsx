"use client";

import { useState, useEffect } from "react";
import { Task } from "@/types/task";

interface TaskFormProps {
  initialTask?: Task;
  onSave: (task: {
    title: string;
    description: string;
    priority: "low" | "medium" | "high";
  }) => void;
}

export default function TaskForm({ initialTask, onSave }: TaskFormProps) {
  const [title, setTitle] = useState(initialTask?.title || "");
  const [description, setDescription] = useState(initialTask?.description || "");
  const [priority, setPriority] = useState(initialTask?.priority || "low");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    onSave({ title, description, priority });
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-4 bg-white p-6 rounded shadow">
      <input
        type="text"
        placeholder="Title"
        className="w-full p-2 border rounded"
        value={title}
        onChange={(e) => setTitle(e.target.value)}
        required
      />

      <textarea
        placeholder="Description"
        className="w-full p-2 border rounded"
        value={description}
        onChange={(e) => setDescription(e.target.value)}
        rows={3}
      />

      <select
        className="w-full p-2 border rounded"
        value={priority}
        onChange={(e) => setPriority(e.target.value as "low" | "medium" | "high")}
      >
        <option value="low">Low</option>
        <option value="medium">Medium</option>
        <option value="high">High</option>
      </select>

      <button type="submit" className="w-full bg-blue-600 text-white p-2 rounded-lg">
        Save
      </button>
    </form>
  );
}
