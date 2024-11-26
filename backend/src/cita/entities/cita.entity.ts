import { HistoriaClinica } from "src/historia_clinica/entities/historia_clinica.entity";
import { Medico } from "src/medico/entities/medico.entity";
import { Paciente } from "src/paciente/entities/paciente.entity";
import { Column, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";

@Entity('cita')
export class Cita {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ type: 'date', nullable: true })
    fecha: Date;

    @Column({ type: 'time', nullable: true })
    hora: string;

    @Column({ type: 'varchar', nullable: true })
    motivo: string;

    @Column({ type: 'varchar', nullable: true })
    estado: string;

    @ManyToOne(() => Medico, (medico) => medico.citas, { nullable: false })
    @JoinColumn({ name: 'medico_id' })
    medico: Medico;

    @ManyToOne(() => Paciente, (paciente) => paciente.citas, { nullable: false })
    @JoinColumn({ name: 'paciente_id' })
    paciente: Paciente;

    @OneToMany(() => HistoriaClinica, (historiaClinica) => historiaClinica.cita)
    historiaClinicas: HistoriaClinica[];
    
}

