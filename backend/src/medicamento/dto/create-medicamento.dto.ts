import { ApiProperty } from '@nestjs/swagger';
import { IsInt, IsString } from 'class-validator';

export class CreateMedicamentoDto {
    
    @ApiProperty({
        description: 'Nombre del medicamento',
        example: 'Paracetamol',
        required: true,
    })
    @IsString()
    nombre: string;

    @ApiProperty({
        description: 'Principio activo del medicamento',
        example: 'Paracetamol',
        required: true,
    })
    @IsString()
    principio_activo: string;

    @ApiProperty({
        description: 'Forma farmacéutica del medicamento',
        example: 'Tabletas',
        required: true,
    })
    @IsString()
    forma_farmaceutica: string;

    @ApiProperty({
        description: 'Dosis recomendada del medicamento',
        example: '500mg',
        required: true,
    })
    @IsString()
    dosis: string;

    @ApiProperty({
        description: 'Indicaciones para el uso del medicamento',
        example: 'Tomar después de las comidas',
        required: true,
    })
    @IsString()
    indicaciones: string;

    @ApiProperty({
        description: 'Duración del tratamiento con el medicamento',
        example: '7 días',
        required: true,
    })
    @IsString()
    duracion: string;

    @ApiProperty({
        description: 'Estado del medicamento (ejemplo: activo, inactivo)',
        example: 'pendiente',
        required: true,
    })
    @IsString()
    estado: string;

    @ApiProperty({
        description: 'ID de la historia clínica asociada al medicamento',
        example: 123,
        required: true,
    })
    @IsInt()
    historia_clinica_id: number;
}

