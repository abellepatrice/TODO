import { Controller, Get, Post, Body, Param, Delete, Put, Req, UseGuards } from '@nestjs/common';
import { TasksService } from './tasks.service';
import { SupabaseAuthGuard } from '../auth/supabase/supabase.guard';

@Controller('api/tasks')
export class TasksController {
  constructor(private readonly tasksService: TasksService) {}

  @UseGuards(SupabaseAuthGuard)
  @Get()
  async getTasks(@Req() req) {
    const userId = req.user.id;
    const tasks = await this.tasksService.getAllTasks(userId);
    return tasks;
  }

  @UseGuards(SupabaseAuthGuard)
  @Get(':id')
  async getOneTask(@Req() req, @Param('id') id: string) {
    const userId = req.user.id;
    const task = await this.tasksService.getOneTask(userId, id);
    return { data: task }; 
  }

  @UseGuards(SupabaseAuthGuard)
  @Post()
  async createTask(@Req() req, @Body() body) {
    const userId = req.user.id;
    return this.tasksService.createTask(userId, body);
  }

  @UseGuards(SupabaseAuthGuard)
  @Put(':id')
  async updateTask(@Req() req, @Param('id') id: string, @Body() body) {
    const userId = req.user.id;
    return this.tasksService.updateTask(userId, id, body);
  }

  @UseGuards(SupabaseAuthGuard)
  @Delete(':id')
  async deleteTask(@Req() req, @Param('id') id: string) {
    const userId = req.user.id;
    return this.tasksService.deleteTask(userId, id);
  }
}


