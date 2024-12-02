import { Module } from '@nestjs/common';
import { CitaService } from './cita.service';
import { CitaController } from './cita.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Cita } from './entities/cita.entity';
import { AuditoriaModule } from 'src/auditoria/auditoria.module';

@Module({
  imports: [TypeOrmModule.forFeature([Cita]), AuditoriaModule],
  controllers: [CitaController],
  providers: [CitaService],
})
export class CitaModule {}
