import { Injectable } from '@nestjs/common';
import { SupabaseService } from '../supabase/supabase.service';

@Injectable()
export class TasksService {
  constructor(private readonly supabase: SupabaseService) {}

  async getAllTasks(userId: string) {
    const { data, error } = await this.supabase.client
      .from('tasks')
      .select('*')
      .eq('user_id', userId)
      .order('created_at', { ascending: false });

    if (error) throw error;
    return data;
  }
  async getOneTask(userId: string, taskId: string) {
  const { data, error } = await this.supabase.client
    .from('tasks')
    .select('*')
    .eq('id', taskId)
    .eq('user_id', userId)
    .single();

  if (error) throw new Error(`Task not found or unauthorized`);
  return data;
  }

  async createTask(userId: string, taskDto: any) {
    const { data, error } = await this.supabase.client
      .from('tasks')
      .insert({ ...taskDto, user_id: userId })
      .select();

    if (error) throw error;
    return data;
  }

  async updateTask(userId: string, taskId: string, taskDto: any) {
    const { data, error } = await this.supabase.client
      .from('tasks')
      .update(taskDto)
      .eq('id', taskId)
      .eq('user_id', userId)
      .select();

    if (error) throw error;
    return data;
  }

  async deleteTask(userId: string, taskId: string) {
    const { error } = await this.supabase.client
      .from('tasks')
      .delete()
      .eq('id', taskId)
      .eq('user_id', userId);

    if (error) throw error;
    return { message: 'Task deleted' };
  }
}
