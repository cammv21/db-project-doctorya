import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsOptional, IsBoolean, IsDate, IsNumber } from 'class-validator';

export class CreateExamenDto {

    @ApiProperty({
        description: 'Nombre del examen',
        example: 'Hemograma',
        required: false,
    })
    @IsString()
    @IsOptional()
    nombre?: string;

    @ApiProperty({
        description: 'Costo del examen',
        example: 100.0,
        required: false,
    })
    @IsNumber()
    @IsOptional()
    costo?: number;

    @ApiProperty({
        description: 'Indica si el examen cubre seguro médico',
        example: true,
        required: false,
    })
    @IsBoolean()
    @IsOptional()
    cubre_seguro?: boolean;

    @ApiProperty({
        description: 'Fecha del examen',
        example: '2024-11-25',
        required: false,
    })
    @IsDate()
    @IsOptional()
    fecha?: Date;

    @ApiProperty({
        description: 'Estado del examen',
        example: 'Pendiente',
        required: false,
    })
    @IsString()
    @IsOptional()
    estado?: string;

    @ApiProperty({
        description: 'ID de la historia clínica asociada al examen',
        example: 1,
        required: false,
    })
    @IsNumber()
    @IsOptional()
    historia_clinica_id?: number;
}

