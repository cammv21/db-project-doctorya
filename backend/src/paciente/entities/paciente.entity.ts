import { Expose } from "class-transformer";
import { Cita } from "src/cita/entities/cita.entity";
import { SeguroMedico } from "src/seguro_medico/entities/seguro_medico.entity";
import { Column, Entity, JoinColumn, OneToMany, OneToOne, PrimaryGeneratedColumn } from "typeorm";

@Entity('paciente')
export class Paciente {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ type: 'varchar' })
    nombre: string;

    @Column({ type: 'varchar' })
    identificacion: string;

    @Column({ type: 'date' })
    fecha_nacimiento: string;

    @Column({ type: 'char' })
    sexo: string;

    @Column({ type: 'varchar' })
    direccion: string;

    @Column({ type: 'varchar' })
    email: string;

    @Column({ type: 'varchar' })
    celular: string;

    @OneToOne(() => SeguroMedico)
    @JoinColumn({ name: 'seguro_id' })
    seguroMedico: SeguroMedico;

    @OneToMany(() => Cita, (cita) => cita.paciente)
    citas: Cita[];
}
