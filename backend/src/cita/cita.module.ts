import { Module } from '@nestjs/common';
import { CitaService } from './cita.service';
import { CitaController } from './cita.controller';

@Module({
  controllers: [CitaController],
  providers: [CitaService],
})
export class CitaModule {}
