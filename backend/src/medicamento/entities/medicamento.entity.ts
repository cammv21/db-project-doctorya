
import { HistoriaClinica } from 'src/historia_clinica/entities/historia_clinica.entity';
import { Column, Entity, JoinColumn, ManyToOne, OneToOne, PrimaryGeneratedColumn } from 'typeorm';

@Entity('medicamento')
export class Medicamento {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ type: 'varchar', nullable: true })
    nombre: string;

    @Column({ type: 'varchar', nullable: true })
    principio_activo: string;

    @Column({ type: 'varchar', nullable: true })
    forma_farmaceutica: string;

    @Column({ type: 'varchar', nullable: true })
    dosis: string;

    @Column({ type: 'varchar', nullable: true })
    indicaciones: string;

    @Column({ type: 'varchar', nullable: true })
    duracion: string;

    @Column({ type: 'varchar', nullable: true })
    estado: string;

    @OneToOne(() => HistoriaClinica)
    @JoinColumn({ name: 'historia_clinica_id' })
    seguroMedico: HistoriaClinica;
}
