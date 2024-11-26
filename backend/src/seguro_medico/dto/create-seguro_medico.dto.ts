import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsOptional, IsDate, IsPhoneNumber } from 'class-validator';

export class CreateSeguroMedicoDto {
    @ApiProperty({
        description: 'Nombre del seguro médico (opcional)',
        example: 'Seguro Vida',
        required: false,
    })
    @IsOptional()
    @IsString()
    readonly nombre: string | null;

    @ApiProperty({
        description: 'Tipo de seguro médico (opcional)',
        example: 'Premium',
        required: false,
    })
    @IsOptional()
    @IsString()
    readonly tipo: string | null;

    @ApiProperty({
        description: 'Fecha de inicio del seguro médico (opcional)',
        example: '2024-01-01',
        required: false,
    })
    @IsOptional()
    @IsDate()
    readonly fecha_inicio: Date | null;

    @ApiProperty({
        description: 'Fecha de fin del seguro médico (opcional)',
        example: '2025-01-01',
        required: false,
    })
    @IsOptional()
    @IsDate()
    readonly fecha_fin: Date | null;

    @ApiProperty({
        description: 'Número de celular del titular del seguro médico (opcional)',
        example: '3001234567',
        required: false,
    })
    @IsOptional()
    @IsPhoneNumber(null)
    readonly celular: string | null;
}
