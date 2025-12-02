"use client";
import { useState } from "react";

export default function CreateTask({ onCancel, onSubmit }) {
  const [title, setTitle] = useState("");
  const [details, setDetails] = useState("");
  const [priority, setPriority] = useState("low");
  const [due, setDue] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();
    const task = { title, details, priority, due, createdAt: new Date().toISOString() };
    if (onSubmit) onSubmit(task);
    // reset
    setTitle(""); setDetails(""); setPriority("low"); setDue("");
  };

  return (
    <form onSubmit={handleSubmit} className="max-w-2xl">
      <div className="form-control mb-3">
        <label htmlFor="title">Title</label>
        <input id="title" required value={title} onChange={(e)=>setTitle(e.target.value)} placeholder="e.g. Submit project report" />
      </div>

      <div className="form-control mb-3">
        <label htmlFor="details">Details</label>
        <textarea id="details" rows="4" value={details} onChange={(e)=>setDetails(e.target.value)} placeholder="Add more info..." />
      </div>

      <div className="flex gap-3">
        <div className="form-control flex-1">
          <label htmlFor="priority">Priority</label>
          <select id="priority" value={priority} onChange={(e)=>setPriority(e.target.value)}>
            <option value="low">Low</option>
            <option value="medium">Medium</option>
            <option value="high">High</option>
          </select>
        </div>

        <div className="form-control">
          <label htmlFor="due">Due</label>
          <input id="due" type="date" value={due} onChange={(e)=>setDue(e.target.value)} />
        </div>
      </div>

      <div className="form-actions mt-4">
        <button type="submit" className="px-4 py-2 rounded-lg bg-primary text-black font-medium">Save</button>
        <button type="button" onClick={onCancel} className="px-4 py-2 rounded-lg border border-zinc-200 dark:border-zinc-700">Return</button>
      </div>
    </form>
  );
}
