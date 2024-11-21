import { Injectable } from '@nestjs/common';
import { CreateMedicamentoDto } from './dto/create-medicamento.dto';
import { UpdateMedicamentoDto } from './dto/update-medicamento.dto';

@Injectable()
export class MedicamentoService {
  create(createMedicamentoDto: CreateMedicamentoDto) {
    return 'This action adds a new medicamento';
  }

  findAll() {
    return `This action returns all medicamento`;
  }

  findOne(id: number) {
    return `This action returns a #${id} medicamento`;
  }

  update(id: number, updateMedicamentoDto: UpdateMedicamentoDto) {
    return `This action updates a #${id} medicamento`;
  }

  remove(id: number) {
    return `This action removes a #${id} medicamento`;
  }
}
