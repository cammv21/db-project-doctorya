import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity('informe')
export class Informe {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ type: 'date', nullable: true })
    fecha: string | null;

    @Column({ type: 'varchar', nullable: true })
    tipo: string | null;

    @Column({ type: 'jsonb', nullable: true })
    contenido: object | null;
}
