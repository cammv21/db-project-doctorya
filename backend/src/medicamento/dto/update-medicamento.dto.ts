import { PartialType } from '@nestjs/swagger';
import { CreateMedicamentoDto } from './create-medicamento.dto';

export class UpdateMedicamentoDto extends PartialType(CreateMedicamentoDto) {}
