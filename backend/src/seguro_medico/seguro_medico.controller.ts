import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { SeguroMedicoService } from './seguro_medico.service';
import { CreateSeguroMedicoDto } from './dto/create-seguro_medico.dto';
import { UpdateSeguroMedicoDto } from './dto/update-seguro_medico.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('System - Seguro Medico')
@Controller('seguro-medico')
export class SeguroMedicoController {
  constructor(private readonly seguroMedicoService: SeguroMedicoService) {}

  @Post()
  create(@Body() createSeguroMedicoDto: CreateSeguroMedicoDto) {
    return this.seguroMedicoService.create(createSeguroMedicoDto);
  }

  @Get()
  findAll() {
    return this.seguroMedicoService.findAll();
  }

  // @Get(':id')
  // findOne(@Param('id') id: string) {
  //   return this.seguroMedicoService.findOne(+id);
  // }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateSeguroMedicoDto: UpdateSeguroMedicoDto) {
    return this.seguroMedicoService.update(+id, updateSeguroMedicoDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.seguroMedicoService.remove(+id);
  }

  @Post('vincular')
  async vincularSeguroAPaciente(
    @Body() body: { paciente_id: number, seguro_id: number }
  ) {
    return this.seguroMedicoService.vincularSeguroAPaciente(body.paciente_id, body.seguro_id);
  }
}
