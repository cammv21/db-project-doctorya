import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity('seguro_medico')
export class SeguroMedico {
    @PrimaryGeneratedColumn()
    id: number;
    
    @Column({ type: 'varchar', length: 55, nullable: true })
    nombre: string | null;

    @Column({ type: 'varchar', length: 55, nullable: true })
    tipo: string | null;

    @Column({ type: 'date', nullable: true })
    fecha_inicio: Date | null;

    @Column({ type: 'date', nullable: true })
    fecha_fin: Date | null;

    @Column({ type: 'varchar', length: 55, nullable: true })
    celular: string | null;

}
