"use client";

import { useEffect, useState } from "react";
import ProtectedRoute from "@/components/ProtectedRoute";
import Navbar from "@/components/Navbar";
import Sidebar from "@/components/Sidebar";
import { api } from "../../lib/api";
import { useSearchParams, useRouter } from "next/navigation";
import BackButton from "@/components/Back Button";

export default function CreateTaskPage() {
  const params = useSearchParams();
  const router = useRouter();

  const taskId = params.get("id");

  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [priority, setPriority] = useState("low");

  useEffect(() => {
    if (taskId) {
      api.getTask(taskId).then((res) => {
        const t = res.data;
        setTitle(t.title);
        setDescription(t.description);
        setPriority(t.priority);
      });
    }
  }, [taskId]);

  const handleSave = async (e: any) => {
    e.preventDefault();
    const payload = { title, description, priority };
    if (taskId) await api.updateTask(taskId, payload);
    else await api.createTask(payload);
    router.push("/tasks");
  };

  return (
    <ProtectedRoute>
      <div className="min-h-screen flex flex-col bg-gray-50">
        <Navbar />
        <div className="flex flex-1">
          {/* Responsive Sidebar */}
          <Sidebar />

          {/* Main Content */}
          <main className="flex-1 px-4 py-10 max-w-lg mx-auto font-display">

            {/* Title */}
            <h1 className="text-3xl font-bold text-gray-900 mb-6 tracking-tight">
              {taskId ? "Edit Task ✏️" : "Create New Task 📝"}
            </h1>

            {/* Card/Form */}
            <form
              onSubmit={handleSave}
              className="bg-white rounded-2xl shadow-lg border border-gray-200 p-6 space-y-5"
            >
              {/* Task Title */}
              <div className="flex flex-col gap-1">
                <label className="text-sm font-medium text-gray-900">Task Title</label>
                <input
                  type="text"
                  placeholder="Enter task title"
                  className="h-12 w-full rounded-xl border border-gray-300 bg-white
                  px-4 text-sm text-gray-900 placeholder:text-gray-400
                  focus:ring-2 focus:ring-green-400 focus:border-green-400 transition"
                  value={title}
                  onChange={(e) => setTitle(e.target.value)}
                  required
                />
              </div>

              {/* Description */}
              <div className="flex flex-col gap-1">
                <label className="text-sm font-medium text-gray-900">Description</label>
                <textarea
                  placeholder="Describe your task..."
                  className="w-full rounded-xl border border-gray-300 bg-white
                  px-4 py-3 text-sm text-gray-900 placeholder:text-gray-400
                  focus:ring-2 focus:ring-green-400 focus:border-green-400 transition"
                  rows={4}
                  value={description}
                  onChange={(e) => setDescription(e.target.value)}
                />
              </div>

              {/* Priority Select */}
              <div className="flex flex-col gap-1">
                <label className="text-sm font-medium text-gray-900">Priority</label>
                <select
                  className="h-12 w-full rounded-xl border border-gray-300 bg-white 
                  px-4 text-sm text-gray-900 focus:ring-2 focus:ring-green-400
                  focus:border-green-400 appearance-none transition"
                  value={priority}
                  onChange={(e) => setPriority(e.target.value)}
                >
                  <option value="low">🟢 Low</option>
                  <option value="medium">🟡 Medium</option>
                  <option value="high">🔴 High</option>
                </select>
              </div>

              {/* Save Button */}
              <button
                type="submit"
                className="h-12 w-full rounded-xl bg-green-400 text-gray-900 font-bold text-sm
                hover:bg-green-500 active:scale-95 transition-all"
              >
                {taskId ? "Update Task" : "Create Task"}
              </button>
            </form>
          </main>
        </div>
      </div>
    </ProtectedRoute>
  );
}


// "use client";

// import { useEffect, useState } from "react";
// import ProtectedRoute from "@/components/ProtectedRoute";
// import Navbar from "@/components/Navbar";
// import Sidebar from "@/components/Sidebar";
// import { api } from "../../lib/api";
// import { useSearchParams, useRouter } from "next/navigation";
// import BackButton from "@/components/Back Button";

// export default function CreateTaskPage() {
//   const params = useSearchParams();
//   const router = useRouter();

//   const taskId = params.get("id");

//   const [title, setTitle] = useState("");
//   const [description, setDescription] = useState("");
//   const [priority, setPriority] = useState("low");

//   useEffect(() => {
//     if (taskId) {
//       api.getTask(taskId).then((res) => {
//         const t = res.data;
//         setTitle(t.title);
//         setDescription(t.description);
//         setPriority(t.priority);
//       });
//     }
//   }, [taskId]);

//   const handleSave = async (e: any) => {
//     e.preventDefault();

//     const payload = { title, description, priority };

//     if (taskId) await api.updateTask(taskId, payload);
//     else await api.createTask(payload);

//     router.push("/tasks");
//   };

//  return (
//   <ProtectedRoute>
//     <Navbar />
//     <Sidebar />
//     <BackButton />
//     <main className="px-4 py-10 max-w-lg mx-auto font-display">
                  
        
//      {/* Title */}
//       <h1 className="text-3xl font-bold text-[#1C1C1E] mb-6 tracking-tight">
//         {taskId ? "Edit Task ✏️" : "Create New Task 📝"}
//       </h1>

//       {/* Card */}
//       <form
//         onSubmit={handleSave}
//         className="bg-white rounded-2xl shadow-lg border border-[#E5E5EA] p-6 space-y-5"
//       >
//         {/* Title Input */}
//         <div className="flex flex-col gap-1">
//           <label className="text-sm font-medium text-[#1C1C1E]">
//             Task Title
//           </label>
//           <input
//             type="text"
//             placeholder="Enter task title"
//             className="h-12 w-full rounded-xl border border-[#D1D1D6] bg-white
//             px-4 text-sm text-[#1C1C1E] placeholder:text-[#8A8A8E]
//             focus:ring-2 focus:ring-[#7ae615] focus:border-[#7ae615] transition"
//             value={title}
//             onChange={(e) => setTitle(e.target.value)}
//             required
//           />
//         </div>

//         {/* Description */}
//         <div className="flex flex-col gap-1 form-control">
//           <label className="text-sm font-medium text-[#1C1C1E]">
//             Description
//           </label>
//           <textarea
//             placeholder="Describe your task..."
//             className="w-full rounded-xl border border-[#D1D1D6] bg-white
//             px-4 py-3 text-sm text-[#1C1C1E] placeholder:text-[#8A8A8E]
//             focus:ring-2 focus:ring-[#7ae615] focus:border-[#7ae615] transition"
//             rows={4}
//             value={description}
//             onChange={(e) => setDescription(e.target.value)}
//           />
//         </div>

//         {/* Priority Select */}
//         <div className="flex flex-col gap-1">
//           <label className="text-sm font-medium text-[#1C1C1E]">
//             Priority
//           </label>

//           <select
//             className="h-12 w-full rounded-xl border border-[#D1D1D6] bg-white 
//             px-4 text-sm text-[#1C1C1E] focus:ring-2 focus:ring-[#7ae615]
//             focus:border-[#7ae615] appearance-none transition"
//             value={priority}
//             onChange={(e) => setPriority(e.target.value)}
//           >
//             <option value="low">🟢 Low</option>
//             <option value="medium">🟡 Medium</option>
//             <option value="high">🔴 High</option>
//           </select>
//         </div>

//         {/* Save Button */}
//         <button
//           type="submit"
//           className="h-12 w-full rounded-xl bg-[#7ae615] text-[#1C1C1E] font-bold text-sm
//           hover:bg-[#6dd514] active:scale-95 transition-all"
//         >
//           {taskId ? "Update Task" : "Create Task"}
//         </button>
//       </form>
//     </main>
//   </ProtectedRoute>
// );

// }
