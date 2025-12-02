import "./globals.css";

export const metadata = {
  title: "Clover To-Do",
  description: "Web Task Manager",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
