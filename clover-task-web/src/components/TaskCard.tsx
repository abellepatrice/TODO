"use client";

import Link from "next/link";
import { Task } from "@/types/task";

interface TaskCardProps {
  task: Task;
}

export default function TaskCard({ task }: TaskCardProps) {
  const priorityColors = {
    high: "bg-red-500",
    medium: "bg-yellow-500",
    low: "bg-blue-500",
  };

  return (
    <Link href={`/tasks/${task.id}`} className="block">
      <div
        className={`flex border rounded-xl shadow-sm overflow-hidden transition-all hover:shadow-md hover:-translate-y-1 ${
          task.is_completed ? "opacity-60" : ""
        }`}
      >
        {/* Priority Color Bar */}
        <div
          className={`w-2 ${priorityColors[task.priority]}`}
        />

        {/* Card Content */}
        <div className="flex-1 p-4 bg-white">
          {/* Title + Priority */}
          <div className="flex items-center justify-between mb-1">
            <h2
              className={`font-semibold text-lg ${
                task.is_completed
                  ? "line-through text-gray-400"
                  : "text-gray-900"
              }`}
            >
              {task.title}
            </h2>

            {/* Priority Badge */}
            <span
              className="text-xs px-2 py-1 rounded-full bg-gray-100 text-gray-700 capitalize"
            >
              {task.priority}
            </span>
          </div>

          {/* Description */}
          <p
            className={`text-gray-600 text-sm line-clamp-2 ${
              task.is_completed ? "line-through" : ""
            }`}
          >
            {task.description}
          </p>

          {/* Footer */}
          <div className="flex justify-between items-center mt-4">
            <input
              type="checkbox"
              checked={task.is_completed}
              readOnly
              className="h-5 w-5 rounded border-2 border-gray-400 checked:bg-green-500 checked:border-green-500"
            />
            <p className="text-xs text-gray-400">
              {new Date(task.created_at).toLocaleDateString()}
            </p>
          </div>
        </div>
      </div>
    </Link>
  );
}


// "use client";

// import Link from "next/link";
// import { Task } from "@/types/task";

// interface TaskCardProps {
//   task: Task;
// }

// export default function TaskCard({ task }: TaskCardProps) {
//   const priorityColors = {
//     high: "bg-red-500",
//     medium: "bg-yellow-500",
//     low: "bg-blue-500",
//   };

//   return (
//     <Link href={`/tasks/${task.id}`} className="block">
//       <div className="relative group">
//         {/* Left Priority Color Bar */}
//         <span
//           className={`absolute left-0 top-0 h-full w-2 rounded-l-xl ${
//             priorityColors[task.priority]
//           }`}
//         />

//         {/* Card */}
//         <div
//           className={`ml-2 p-5 rounded-xl border bg-white shadow-sm transition-all group-hover:shadow-md group-hover:-translate-y-1 ${
//             task.is_completed ? "opacity-60" : ""
//           }`}
//         >
//           {/* Title + Priority */}
//           <div className="flex items-center justify-between mb-1">
//             <h2
//               className={`font-semibold text-lg ${
//                 task.is_completed
//                   ? "line-through text-gray-400"
//                   : "text-gray-900"
//               }`}
//             >
//               {task.title}
//             </h2>

//             {/* Priority badge */}
//             <span
//               className={`text-xs px-2 py-1 rounded-full bg-gray-100 text-gray-700 capitalize`}
//             >
//               {task.priority}
//             </span>
//           </div>

//           {/* Description */}
//           <p
//             className={`text-gray-600 text-sm line-clamp-2 ${
//               task.is_completed ? "line-through" : ""
//             }`}
//           >
//             {task.description}
//           </p>

//           {/* Footer */}
//           <div className="flex justify-between items-center mt-4">
//             <input
//               type="checkbox"
//               checked={task.is_completed}
//               readOnly
//               className="h-5 w-5 rounded border-2 border-gray-400 checked:bg-green-500 checked:border-green-500"
//             />

//             <p className="text-xs text-gray-400">
//               {new Date(task.created_at).toLocaleDateString()}
//             </p>
//           </div>
//         </div>
//       </div>
//     </Link>
//   );
// }

// "use client";

// import Link from "next/link";
// import { Task } from "@/types/task";

// interface TaskCardProps {
//   task: Task;
// }

// export default function TaskCard({ task }: TaskCardProps) {
//   const priorityColors = {
//     high: "bg-red-100 text-red-600",
//     medium: "bg-yellow-100 text-yellow-600",
//     low: "bg-blue-100 text-blue-600",
//   };

//   return (
//     <Link href={`/tasks/${task.id}`} className="block">
//       <div
//         className={`flex flex-col gap-3 p-4 rounded-xl bg-white dark:bg-gray-800 shadow-md hover:shadow-lg transition-transform transform hover:-translate-y-1 ${
//           task.is_completed ? "opacity-50" : ""
//         }`}
//       >
//         <div className="flex justify-between items-center">
//           <h2
//             className={`font-semibold text-lg line-clamp-1 ${
//               task.is_completed ? "line-through text-gray-400" : "text-gray-900 dark:text-white"
//             }`}
//           >
//             {task.title}
//           </h2>
//           <span
//             className={`px-3 py-1 rounded-full text-sm font-medium ${priorityColors[task.priority]}`}
//           >
//             {task.priority.charAt(0).toUpperCase() + task.priority.slice(1)}
//           </span>
//         </div>
//         <p
//           className={`text-gray-500 dark:text-gray-300 text-sm line-clamp-2 ${
//             task.is_completed ? "line-through" : ""
//           }`}
//         >
//           {task.description}
//         </p>
//         <div className="flex items-center justify-between mt-2">
//           <input
//             type="checkbox"
//             checked={task.is_completed}
//             readOnly
//             className="h-5 w-5 rounded-full border-2 border-gray-400 checked:bg-primary checked:border-primary focus:ring-0"
//           />
//           <p className="text-xs text-gray-400">
//             Created: {new Date(task.created_at).toLocaleDateString()}
//           </p>
//         </div>
//       </div>
//     </Link>
//   );
// }


// "use client";

// import Link from "next/link";
// import { Task } from "@/types/task";

// interface TaskCardProps {
//   task: Task;
// }

// export default function TaskCard({ task }: TaskCardProps) {
//   const priorityColors = {
//     high: "bg-red-500/20 text-red-400",
//     mwdium: "bg-yellow-500/20 text-yellow-400",
//     low: "bg-sky-500/20 text-sky-400",
//   };

//   return (
//     <Link href={`/tasks/${task.id}`} className="block">
//       <div className={`flex items-start gap-4 rounded-xl p-4 bg-white dark:bg-[#2C2C2E] transition hover:shadow-lg ${task.is_completed ? "opacity-50" : ""}`}>
//         <div className="flex items-center justify-center">
//           <input
//             type="checkbox"
//             checked={task.is_completed}
//             className="h-5 w-5 rounded-full border-2 border-gray-400 checked:bg-primary checked:border-primary focus:ring-0"
//             readOnly
//           />
//         </div>
//         <div className="flex-1">
//           <div className="flex justify-between items-center gap-2">
//             <p className={`text-base font-medium line-clamp-1 ${task.is_completed ? "line-through text-gray-400" : "text-gray-900 dark:text-white"}`}>
//               {task.title}
//             </p>
//             <div className={`flex items-center justify-center rounded-full px-2 py-1 text-xs font-medium ${priorityColors[task.priority]}`}>
//               {task.priority}
//             </div>
//           </div>
//           <p className={`text-sm line-clamp-2 ${task.is_completed ? "line-through text-gray-400" : "text-gray-500 dark:text-gray-400"}`}>
//             {task.description}
//           </p>
//         </div>
//       </div>
//     </Link>
//   );
// }


// "use client";

// import { Task } from "@/types/task";
// import Link from "next/link";
// import { api } from "../app/lib/api";

// export default function TaskCard({ task }: { task: Task }) {
//   const deleteTask = async () => {
//     await api.deleteTask(task.id);
//     window.location.reload();
//   };

//   return (
//     <div className="bg-white p-4 rounded-lg shadow">
//       <div className="flex justify-between items-start">
//         <h2 className="font-semibold">{task.title}</h2>

//         <span
//           className={`px-2 py-1 rounded text-xs ${
//             task.priority === "high"
//               ? "bg-red-200 text-red-800"
//               : task.priority === "medium"
//               ? "bg-yellow-200 text-yellow-800"
//               : "bg-green-200 text-green-800"
//           }`}
//         >
//           {task.priority}
//         </span>
//       </div>

//       <p className="text-sm text-gray-600">{task.description}</p>

//       <div className="mt-3 flex gap-3">
//         <Link
//           href={`/tasks/create?id=${task.id}`}
//           className="text-blue-600 hover:underline"
//         >
//           Edit
//         </Link>

//         <button
//           onClick={deleteTask}
//           className="text-red-600 hover:underline"
//         >
//           Delete
//         </button>
//       </div>
//     </div>
//   );
// }
