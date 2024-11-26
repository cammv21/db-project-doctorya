import { HistoriaClinica } from 'src/historia_clinica/entities/historia_clinica.entity';
import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from 'typeorm';

@Entity('examen')
export class Examen {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ type: 'varchar', nullable: true })
    nombre: string | null;

    @Column({ type: 'float', nullable: true })
    costo: number | null;

    @Column({ type: 'boolean', nullable: true })
    cubre_seguro: boolean | null;

    @Column({ type: 'date', nullable: true })
    fecha: Date | null;

    @Column({ type: 'varchar', nullable: true })
    estado: string | null;

    @ManyToOne(() => HistoriaClinica, historiaClinica => historiaClinica.examenes, { nullable: true })
    @JoinColumn({ name: 'historia_clinica_id' })  // Nombre de la columna de la clave foránea
    historia_clinica: HistoriaClinica | null;
}
