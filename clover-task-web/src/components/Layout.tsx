"use client";
import { useRouter } from "next/navigation";
import Topbar from "./TopBar";
import Sidebar from "./Sidebar";
import { ReactNode } from "react";

interface LayoutProps {
  children: ReactNode;
}

export default function Layout({ children }: LayoutProps) {
  const router = useRouter();
  const onBack = () => {
    // if there's history go back, otherwise go to root
    if (window.history.length > 1) router.back();
    else router.push("/");
  };

  return (
    <div className="flex flex-col min-h-screen">
      <Topbar onBack={onBack} />
      <div className="flex flex-1 overflow-hidden">
        <Sidebar />
        <main className="flex-1 p-4 overflow-y-auto">{children}</main>
      </div>
      <footer className="flex-shrink-0 bg-background-light dark:bg-zinc-800 p-2 border-t border-zinc-200 dark:border-zinc-700">
        <div className="flex justify-around items-center">
          <a className="flex flex-col items-center gap-1 w-1/3 text-primary" href="#">
            <span className="material-symbols-outlined">speed</span>
            <span className="text-xs">Dashboard</span>
          </a>
          <a className="flex flex-col items-center gap-1 w-1/3 text-zinc-500 dark:text-zinc-400" href="#">
            <span className="material-symbols-outlined">calendar_today</span>
            <span className="text-xs">Calendar</span>
          </a>
          <a className="flex flex-col items-center gap-1 w-1/3 text-zinc-500 dark:text-zinc-400" href="#">
            <span className="material-symbols-outlined">settings</span>
            <span className="text-xs">Settings</span>
          </a>
        </div>
      </footer>
    </div>
  );
}
