import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { ClinicaService } from './clinica.service';
import { CreateClinicaDto } from './dto/create-clinica.dto';
import { UpdateClinicaDto } from './dto/update-clinica.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('System - Clinica')
@Controller('clinica')
export class ClinicaController {
  constructor(private readonly clinicaService: ClinicaService) {}

  @Post()
  create(@Body() createClinicaDto: CreateClinicaDto) {
    return this.clinicaService.create(createClinicaDto);
  }

  @Get()
  async findAll(): Promise<{ message: string; clinicas: any[] }> {
    return this.clinicaService.findAll();
  }
  @Get('obtener-director')
  async obtenerDirector(@Body() body: { nombre_clinica: string }): Promise<{ message: string; director: string }> {
    return this.clinicaService.obtenerDirector(body.nombre_clinica);
  }

  @Patch(':nombre-director')
  async modificar(@Body() body: { director_nombre: string, detalles: string }): Promise<{ message: string; success: boolean }> {
    return this.clinicaService.modificarClinica(body.director_nombre, body.detalles);
  }

  @Delete(':nombre')
  async delete(@Param() nombre: string): Promise<{ message: string; success: boolean }> {
    return this.clinicaService.delete(nombre);
  }
}
