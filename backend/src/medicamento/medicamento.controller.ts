import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { MedicamentoService } from './medicamento.service';
import { CreateMedicamentoDto } from './dto/create-medicamento.dto';
import { UpdateMedicamentoDto } from './dto/update-medicamento.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('System - Medicamento')
@Controller('medicamento')
export class MedicamentoController {
  constructor(private readonly medicamentoService: MedicamentoService) {}

  @Post()
  create(@Body() createMedicamentoDto: CreateMedicamentoDto) {
    return this.medicamentoService.create(createMedicamentoDto);
  }

  @Get()
  findAll() {
    return this.medicamentoService.findAll();
  }

  @Patch(':id')
  update(@Param('id') id: number, @Body() updateMedicamentoDto: UpdateMedicamentoDto) {
    return this.medicamentoService.update(id, updateMedicamentoDto);
  }

  @Delete(':id')
  remove(@Param('id') id: number) {
    return this.medicamentoService.remove(id);
  }
}
