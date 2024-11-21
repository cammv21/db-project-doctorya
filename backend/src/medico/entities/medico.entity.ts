import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity('medico')
export class Medico {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ type: 'varchar' })
    nombre: string;

    @Column({ type: 'varchar' })
    identificacion: string;

    @Column({ type: 'varchar' })
    registro_medico: string;

    @Column({ type: 'varchar' })
    especialidad: string;

    @Column({ type: 'varchar' })
    email: string;

    @Column({ type: 'varchar' })
    celular: string;
}
