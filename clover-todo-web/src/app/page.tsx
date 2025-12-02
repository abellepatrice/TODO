"use client";

import { supabase } from "./lib/supabaseClient";
import { useRouter } from "next/navigation";
import { useEffect } from "react";

export default function Home() {
  const router = useRouter();

  useEffect(() => {
    const check = async () => {
      const { data } = await supabase.auth.getUser();

      if (data.user) router.push("/dashboard");
      else router.push("/login");
    };

    check();
  }, []);

  return <p className="text-center mt-20">Loading...</p>;
}
