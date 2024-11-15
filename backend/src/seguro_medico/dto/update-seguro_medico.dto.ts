import { PartialType } from '@nestjs/swagger';
import { CreateSeguroMedicoDto } from './create-seguro_medico.dto';

export class UpdateSeguroMedicoDto extends PartialType(CreateSeguroMedicoDto) {}
