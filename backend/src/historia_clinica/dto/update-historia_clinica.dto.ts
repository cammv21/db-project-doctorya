import { PartialType } from '@nestjs/swagger';
import { CreateHistoriaClinicaDto } from './create-historia_clinica.dto';

export class UpdateHistoriaClinicaDto extends PartialType(CreateHistoriaClinicaDto) {}
