import { SeguroMedico } from "src/seguro_medico/entities/seguro_medico.entity";
export declare class Paciente {
    id: number;
    nombre: string;
    identificacion: string;
    fecha_nacimiento: string;
    sexo: string;
    direccion: string;
    email: string;
    celular: string;
    seguroMedico: SeguroMedico;
}
