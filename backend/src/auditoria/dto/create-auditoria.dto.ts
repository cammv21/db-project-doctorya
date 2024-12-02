import { ApiProperty } from '@nestjs/swagger';
import { IsArray, IsNotEmpty, IsOptional, IsString } from 'class-validator';

export class CreateAuditoriaDto {
    @ApiProperty({
        description: 'Fecha de la auditoría',
        example: '2024-12-01',
    })
    @IsString()
    fecha: string;

    @ApiProperty({
        description: 'Nombre del paciente',
        example: 'Juan Pérez',
    })
    @IsString()
    @IsNotEmpty()
    nombre_paciente: string;

    @ApiProperty({
        description: 'Nombre del doctor',
        example: 'Dr. Roberto Gómez',
    })
    @IsString()
    @IsNotEmpty()
    nombre_medico: string;

    @ApiProperty({
        description: 'Motivo de la cita',
        example: 'Chequeo de salud general',
    })
    @IsString()
    @IsNotEmpty()
    motivo_cita: string;

    @ApiProperty({
        description: 'Diagnóstico médico',
        example: 'Sin hallazgos anormales',
        required: false,
    })
    @IsOptional()
    @IsString()
    @IsNotEmpty()
    diagnostico?: string; // Campo opcional

    @ApiProperty({
        description: 'Lista de medicamentos recetados',
        example: ['Paracetamol', 'Ibuprofeno'],
        required: false,
    })
    @IsOptional()
    @IsArray()
    @IsString({ each: true })
    medicamentos?: string[]; // Campo opcional
}
