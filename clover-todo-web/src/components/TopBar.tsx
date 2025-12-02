"use client";
import { useEffect, useState } from "react";

interface TopbarProps {
  onBack: () => void; // <-- explicitly type it
}

export default function Topbar({ onBack }: TopbarProps) {
  const [dark, setDark] = useState(
    typeof window !== "undefined" && localStorage.getItem("theme") === "dark"
  );

  useEffect(() => {
    const root = document.documentElement;
    if (dark) {
      root.classList.add("dark");
      localStorage.setItem("theme", "dark");
    } else {
      root.classList.remove("dark");
      localStorage.setItem("theme", "light");
    }
  }, [dark]);

  return (
    <header className="flex-shrink-0 bg-background-light dark:bg-zinc-800 p-4 border-b border-zinc-200 dark:border-zinc-700">
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <button
            onClick={onBack}
            aria-label="Go back"
            className="p-2 rounded-md hover:bg-zinc-200 dark:hover:bg-zinc-700"
          >
            <span className="material-symbols-outlined">arrow_back</span>
          </button>
          <h1 className="text-xl font-bold text-zinc-800 dark:text-white">
            Todo Dashboard
          </h1>
        </div>
        {/* Dark mode toggle... */}
      </div>
    </header>
  );
}
