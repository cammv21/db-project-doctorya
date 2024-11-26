import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsOptional, IsString, IsDateString, IsInt } from 'class-validator';

export class CreateCitaDto {
    
    @ApiProperty({
        description: 'Fecha de la cita',
        example: '2024-11-25',
        required: false,
    })
    @IsOptional()
    @IsDateString()
    fecha?: string;

    @ApiProperty({
        description: 'Hora de la cita',
        example: '10:30',
        required: false,
    })
    @IsOptional()
    @IsString()
    hora?: string;

    @ApiProperty({
        description: 'Motivo de la cita',
        example: 'Consulta general',
        required: false,
    })
    @IsOptional()
    @IsString()
    motivo?: string;

    @ApiProperty({
        description: 'Estado de la cita (por ejemplo, "Pendiente", "Completada")',
        example: 'Pendiente',
        required: false,
    })
    @IsOptional()
    @IsString()
    estado?: string;

    @ApiProperty({
        description: 'ID del médico asignado a la cita',
        example: 1,
        required: true,
    })
    @IsNotEmpty()
    @IsInt()
    medico_id: number;

    @ApiProperty({
        description: 'ID del paciente asignado a la cita',
        example: 1,
        required: true,
    })
    @IsNotEmpty()
    @IsInt()
    paciente_id: number;
}

