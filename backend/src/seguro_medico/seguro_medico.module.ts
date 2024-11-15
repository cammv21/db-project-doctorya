import { Module } from '@nestjs/common';
import { SeguroMedicoService } from './seguro_medico.service';
import { SeguroMedicoController } from './seguro_medico.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SeguroMedico } from './entities/seguro_medico.entity';

@Module({
  imports: [TypeOrmModule.forFeature([SeguroMedico])],
  controllers: [SeguroMedicoController],
  providers: [SeguroMedicoService],
})
export class SeguroMedicoModule {}
