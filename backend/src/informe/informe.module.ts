import { Module } from '@nestjs/common';
import { InformeService } from './informe.service';
import { InformeController } from './informe.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Informe } from './entities/informe.entity';

@Module({
  imports : [TypeOrmModule.forFeature([Informe])],
  controllers: [InformeController],
  providers: [InformeService],
})
export class InformeModule {}
