import { IsDateString, IsNumber, IsOptional, IsString, Length } from "class-validator";

export class CreatePacienteDto {
    @IsString()
    nombre: string;

    @IsString()
    identificacion: string;

    @IsDateString()
    fecha_nacimiento: string;

    @IsString()
    @Length(1, 1) // Limitar a un solo carácter
    sexo: string;

    @IsString()
    direccion: string;

    @IsString()
    email: string;

    @IsString()
    celular: string;

    @IsNumber()
    @IsOptional() // Hacer que sea opcional si no siempre se requiere
    seguro_id?: number;

}
