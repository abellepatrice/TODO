"use client";

import { useEffect, useState } from "react";
import ProtectedRoute from "@/components/ProtectedRoute";
import Navbar from "@/components/Navbar";
import { api } from "../lib/api";
import TaskCard from "../../components/TaskCard";
import Link from "next/link";
import { Task } from "@/types/task";

export default function TasksPage() {
  const [tasks, setTasks] = useState<Task[]>([]);

  useEffect(() => {
    api.getTasks().then((res) =>{
        console.log("RESPONSE FROM BACKEND:", res.data); 
        setTasks(res.data)});
  }, []);

  return (
    <ProtectedRoute>
      <Navbar />

      <main className="p-6">
        <div className="flex justify-between items-center mb-4">
          <h1 className="text-xl font-bold">Tasks</h1>

          <Link
            href="/tasks/create"
            className="bg-blue-600 text-white px-4 py-2 rounded-lg"
          >
            + New Task
          </Link>
        </div>

        <div className="grid gap-4">
          {tasks.map((task) => (
            <TaskCard key={task.id} task={task} />
          ))}
        </div>
      </main>
    </ProtectedRoute>
  );
}
