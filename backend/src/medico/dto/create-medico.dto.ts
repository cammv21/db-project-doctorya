import { ApiProperty } from '@nestjs/swagger';
import { IsString } from 'class-validator';

export class CreateMedicoDto {
    
    @ApiProperty({
        description: 'Nombre del médico',
        example: 'Dr. Juan Pérez',
        required: true,
    })
    @IsString()
    nombre: string;

    @ApiProperty({
        description: 'Identificación del médico',
        example: '123456789',
        required: true,
    })
    @IsString()
    identificacion: string;

    @ApiProperty({
        description: 'Número de registro médico del médico',
        example: 'RM12345',
        required: true,
    })
    @IsString()
    registro_medico: string;

    @ApiProperty({
        description: 'Especialidad del médico',
        example: 'Cardiología',
        required: true,
    })
    @IsString()
    especialidad: string;

    @ApiProperty({
        description: 'Correo electrónico del médico',
        example: 'juan.perez@hospital.com',
        required: true,
    })
    @IsString()
    email: string;

    @ApiProperty({
        description: 'Número de celular del médico',
        example: '3001234567',
        required: true,
    })
    @IsString()
    celular: string;
}

