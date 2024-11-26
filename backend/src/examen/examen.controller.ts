import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { ExamenService } from './examen.service';
import { CreateExamenDto } from './dto/create-examan.dto';
import { UpdateExamenDto } from './dto/update-examen.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('System - Examen')
@Controller('examen')
export class ExamenController {
  constructor(private readonly examenService: ExamenService) {}

  @Post()
  create(@Body() createExamenDto: CreateExamenDto) {
    return this.examenService.create(createExamenDto);
  }

  @Get()
  findAll() {
    return this.examenService.findAll();
  }

  @Patch(':id')
  update(@Param('id') id: number, @Body() updateExamenDto: UpdateExamenDto) {
    return this.examenService.update(id, updateExamenDto);
  }

  @Delete(':id')
  remove(@Param('id') id: number) {
    return this.examenService.remove(id);
  }
}
