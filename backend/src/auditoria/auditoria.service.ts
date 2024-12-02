import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Auditoria } from './schema/auditoria.schema';
import { Model } from 'mongoose';
import { CreateAuditoriaDto } from './dto/create-auditoria.dto';


@Injectable()
export class AuditoriaService {
  constructor(
    @InjectModel(Auditoria.name) private auditoriaModel: Model<Auditoria>,
  ) {}
  async create(createAuditoriaDto: CreateAuditoriaDto) {
    const auditoria = new this.auditoriaModel(createAuditoriaDto);
    return auditoria.save();
  }

  findAll() {
    return `This action returns all auditoria`;
  }

}
