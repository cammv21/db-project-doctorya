import { PartialType } from '@nestjs/swagger';
import { CreateClinicaDto } from './create-clinica.dto';

export class UpdateClinicaDto extends PartialType(CreateClinicaDto) {}
