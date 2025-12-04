
"use client";

import { useState } from "react";
import { supabase } from "../lib/supabaseClient";
import { useRouter } from "next/navigation";

export default function RegisterPage() {
  const router = useRouter();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirm, setConfirm] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const handleRegister = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");

    if (password !== confirm) {
      setError("Passwords do not match");
      return;
    }

    setLoading(true);
    const { error } = await supabase.auth.signUp({ email, password });
    setLoading(false);

    if (error) {
      setError(error.message);
    } else {
      router.push("/dashboard");
    }
  };

  return (
    <main className="min-h-screen flex items-center justify-center bg-gray-100 px-4 font-sans">
      <div className="w-full max-w-sm bg-white shadow-lg rounded-2xl p-8 flex flex-col gap-6 border border-gray-200">
         {/* LOGO */}
        <div className="text-center">
          <h1 className="text-4xl font-extrabold tracking-tight text-green-500">
            Clover
          </h1>
          <p className="text-sm mt-1 text-gray-500">Task Manager</p>
        </div>

        <h1 className="text-3xl font-bold text-gray-900 text-center">Create Account</h1>

        {error && <p className="text-red-600 text-sm text-center">{error}</p>}

        <form onSubmit={handleRegister} className="flex flex-col gap-4 mt-2">
          <input
            type="email"
            placeholder="Email"
            className="h-12 w-full rounded-xl border border-gray-300 p-4 text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-green-400 focus:border-green-400"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
          />

          <input
            type="password"
            placeholder="Password"
            className="h-12 w-full rounded-xl border border-gray-300 p-4 text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-green-400 focus:border-green-400"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
          />

          <input
            type="password"
            placeholder="Confirm Password"
            className="h-12 w-full rounded-xl border border-gray-300 p-4 text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-green-400 focus:border-green-400"
            value={confirm}
            onChange={(e) => setConfirm(e.target.value)}
            required
          />

          <button
            type="submit"
            disabled={loading}
            className="h-12 w-full rounded-xl bg-green-500 text-white font-bold text-sm hover:bg-green-600 active:scale-95 transition disabled:opacity-50"
          >
            {loading ? "Creating account..." : "Register"}
          </button>
        </form>

        <p className="mt-3 text-sm text-gray-500 text-center">
          Already have an account?{" "}
          <a href="/login" className="font-bold text-green-500 hover:underline">
            Login
          </a>
        </p>
      </div>
    </main>
  );
}
