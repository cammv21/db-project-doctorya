import { ApiProperty } from '@nestjs/swagger';
import { IsDate, IsInt, IsOptional, IsString } from 'class-validator';

export class CreateHistoriaClinicaDto {

    @ApiProperty({
        description: 'Fecha de la historia clínica',
        example: '2024-11-25',
        required: false,
    })
    @IsOptional()
    @IsDate()
    fecha?: Date;

    @ApiProperty({
        description: 'Síntomas del paciente',
        example: 'Dolor de cabeza, fiebre',
        required: false,
    })
    @IsOptional()
    @IsString()
    sintomas?: string;

    @ApiProperty({
        description: 'Diagnóstico médico',
        example: 'Infección respiratoria',
        required: false,
    })
    @IsOptional()
    @IsString()
    diagnostico?: string;

    @ApiProperty({
        description: 'Tratamiento recomendado para el paciente',
        example: 'Antibióticos, descanso',
        required: false,
    })
    @IsOptional()
    @IsString()
    tratamiento?: string;

    @ApiProperty({
        description: 'Observaciones adicionales del médico',
        example: 'Requiere seguimiento en una semana',
        required: true,
    })
    @IsString()
    observaciones: string;

    @ApiProperty({
        description: 'ID de la cita médica asociada',
        example: 1,
        required: true,
    })
    @IsInt()
    cita_id: number;
}
