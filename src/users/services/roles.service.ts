import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { Role } from '../models/role.entity';

@Injectable()
export class RolesService {
  constructor(@InjectRepository(Role) private repository: Repository<Role>) {}

  async findOneByName(name: string): Promise<Role | undefined> {
    return this.repository.findOne({
      where: {
        name,
      },
    });
  }

  async getAll(): Promise<Role[]> {
    return this.repository.find();
  }

  async getRolesByIds(ids: number[]): Promise<Role[]> {
    return this.repository.findBy({ id: In(ids) });
  }
}
