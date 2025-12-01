import { Injectable, UnauthorizedException } from '@nestjs/common';
import { SupabaseService } from '../supabase/supabase.service';

@Injectable()
export class AuthService {
  constructor(private readonly supabase: SupabaseService) {}

  async register(email: string, password: string, username: string) {
    const { data, error } = await this.supabase.client.auth.signUp({
      email,
      password,
      options: {
        data: { username },
      },
    });

    if (error) throw new UnauthorizedException(error.message);

    if (data.user) {
      const { error: profileError } = await this.supabase.client
        .from('profiles')
        .insert({
          id: data.user.id,
          email: data.user.email,
          username,
        });

      if (profileError) throw new UnauthorizedException('Failed to create profile');
    }

    return data;
  }

  async login(email: string, password: string) {
    const { data, error } = await this.supabase.client.auth.signInWithPassword({
      email,
      password,
    });

    if (error) throw new UnauthorizedException(error.message);
    return data;
  }

  async logout() {
    const { error } = await this.supabase.client.auth.signOut();

    if (error) throw new UnauthorizedException(error.message);

    return { message: 'Logged out successfully' };
  }
}

