"use client";
import { useState } from "react";
import Link from "next/link";
import { useRouter, usePathname } from "next/navigation";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faHouse, faUser, faHistory, faPlus, faSignOutAlt, faBars, faTimes } from "@fortawesome/free-solid-svg-icons";
import { supabase } from "../app/lib/supabaseClient";

export default function Sidebar() {
  const router = useRouter();
  const pathname = usePathname();
  const [isOpen, setIsOpen] = useState(false);

  const logout = async () => {
    await supabase.auth.signOut();
    router.push("/login");
  };

  const primaryGreen = "#7ae615";

  const links = [
    { name: "Home", href: "/dashboard", icon: faHouse },
    { name: "Profile", href: "/profile", icon: faUser },
    { name: "History", href: "/history", icon: faHistory },
    { name: "Create Task", href: "/tasks/create", icon: faPlus },
  ];

  const isActive = (href: string) => pathname === href;

  return (
    <>
      {/* Mobile Hamburger */}
      <button
        className="md:hidden h-full fixed top-4 left-4 z-50 bg-white p-2 rounded shadow"
        onClick={() => setIsOpen(!isOpen)}
      >
        <FontAwesomeIcon icon={isOpen ? faTimes : faBars} className="text-gray-900 w-6 h-6" />
      </button>

      {/* Sidebar */}
      <aside
        className={`
          fixed top-0 left-0 h-full w-64 bg-white p-6 shadow-md space-y-6
          transform transition-transform duration-300 ease-in-out
          ${isOpen ? "translate-x-0" : "-translate-x-full"} md:translate-x-0 md:static md:block
        `}
      >
        <h2 className="text-2xl font-semibold text-gray-900 mb-6">Menu</h2>

        <nav className="flex flex-col space-y-3">
          {links.map((link) => (
            <Link
              key={link.href}
              href={link.href}
              className={`flex items-center gap-3 px-4 py-3 rounded-lg transition
                ${isActive(link.href) ? "bg-green-100 text-green-700" : "text-gray-900 hover:bg-gray-100"}`}
            >
              <FontAwesomeIcon icon={link.icon} className="w-5 h-5" style={{ color: primaryGreen }} />
              <span className="text-lg font-medium">{link.name}</span>
            </Link>
          ))}

          <button
            onClick={logout}
            className="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-900 hover:bg-gray-100 transition w-full text-left mt-3"
          >
            <FontAwesomeIcon icon={faSignOutAlt} className="w-5 h-5" style={{ color: primaryGreen }} />
            <span className="text-lg font-medium">Logout</span>
          </button>
        </nav>
      </aside>

      {/* Overlay for mobile */}
      {isOpen && (
        <div
          className="fixed inset-0 bg-black opacity-30 z-40 md:hidden"
          onClick={() => setIsOpen(false)}
        ></div>
      )}
    </>
  );
}
