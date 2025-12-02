export default function FormControl({
  label,
  children,
}: {
  label?: string;
  children: React.ReactNode;
}) {
  return (
    <div className="flex flex-col gap-1">
      {label && (
        <label className="text-sm font-medium text-[#1C1C1E]">
          {label}
        </label>
      )}
      {children}
    </div>
  );
}
