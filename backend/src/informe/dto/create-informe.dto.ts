import { ApiProperty } from '@nestjs/swagger';
import { IsDateString, IsJSON, IsOptional, IsString } from 'class-validator';

export class CreateInformeDto {
    @ApiProperty({
        description: 'Fecha del informe',
        example: '2024-12-01',
        required: false,
    })
    @IsOptional()
    @IsDateString()
    fecha?: string;

    @ApiProperty({
        description: 'Tipo de informe',
        example: 'Anual',
        required: false,
    })
    @IsOptional()
    @IsString()
    tipo?: string;

    @ApiProperty({
        description: 'Contenido del informe en formato JSON',
        example: '{"resumen": "Informe anual de actividades", "detalles": ["Actividad 1", "Actividad 2"]}',
        required: false,
    })
    @IsOptional()
    @IsJSON()
    contenido?: object;
}
