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

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");

    const { error } = await supabase.auth.signInWithPassword({
      email,
      password,
    });

    if (error) {
      setError(error.message);
    } else {
      router.push("/dashboard");
    }
  };

 return (
  <main className="min-h-screen flex items-center justify-center bg-[#F5F5F7] dark:bg-[#1C1C1E] px-4 font-display">
    <div className="w-full max-w-sm bg-white dark:bg-[#2C2C2E] shadow-lg rounded-2xl p-8 flex flex-col items-center gap-6 border border-[#E5E5EA] dark:border-[#3A3A3C]">
      
      {/* LOGO */}
      <div className="text-center">
        <h1
          className="text-4xl font-extrabold tracking-tight"
          style={{
            color: "#7ae615",
            letterSpacing: "-1px",
            fontFamily: "Plus Jakarta Sans, sans-serif",
          }}
        >
          Clover
        </h1>
        <p className="text-sm mt-1 text-[#8A8A8E] dark:text-gray-400">Task Manager</p>
      </div>

      {/* HEADLINE */}
      <div className="w-full text-center">
        <h2 className="text-2xl font-semibold text-[#1C1C1E] dark:text-white">
          Welcome Back!
        </h2>
        <p className="text-sm text-[#8A8A8E] dark:text-gray-400">
          Enter your credentials to continue
        </p>
      </div>

      {/* FORM */}
      <form onSubmit={handleLogin} className="flex w-full flex-col gap-4 mt-2">
        {error && (
          <p className="text-red-600 text-sm -mt-2 text-center">{error}</p>
        )}

        {/* EMAIL */}
        <label className="flex flex-col gap-1">
          <span className="text-sm font-medium text-[#1C1C1E] dark:text-gray-300">
            Email
          </span>
          <input
            type="email"
            placeholder="Enter your email"
            className="h-12 w-full rounded-xl border border-[#D1D1D6] bg-white 
            p-4 text-sm text-[#1C1C1E] placeholder:text-[#8A8A8E]
            focus:ring-2 focus:ring-[#7ae615] focus:border-[#7ae615]
            dark:border-gray-600 dark:bg-gray-800 
            dark:text-white dark:placeholder:text-gray-400"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
          />
        </label>

        {/* PASSWORD */}
        <label className="flex flex-col gap-1">
          <div className="flex items-center justify-between">
            <span className="text-sm font-medium text-[#1C1C1E] dark:text-gray-300">
              Password
            </span>
            <a
              href="#"
              className="text-xs font-semibold text-[#7ae615] hover:opacity-80"
            >
              Forgot?
            </a>
          </div>

          <div className="flex items-stretch w-full">
            <input
              type={showPass ? "text" : "password"}
              placeholder="Enter your password"
              className="h-12 w-full rounded-l-xl border border-[#D1D1D6] 
              bg-white p-4 text-sm text-[#1C1C1E] placeholder:text-[#8A8A8E]
              focus:ring-2 focus:ring-[#7ae615] focus:border-[#7ae615]
              dark:border-gray-600 dark:bg-gray-800 dark:text-white
              dark:placeholder:text-gray-400"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />

            <button
              type="button"
              onClick={() => setShowPass(!showPass)}
              className="px-4 flex items-center justify-center bg-white rounded-r-xl 
              border border-l-0 border-[#D1D1D6] dark:border-gray-600 
              dark:bg-gray-800 dark:text-gray-300"
            >
              <span className="text-xl">
                {showPass ? "🙈" : "👁️"}
              </span>
            </button>
          </div>
        </label>

        {/* LOGIN BUTTON */}
        <button
          type="submit"
          className="h-12 rounded-xl bg-[#7ae615] text-[#1C1C1E] 
          font-bold text-sm transition-all hover:bg-[#6ad714] active:scale-95"
        >
          Login
        </button>
      </form>

      {/* SIGN UP */}
      <div className="pt-2 text-center">
        <p className="text-sm text-[#8A8A8E] dark:text-gray-400">
          Don't have an account?{" "}
          <a
            href="/register"
            className="font-bold text-[#7ae615] hover:underline"
          >
            Sign Up
          </a>
        </p>
      </div>
    </div>
  </main>
);

}


// "use client";

// import { useState } from "react";
// import { supabase } from "../lib/supabaseClient";
// import { useRouter } from "next/navigation";

// export default function LoginPage() {
//   const router = useRouter();

//   const [email, setEmail] = useState("");
//   const [password, setPassword] = useState("");
//   const [error, setError] = useState("");

//   const handleLogin = async (e: React.FormEvent) => {
//     e.preventDefault();
//     setError("");

//     const { error } = await supabase.auth.signInWithPassword({
//       email,
//       password,
//     });

//     if (error) {
//       setError(error.message);
//     } else {
//       router.push("/dashboard");
//     }
//   };

//   return (
//     <main className="h-screen flex items-center justify-center bg-gray-100">
//       <div className="bg-white p-6 rounded-xl shadow w-full max-w-sm">
//         <h1 className="text-xl text-black-700 font-bold mb-4">Login</h1>

//         {error && <p className="text-red-600 text-sm mb-2">{error}</p>}

//         <form onSubmit={handleLogin} className="space-y-4">
//           <input
//             type="email"
//             placeholder="Email"
//             className="w-full p-2 border rounded"
//             value={email}
//             onChange={(e) => setEmail(e.target.value)}
//             required
//           />

//           <input
//             type="password"
//             placeholder="Password"
//             className="w-full p-2 border rounded"
//             value={password}
//             onChange={(e) => setPassword(e.target.value)}
//             required
//           />

//           <button
//             type="submit"
//             className="w-full bg-blue-600 text-white p-2 rounded-lg"
//           >
//             Login
//           </button>
//         </form>

//         <p className="mt-3 text-sm">
//           Don't have an account?{" "}
//           <a className="text-blue-600" href="/register">
//             Register
//           </a>
//         </p>
//       </div>
//     </main>
//   );
// }
