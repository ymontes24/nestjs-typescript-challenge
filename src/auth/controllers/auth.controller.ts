import {
  Body,
  Controller,
  HttpCode,
  HttpException,
  HttpStatus,
  Post,
  Req,
  UseGuards,
} from '@nestjs/common';
import { LocalAuthGuard } from './../guards/local-auth.guard';
import { AuthService } from './../services/auth.service';
import { CreateUserDto } from './dto/create-user.dto';
import { ApiBearerAuth, ApiBody, ApiResponse, ApiTags } from '@nestjs/swagger';
import { Roles } from '../../common/decorators/role.decorator';
import { Role } from '../../constants/roles.constants';
import { JwtAuthGuard } from '../guards/jwt-auth.guard';
import { RolesGuard } from '../guards/role.guard';
import { CloudWatchService } from '../../common/services/coudWatch.service';

@ApiTags('Auth')
@Controller('api/auth')
export class AuthController {
  constructor(
    private authService: AuthService,
    private cloudWatchService: CloudWatchService,
  ) {}

  @Post('register')
  @HttpCode(201)
  @ApiResponse({
    status: 201,
    description: 'Register a new user',
    schema: {
      example: {
        access_token:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI5IiwiZW1haWwiOiJlbWFpbEBkZW1vLmNvbSIsImlhdCI6MTY1MjA0NzQzNSwiZXhwIjoxNjUyMTMzODM1fQ.ikFigJQn1ttuPAV06Yjr4PL6lKvm_HMygcTU8N1P__0',
      },
    },
  })
  @ApiResponse({
    status: 409,
    description: 'User already registered',
    schema: {
      example: {
        statusCode: 409,
        message: 'USER_ALREADY_REGISTERED',
      },
    },
  })
  async register(@Body() createUserDto: CreateUserDto): Promise<any> {
    const user = await this.authService.userExists(createUserDto.email);
    if (user) {
      this.cloudWatchService.sendMetricData('UserAlreadyRegistered', 1);
      throw new HttpException('USER_ALREADY_REGISTERED', HttpStatus.CONFLICT);
    }
    this.cloudWatchService.sendMetricData('UserRegistered', 1);
    return await this.authService.createUser(createUserDto);
  }

  @Post('login')
  @UseGuards(LocalAuthGuard)
  @HttpCode(200)
  @ApiBody({
    schema: {
      example: {
        email: 'email@demo.com',
        password: 'password',
      },
    },
  })
  @ApiResponse({
    status: 200,
    description: 'Get a new access token with the credentials',
    schema: {
      example: {
        access_token:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI5IiwiZW1haWwiOiJlbWFpbEBkZW1vLmNvbSIsImlhdCI6MTY1MjA0NzQzNSwiZXhwIjoxNjUyMTMzODM1fQ.ikFigJQn1ttuPAV06Yjr4PL6lKvm_HMygcTU8N1P__0',
      },
    },
  })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
    schema: {
      example: {
        statusCode: 401,
        message: 'Unauthorized',
      },
    },
  })
  async login(@Req() req) {
    this.cloudWatchService.sendMetricData('UserLoggedIn', 1);
    return this.authService.login(req.user);
  }

  @Post('update-roles')
  @Roles(Role.Admin, Role.Agent, Role.Customer)
  @UseGuards(JwtAuthGuard, RolesGuard)
  @HttpCode(201)
  @ApiBearerAuth('Authorization')
  @ApiBody({
    schema: {
      example: {
        email: 'email@demo.com',
        rolesIds: [1],
      },
    },
  })
  @ApiResponse({
    status: 201,
    description: 'Update user roles',
    schema: {
      example: {
        Message: 'Roles updated',
      },
    },
  })
  @ApiResponse({
    status: 404,
    description: 'User not found',
    schema: {
      example: {
        statusCode: 404,
        message: 'User not found',
      },
    },
  })
  async updateRoles(@Body() body: any): Promise<any> {
    this.cloudWatchService.sendMetricData('RolesUpdated', 1);
    return await this.authService.updateRoles(body.email, body.rolesIds);
  }
}
