import axios from "axios";
import { supabase } from "./supabaseClient";

const API_URL = "https://ea6f1dd87427.ngrok-free.app/api"; 

const axiosInstance = axios.create({
  baseURL: API_URL,
});

axiosInstance.interceptors.request.use(async (config) => {
  const {
    data: { session },
  } = await supabase.auth.getSession();

  if (!config.headers) {
    config.headers = new axios.AxiosHeaders();
  }

  if (session?.access_token) {
    config.headers.set("Authorization", `Bearer ${session.access_token}`);
  }

  return config;
});

export const api = {
  getTasks: () => axiosInstance.get(`tasks`),
  getTask: (id: string) => axiosInstance.get(`/tasks/${id}`),
  createTask: (body: any) => axiosInstance.post("/tasks", body),
  updateTask: (id: string, body: any) => axiosInstance.put(`/tasks/${id}`, body),
  deleteTask: (id: string) => axiosInstance.delete(`/tasks/${id}`),
  getCompletedTasks: () => axiosInstance.get(`/tasks/completed`),
  getEditedTasks: () => axiosInstance.get(`/tasks/edited`),
  getProfile: () => axiosInstance.get(`/auth/me`),

};
