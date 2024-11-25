import { IsString } from "class-validator";

export class CreateMedicoDto {
    
    @IsString()
    nombre: string;

    @IsString()
    identificacion: string;

    @IsString()
    registro_medico: string;

    @IsString()
    especialidad: string;

    @IsString()
    email: string;

    @IsString()
    celular: string;
}
