"use client";

import { useState } from "react";
import { supabase } from "../lib/supabaseClient";
import { useRouter } from "next/navigation";

export default function LoginPage() {
  const router = useRouter();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [showPass, setShowPass] = useState(false);
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    setLoading(true);

    const { error } = await supabase.auth.signInWithPassword({ email, password });

    setLoading(false);

    if (error) {
      setError(error.message);
    } else {
      router.push("/dashboard");
    }
  };

  return (
    <main className="min-h-screen flex items-center justify-center bg-gray-100 px-4 font-sans">
      <div className="w-full max-w-sm bg-white shadow-lg rounded-2xl p-8 flex flex-col items-center gap-6 border border-gray-200">
        {/* LOGO */}
        <div className="text-center">
          <h1 className="text-4xl font-extrabold tracking-tight text-green-500">
            Clover
          </h1>
          <p className="text-sm mt-1 text-gray-500">Task Manager</p>
        </div>

        {/* HEADLINE */}
        <div className="w-full text-center">
          <h2 className="text-2xl font-semibold text-gray-900">Welcome Back!</h2>
          <p className="text-sm text-gray-500">Enter your credentials to continue</p>
        </div>

        {/* FORM */}
        <form onSubmit={handleLogin} className="flex w-full flex-col gap-4 mt-2">
          {error && <p className="text-red-600 text-sm text-center">{error}</p>}

          {/* EMAIL */}
          <input
            type="email"
            placeholder="Email"
            className="h-12 w-full rounded-xl border border-gray-300 bg-white p-4 text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-green-400 focus:border-green-400"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
          />

          {/* PASSWORD */}
          <div className="flex items-stretch w-full">
            <input
              type={showPass ? "text" : "password"}
              placeholder="Password"
              className="h-12 w-full rounded-l-xl border border-gray-300 p-4 text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-green-400 focus:border-green-400"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
            <button
              type="button"
              onClick={() => setShowPass(!showPass)}
              className="px-4 flex items-center justify-center bg-white rounded-r-xl border border-l-0 border-gray-300"
            >
              <span className="text-xl">{showPass ? "🙈" : "👁️"}</span>
            </button>
          </div>

          {/* LOGIN BUTTON */}
          <button
            type="submit"
            disabled={loading}
            className="h-12 rounded-xl bg-green-500 text-white font-bold text-sm transition-all hover:bg-green-600 active:scale-95 disabled:opacity-50"
          >
            {loading ? "Logging in..." : "Login"}
          </button>
        </form>

        {/* SIGN UP */}
        <p className="mt-3 text-sm text-gray-500">
          Don't have an account?{" "}
          <a href="/register" className="font-bold text-green-500 hover:underline">
            Sign Up
          </a>
        </p>
      </div>
    </main>
  );
}

