// "use client";

// import ProtectedRoute from "@/components/ProtectedRoute";
// import Layout from "@/components/Layout";
// import TaskList from "@/components/TaskList";
// import Link from "next/link";

// export default function DashboardPage() {
//   const tasks = [
//     { title: "Submit project report", priority: "high", due: "2025-12-03", done: false },
//     { title: "Schedule dentist appt", priority: "medium", due: "2025-12-04", done: true },
//     { title: "Buy groceries", priority: "low", due: "2025-12-02", done: true },
//   ];

//   return (
//     <ProtectedRoute>
//       <Layout>
//         <div className="flex items-center justify-between mb-6">
//           <h2 className="text-2xl font-bold text-zinc-800 dark:text-white">Upcoming tasks</h2>
//           <Link
//             href="/tasks/create"
//             className="px-4 py-2 rounded-lg bg-primary text-black font-medium"
//           >
//             Create Task
//           </Link>
//         </div>

//         <TaskList initial={tasks} />
//       </Layout>
//     </ProtectedRoute>
//   );
// }
