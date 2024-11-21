import { Module } from '@nestjs/common';
import { HistoriaClinicaService } from './historia_clinica.service';
import { HistoriaClinicaController } from './historia_clinica.controller';

@Module({
  controllers: [HistoriaClinicaController],
  providers: [HistoriaClinicaService],
})
export class HistoriaClinicaModule {}
