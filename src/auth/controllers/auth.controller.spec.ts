import { Test, TestingModule } from '@nestjs/testing';
import { AuthController } from './auth.controller';
import { AuthService } from '../services/auth.service';
import { CreateUserDto } from './dto/create-user.dto';
import { HttpException, HttpStatus } from '@nestjs/common';
import { CloudWatchService } from '../../common/services/coudWatch.service';

describe('AuthController', () => {
  let authController: AuthController;
  let authService: AuthService;
  let cloudWatchService: CloudWatchService;

  const mockAuthService = {
    userExists: jest.fn(),
    createUser: jest.fn(),
    login: jest.fn(),
    updateRoles: jest.fn(),
  };

  const mockCloudWatchService = {
    sendMetricData: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [AuthController],
      providers: [
        {
          provide: AuthService,
          useValue: mockAuthService,
        },
        {
          provide: CloudWatchService,
          useValue: mockCloudWatchService,
        },
      ],
    }).compile();

    authController = module.get<AuthController>(AuthController);
    authService = module.get<AuthService>(AuthService);
    cloudWatchService = module.get<CloudWatchService>(CloudWatchService);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  describe('register', () => {
    it('should register a new user', async () => {
      const createUserDto: CreateUserDto = {
        email: 'test@example.com',
        password: 'password',
        firstName: '',
        lastName: '',
        roles: [],
      };

      mockAuthService.userExists.mockResolvedValue(false);
      mockAuthService.createUser.mockResolvedValue({
        access_token: 'dummy_token',
      });

      const result = await authController.register(createUserDto);

      expect(result).toEqual({ access_token: 'dummy_token' });
      expect(authService.userExists).toHaveBeenCalledWith(createUserDto.email);
      expect(authService.createUser).toHaveBeenCalledWith(createUserDto);
      expect(cloudWatchService.sendMetricData).toHaveBeenCalledWith(
        'UserRegistered',
        1,
      );
    });

    it('should throw an error if user already exists', async () => {
      const createUserDto: CreateUserDto = {
        email: 'test@example.com',
        password: 'password',
        firstName: '',
        lastName: '',
        roles: [],
      };

      mockAuthService.userExists.mockResolvedValue(true);

      await expect(authController.register(createUserDto)).rejects.toThrow(
        new HttpException('USER_ALREADY_REGISTERED', HttpStatus.CONFLICT),
      );

      expect(authService.userExists).toHaveBeenCalledWith(createUserDto.email);
      expect(authService.createUser).not.toHaveBeenCalled();
      expect(cloudWatchService.sendMetricData).toHaveBeenCalledWith(
        'UserAlreadyRegistered',
        1,
      );
    });
  });

  describe('login', () => {
    it('should return an access token', async () => {
      const req = { user: { email: 'test@example.com', password: 'password' } };

      mockAuthService.login.mockResolvedValue({
        access_token: 'dummy_token',
      });

      const result = await authController.login(req);

      expect(result).toEqual({ access_token: 'dummy_token' });
      expect(authService.login).toHaveBeenCalledWith(req.user);
      expect(cloudWatchService.sendMetricData).toHaveBeenCalledWith(
        'UserLoggedIn',
        1,
      );
    });
  });

  describe('updateRoles', () => {
    it('should update user roles', async () => {
      const body = { email: 'test@example.com', rolesIds: [1] };

      mockAuthService.updateRoles.mockResolvedValue({
        message: 'Roles updated',
      });

      const result = await authController.updateRoles(body);

      expect(result).toEqual({ message: 'Roles updated' });
      expect(authService.updateRoles).toHaveBeenCalledWith(
        body.email,
        body.rolesIds,
      );
      expect(cloudWatchService.sendMetricData).toHaveBeenCalledWith(
        'RolesUpdated',
        1,
      );
    });

    it('should throw an error if user not found', async () => {
      const body = { email: 'nonexistent@example.com', rolesIds: [1] };

      mockAuthService.updateRoles.mockRejectedValue(
        new HttpException('User not found', HttpStatus.NOT_FOUND),
      );

      await expect(authController.updateRoles(body)).rejects.toThrow(
        new HttpException('User not found', HttpStatus.NOT_FOUND),
      );

      expect(authService.updateRoles).toHaveBeenCalledWith(
        body.email,
        body.rolesIds,
      );
      expect(cloudWatchService.sendMetricData).toHaveBeenCalledWith(
        'RolesUpdated',
        1,
      );
    });
  });
});
