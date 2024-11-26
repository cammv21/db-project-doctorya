import { PartialType } from '@nestjs/swagger';
import { CreateExamenDto } from './create-examan.dto';

export class UpdateExamenDto extends PartialType(CreateExamenDto) {}
