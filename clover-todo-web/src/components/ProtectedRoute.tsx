"use client";

import { supabase } from "../app/lib/supabaseClient";
import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";

export default function ProtectedRoute({
  children,
}: {
  children: React.ReactNode;
}) {
  const router = useRouter();
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const check = async () => {
      const { data } = await supabase.auth.getUser();
      if (!data.user) router.push("/login");
      else setLoading(false);
    };
    check();
  }, []);

  if (loading) return <p className="text-center mt-20">Loading...</p>;

  return children;
}
