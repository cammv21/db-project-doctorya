import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { MedicoService } from './medico.service';
import { CreateMedicoDto } from './dto/create-medico.dto';
import { UpdateMedicoDto } from './dto/update-medico.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('System - Medico')
@Controller('medico')
export class MedicoController {
  constructor(private readonly medicoService: MedicoService) {}

  @Post()
  create(@Body() createMedicoDto: CreateMedicoDto) {
    return this.medicoService.create(createMedicoDto);
  }

  @Get()
  findAll() {
    return this.medicoService.findAll();
  }

  // @Get(':id')
  // findOne(@Param('id') id: number) {
  //   return this.medicoService.findOne(id);
  // }

  @Patch(':id')
  update(@Param('id') id: number, @Body() updateMedicoDto: UpdateMedicoDto) {
    return this.medicoService.update(id, updateMedicoDto);
  }

  @Delete(':id')
  remove(@Param('id') id: number) {
    return this.medicoService.remove(id);
  }
}
