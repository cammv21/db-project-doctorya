import { Injectable } from '@nestjs/common';
import { CreateSeguroMedicoDto } from './dto/create-seguro_medico.dto';
import { UpdateSeguroMedicoDto } from './dto/update-seguro_medico.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { SeguroMedico } from './entities/seguro_medico.entity';
import { Repository } from 'typeorm';

@Injectable()
export class SeguroMedicoService {
  constructor(
    @InjectRepository(SeguroMedico)
    private readonly seguroMedicoRepository: Repository<SeguroMedico>
  ){}

  create(createSeguroMedicoDto: CreateSeguroMedicoDto) {
    return 'This action adds a new seguroMedico';
  }

  async findAll() {
    return await this.seguroMedicoRepository.find();
  }

  findOne(id: number) {
    return `This action returns a #${id} seguroMedico`;
  }

  update(id: number, updateSeguroMedicoDto: UpdateSeguroMedicoDto) {
    return `This action updates a #${id} seguroMedico`;
  }

  remove(id: number) {
    return `This action removes a #${id} seguroMedico`;
  }
}
