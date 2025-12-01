import { Test, TestingModule } from '@nestjs/testing';
import { ExecutionContext } from '@nestjs/common';
import { SupabaseAuthGuard } from './supabase.guard';
import { SupabaseService } from '../../supabase/supabase.service';

describe('SupabaseAuthGuard', () => {
  let guard: SupabaseAuthGuard;
  let mockSupabaseService: any;

  beforeEach(async () => {
    const mockService = {
      client: {
        auth: {
          getUser: jest.fn(),
        },
      },
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        SupabaseAuthGuard,
        {
          provide: SupabaseService,
          useValue: mockService,
        },
      ],
    }).compile();

    guard = module.get<SupabaseAuthGuard>(SupabaseAuthGuard);
    mockSupabaseService = module.get(SupabaseService);
  });

  it('should be defined', () => {
    expect(guard).toBeDefined();
  });

  it('should return true for valid token', async () => {
    const mockUser = { id: 'user-id' };
    mockSupabaseService.client.auth.getUser.mockResolvedValue({
      data: { user: mockUser },
      error: null,
    });

    const mockRequest: any = {
      headers: { authorization: 'Bearer valid-token' },
    };
    const mockContext = {
      switchToHttp: () => ({ getRequest: () => mockRequest }),
    } as ExecutionContext;

    const result = await guard.canActivate(mockContext);
    expect(result).toBe(true);
    expect(mockRequest.user).toEqual(mockUser);
  });

  it('should throw UnauthorizedException for missing token', async () => {
    const mockRequest = { headers: {} };
    const mockContext = {
      switchToHttp: () => ({ getRequest: () => mockRequest }),
    } as ExecutionContext;

    await expect(guard.canActivate(mockContext)).rejects.toThrow('Missing token');
  });

  it('should throw UnauthorizedException for invalid token', async () => {
    mockSupabaseService.client.auth.getUser.mockResolvedValue({
      data: null,
      error: new Error('Invalid token'),
    });

    const mockRequest = {
      headers: { authorization: 'Bearer invalid-token' },
    };
    const mockContext = {
      switchToHttp: () => ({ getRequest: () => mockRequest }),
    } as ExecutionContext;

    await expect(guard.canActivate(mockContext)).rejects.toThrow('Invalid token');
  });
});
