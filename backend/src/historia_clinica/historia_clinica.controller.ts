import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { HistoriaClinicaService } from './historia_clinica.service';
import { CreateHistoriaClinicaDto } from './dto/create-historia_clinica.dto';
import { UpdateHistoriaClinicaDto } from './dto/update-historia_clinica.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('System - Historia Clinica')
@Controller('historia-clinica')
export class HistoriaClinicaController {
  constructor(private readonly historiaClinicaService: HistoriaClinicaService) {}

  @Post()
  create(@Body() createHistoriaClinicaDto: CreateHistoriaClinicaDto) {
    return this.historiaClinicaService.create(createHistoriaClinicaDto);
  }

  @Get()
  findAll() {
    return this.historiaClinicaService.findAll();
  }

  @Patch(':id')
  update(@Param('id') id: number, @Body() updateHistoriaClinicaDto: UpdateHistoriaClinicaDto) {
    return this.historiaClinicaService.update(id, updateHistoriaClinicaDto);
  }

  @Delete(':id')
  remove(@Param('id') id: number) {
    return this.historiaClinicaService.delete(id);
  }
}
