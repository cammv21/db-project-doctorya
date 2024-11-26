import { ApiProperty } from '@nestjs/swagger';
import { IsDateString, IsNumber, IsOptional, IsString, Length } from "class-validator";

export class CreatePacienteDto {
    @ApiProperty({
        description: 'Nombre completo del paciente',
        example: 'Juan Pérez',
    })
    @IsString()
    nombre: string;

    @ApiProperty({
        description: 'Número de identificación del paciente',
        example: '1234567890',
    })
    @IsString()
    identificacion: string;

    @ApiProperty({
        description: 'Fecha de nacimiento del paciente en formato ISO 8601',
        example: '1990-01-01',
    })
    @IsDateString()
    fecha_nacimiento: string;

    @ApiProperty({
        description: 'Sexo del paciente. Solo un carácter: M para masculino, F para femenino',
        example: 'M',
    })
    @IsString()
    @Length(1, 1) // Limitar a un solo carácter
    sexo: string;

    @ApiProperty({
        description: 'Dirección del paciente',
        example: 'Calle Ficticia 123, Ciudad X',
    })
    @IsString()
    direccion: string;

    @ApiProperty({
        description: 'Correo electrónico del paciente',
        example: 'juan.perez@example.com',
    })
    @IsString()
    email: string;

    @ApiProperty({
        description: 'Número de celular del paciente',
        example: '3001234567',
    })
    @IsString()
    celular: string;

    @ApiProperty({
        description: 'ID del seguro médico del paciente (opcional)',
        example: 1,
        required: false, // Hacerlo opcional en Swagger
    })
    @IsNumber()
    @IsOptional() // Hacer que sea opcional si no siempre se requiere
    seguro_id?: number;
}

