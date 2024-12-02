import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { InformeService } from './informe.service';
import { CreateInformeDto } from './dto/create-informe.dto';
import { UpdateInformeDto } from './dto/update-informe.dto';

@Controller('informe')
export class InformeController {
  constructor(private readonly informeService: InformeService) {}

  @Get()
  async obtenerInformes() {
      return this.informeService.obtenerInformes();
  }

  @Post('citas-mes-medico/:medico_id')
  async generarInformeCitasMesMedico(@Param('medico_id') medico_id: number) {
      return this.informeService.generarInformeCitasMesMedico(medico_id);
  }

  @Post('citas-pendientes')
  async generarInformeCitasPendientes() {
      return this.informeService.generarInformeCitasPendientes();
  }

  @Post('medicamentos-entregados')
  async generarInformeMedicamentosEntregados() {
      return this.informeService.generarInformeMedicamentosEntregados();
  }

  @Post('examenes-pendientes')
  async generarInformeExamenesPendientes() {
      return this.informeService.generarInformeExamenesPendientes();
  }

}
