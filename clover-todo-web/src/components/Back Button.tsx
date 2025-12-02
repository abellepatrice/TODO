"use client";

import { useRouter } from "next/navigation";

export default function BackButton() {
  const router = useRouter();

  return (
    <button
      onClick={() => router.back()}
      className="flex items-center gap-2 text-[#1C1C1E] font-large text-sm
      hover:opacity-70 transition"
    >
      ← Back
    </button>
  );
}
