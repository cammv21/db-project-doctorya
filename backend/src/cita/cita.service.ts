import { Injectable, InternalServerErrorException } from '@nestjs/common';
import { CreateCitaDto } from './dto/create-cita.dto';
import { UpdateCitaDto } from './dto/update-cita.dto';
import { DataSource } from 'typeorm';
import { AuditoriaService } from 'src/auditoria/auditoria.service';
import { CreateAuditoriaDto } from 'src/auditoria/dto/create-auditoria.dto';

@Injectable()
export class CitaService {
  constructor(
    private readonly dataSource: DataSource,
    private readonly auditoriaService: AuditoriaService,

  ) {}
  async create(createCitaDto: CreateCitaDto): Promise<{ message: string; cita: CreateCitaDto }> {
    const { fecha, hora, motivo, estado, paciente_id, medico_id } = createCitaDto;

    try {
      const result = await this.dataSource.query(
        `SELECT public.crear_cita($1, $2, $3, $4, $5, $6) AS cita_id`,
        [fecha, hora, motivo, estado, paciente_id, medico_id]
      );

      const cita_id = result[0]?.cita_id;
      
      if (cita_id) {
        

        const detalles = await this.dataSource.query(
          `SELECT * FROM public.obtener_detalles_cita($1) AS detalles`,
          [cita_id]
        )
        console.log(detalles);
        const auditoriaDto = {
          fecha: detalles[0].fecha, // Asumiendo que 'fecha' es un campo de detalles[0]
          nombre_paciente: detalles[0].nombre_paciente, // Asegúrate de que 'nombre_paciente' está en detalles[0]
          nombre_medico: detalles[0].nombre_medico, // Asegúrate de que 'nombre_medico' está en detalles[0]
          motivo_cita: detalles[0].motivo_cita, 
        } as CreateAuditoriaDto;

        await this.auditoriaService.create(auditoriaDto);
        
        return { 
          message: 'Cita creada exitosamente',
          cita: createCitaDto 
        };
      } else {
        return {
          message: 'El médico está ocupado en ese horario',
          cita: null
        };
      }
    } catch (error) {
      console.error('Error creando cita:', error);
      throw new Error('Error creando cita: ' + error.message);
    }
  }

  async findAll(): Promise<any[]> {
    try {
      const result = await this.dataSource.query(`SELECT * FROM public.obtener_todas_las_citas()`);
      return result;
    } catch (error) {
      console.error('Error obteniendo citas:', error);
      throw new InternalServerErrorException('Error obteniendo citas: ' + error.message);
    }
  }

  findOne(id: number) {
    return `This action returns a #${id} cita`;
  }

  async update(id: number, updateCitaDto: UpdateCitaDto): Promise<{ message: string }> {
    const { fecha, hora, motivo, estado, paciente_id, medico_id } = updateCitaDto;

    try {
      const result = await this.dataSource.query(
        `SELECT public.modificar_cita($1, $2, $3, $4, $5, $6, $7) AS success`,
        [id, fecha, hora, motivo, estado, paciente_id, medico_id]
      );

      const success = result[0].success;

      if (success) {
        return { message: 'Cita modificada exitosamente' };
      } else {
        throw new Error('No se pudo modificar la cita');
      }
    } catch (error) {
      console.error('Error modificando cita:', error);
      throw new InternalServerErrorException('Error modificando cita: ' + error.message);
    }
  }

  async remove(id: number): Promise<{ message: string }> {
    try {
      const result = await this.dataSource.query(
        `SELECT public.eliminar_cita($1) AS success`,
        [id]
      );

      const success = result[0].success;

      if (success) {
        return { message: `Cita con ID ${id} eliminada exitosamente` };
      } else {
        throw new Error('No se pudo eliminar la cita');
      }
    } catch (error) {
      console.error('Error eliminando cita:', error);
      throw new InternalServerErrorException('Error eliminando cita: ' + error.message);
    }
  }
}
