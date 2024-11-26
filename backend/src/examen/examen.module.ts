import { Module } from '@nestjs/common';
import { ExamenService } from './examen.service';
import { ExamenController } from './examen.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Examen } from './entities/examen.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Examen])],
  controllers: [ExamenController],
  providers: [ExamenService],
})
export class ExamenModule {}
