"use client";

import Link from "next/link";
import { Task } from "@/types/task";

interface TaskCardProps {
  task: Task;
}

export default function TaskCard({ task }: TaskCardProps) {
  const priorityColors = {
    high: "bg-red-500/20 text-red-400",
    mwdium: "bg-yellow-500/20 text-yellow-400",
    low: "bg-sky-500/20 text-sky-400",
  };

  return (
    <Link href={`/tasks/${task.id}`} className="block">
      <div className={`flex items-start gap-4 rounded-xl p-4 bg-white dark:bg-[#2C2C2E] transition hover:shadow-lg ${task.is_completed ? "opacity-50" : ""}`}>
        <div className="flex items-center justify-center">
          <input
            type="checkbox"
            checked={task.is_completed}
            className="h-5 w-5 rounded-full border-2 border-gray-400 checked:bg-primary checked:border-primary focus:ring-0"
            readOnly
          />
        </div>
        <div className="flex-1">
          <div className="flex justify-between items-center gap-2">
            <p className={`text-base font-medium line-clamp-1 ${task.is_completed ? "line-through text-gray-400" : "text-gray-900 dark:text-white"}`}>
              {task.title}
            </p>
            <div className={`flex items-center justify-center rounded-full px-2 py-1 text-xs font-medium ${priorityColors[task.priority]}`}>
              {task.priority}
            </div>
          </div>
          <p className={`text-sm line-clamp-2 ${task.is_completed ? "line-through text-gray-400" : "text-gray-500 dark:text-gray-400"}`}>
            {task.description}
          </p>
        </div>
      </div>
    </Link>
  );
}


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
