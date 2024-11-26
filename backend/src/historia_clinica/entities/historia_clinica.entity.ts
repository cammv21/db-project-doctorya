import { Cita } from "src/cita/entities/cita.entity";
import { Examen } from "src/examen/entities/examen.entity";
import { Column, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";

@Entity('historia_clinica')
export class HistoriaClinica {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ type: 'date', nullable: true })
    fecha: Date;

    @Column({ type: 'varchar', nullable: true })
    sintomas: string;

    @Column({ type: 'varchar', nullable: true })
    diagnostico: string;

    @Column({ type: 'varchar', nullable: true })
    tratamiento: string;

    @Column({ type: 'varchar', nullable: true })
    observaciones: string;

    @ManyToOne(() => Cita, (cita) => cita.historiaClinicas, { nullable: true })
    @JoinColumn({ name: 'cita_id' })
    cita: Cita;

    @OneToMany(() => Examen, examen => examen.historia_clinica)
    examenes: Examen[];
}
