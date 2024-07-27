import { MigrationInterface, QueryRunner } from 'typeorm';

export class SchemaUpdate1722037536421 implements MigrationInterface {
  name = 'SchemaUpdate1722037536421';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`

            INSERT INTO users (first_name, last_name, email, password, created_at, updated_at)

            VALUES ('Admin', 'User', 'admin@admin.com', '$2a$10$SFSb6r.euS1ktIeQtiBqueL.0sm6BpMIKADd26ipdT.FWMCe2mupS', NOW(), NOW())

          `);

    await queryRunner.query(`

            INSERT INTO users_roles_roles (usersId, rolesId)

            VALUES (

              (SELECT id FROM users WHERE email = 'admin@admin.com'),

              (SELECT id FROM roles WHERE name = 'admin')

            )

          `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(` 

            DELETE FROM users_roles_roles 

            WHERE usersId = (SELECT id FROM users WHERE email = 'admin@admin.com')

          `);

    await queryRunner.query(`

            DELETE FROM users WHERE email = 'admin@admin.com'

          `);
  }
}
