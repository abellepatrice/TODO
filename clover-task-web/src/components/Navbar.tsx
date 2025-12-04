"use client";

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faBell } from "@fortawesome/free-solid-svg-icons";

export default function Navbar() {
  return (
    <nav className="flex items-center justify-between bg-white p-4 shadow relative">
      {/* Left: Logo */}
      <div className="flex items-center">
        <span className="text-2xl font-bold text-green-600 tracking-wide">
          Clover
        </span>
      </div>

      {/* Center: Title */}
      <h1 className="text-xl font-semibold text-gray-800 absolute left-1/2 transform -translate-x-1/2">
        Task Manager
      </h1>

      {/* Right: Notifications */}
      <div className="flex items-center">
        <button className="text-gray-600 hover:text-gray-900 relative">
          <FontAwesomeIcon icon={faBell} size="lg" />
          {/* Optional: notification badge */}
          <span className="absolute top-0 right-0 inline-block w-2 h-2 bg-red-600 rounded-full"></span>
        </button>
      </div>
    </nav>
  );
}
