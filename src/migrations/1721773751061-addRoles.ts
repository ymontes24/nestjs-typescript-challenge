import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddRoles1721773751061 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query("INSERT INTO roles (name) VALUES ('admin')");

    await queryRunner.query("INSERT INTO roles (name) VALUES ('agent')");

    await queryRunner.query("INSERT INTO roles (name) VALUES ('customer')");

    await queryRunner.query("INSERT INTO roles (name) VALUES ('guest')");
  }

  public async down(queryRunner: QueryRunner): Promise<void> {}
}
