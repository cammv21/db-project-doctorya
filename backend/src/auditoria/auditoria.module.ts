import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { AuditoriaService } from './auditoria.service';
import { AuditoriaController } from './auditoria.controller';
import { AuditoriaSchema } from './schema/auditoria.schema';

@Module({
  imports: [MongooseModule.forFeature([{ name: 'Auditoria', schema: AuditoriaSchema }])],
  controllers: [AuditoriaController],
  providers: [AuditoriaService],
  exports: [AuditoriaService],
})
export class AuditoriaModule {}
