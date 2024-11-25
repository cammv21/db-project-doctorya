import { IsNotEmpty, IsOptional, IsString, IsDateString, IsInt } from 'class-validator';

export class CreateCitaDto {
    @IsOptional()
    @IsDateString()
    fecha?: string;

    @IsOptional()
    @IsString()
    hora?: string;

    @IsOptional()
    @IsString()
    motivo?: string;

    @IsOptional()
    @IsString()
    estado?: string;

    @IsNotEmpty()
    @IsInt()
    medico_id: number;

    @IsNotEmpty()
    @IsInt()
    paciente_id: number;
}
