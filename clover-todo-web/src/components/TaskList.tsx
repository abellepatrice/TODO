"use client";
import { useState } from "react";

export default function TaskList({ initial = [] }) {
  const [tasks, setTasks] = useState(initial);

  const add = (task) => setTasks((s)=>[task, ...s]);
  const toggleDone = (idx) => {
    setTasks((s)=> s.map((t,i)=> i===idx ? {...t, done: !t.done} : t));
  };

  return (
    <div>
      {tasks.length === 0 ? (
        <p className="text-zinc-500">No tasks yet — create one!</p>
      ) : (
        <div className="space-y-3">
          {tasks.map((t, i) => (
            <div key={i} className="flex items-center gap-4 p-3 bg-white dark:bg-zinc-900 rounded-lg border border-zinc-100 dark:border-zinc-800">
              <button onClick={()=>toggleDone(i)} className={`w-6 h-6 rounded-md ${t.done ? "bg-primary" : "border-2 border-zinc-400"}`}></button>
              <div className="flex-grow">
                <p className={`font-medium ${t.done ? "line-through text-zinc-400" : "text-zinc-800 dark:text-white"}`}>{t.title}</p>
                <p className="text-sm text-zinc-500 dark:text-zinc-400">{t.due ? new Date(t.due).toLocaleString() : "No due date"}</p>
              </div>
              <span className="text-xs font-semibold px-3 py-1 rounded-full bg-red-200 text-red-800 dark:bg-red-500 dark:text-white">
                {t.priority?.toUpperCase() || "LOW"}
              </span>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
