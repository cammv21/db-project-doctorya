import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity('clinica')
export class Clinica {
    @PrimaryGeneratedColumn()
    id: number;

    @Column('xml', { nullable: true })
    detalles: string | null;
}
