export interface Task {
  id: string;
  user_id: string;
  title: string;
  description: string;
  priority: "low" | "medium" | "high";
  is_completed: boolean;
  created_at: string;
}
