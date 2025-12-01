import { Module } from '@nestjs/common';
import { TasksService } from './tasks.service';
import { TasksController } from './tasks.controller';
import { SupabaseService } from '../supabase/supabase.service';

@Module({
  providers: [TasksService, SupabaseService],
  controllers: [TasksController]
})
export class TasksModule {}
