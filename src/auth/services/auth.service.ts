import { Injectable } from '@nestjs/common';
import { UsersService } from './../../users/services/users.service';
import { JwtService } from '@nestjs/jwt';
import { User } from './../../users/models/user.entity';
import { CreateUserDto } from '../controllers/dto/create-user.dto';
import { RolesService } from './../../users/services/roles.service';

@Injectable()
export class AuthService {
  constructor(
    private usersService: UsersService,
    private rolesService: RolesService,
    private jwtService: JwtService,
  ) {}

  async validateUserLocal(email: string, password: string): Promise<any> {
    const user: User = await this.usersService.findOneByEmail(email);
    if (
      user &&
      (await this.usersService.comparePassword(password, user.password))
    ) {
      // eslint-disable-next-line @typescript-eslint/no-unused-vars
      const { password, ...result } = user;
      return result;
    }
    return null;
  }

  async login(user: User) {
    const payload = { userId: user.id, email: user.email };
    return {
      access_token: this.jwtService.sign(payload),
    };
  }

  async userExists(email: string) {
    return await this.usersService.findOneByEmail(email);
  }

  async createUser(userDto: CreateUserDto) {
    const role = await this.rolesService.findOneByName('guest');

    if (!role) {
      throw new Error('Role not found');
    }

    userDto.roles = [role];

    const user: User = await this.usersService.create(userDto);
    const payload = {
      userId: user.id,
      email: user.email,
      rolesIds: user.roles.map((role) => role.id),
    };
    return {
      access_token: this.jwtService.sign(payload),
    };
  }
}
