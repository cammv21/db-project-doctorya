import { PartialType } from '@nestjs/swagger';
import { CreateExamanDto } from './create-examan.dto';

export class UpdateExamanDto extends PartialType(CreateExamanDto) {}
