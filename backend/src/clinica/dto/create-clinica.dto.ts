import { IsOptional, IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateClinicaDto {

    @ApiProperty({
        description: 'Detalles de la clínica en formato XML',
        example: '<detalles><nombre>Clinica XYZ</nombre><ubicacion>Ciudad</ubicacion></detalles>',
        required: false, // Lo ponemos opcional según el esquema original
    })
    @IsOptional()
    @IsString()
    detalles?: string;
}
