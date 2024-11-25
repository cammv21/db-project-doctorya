import { Injectable, InternalServerErrorException } from '@nestjs/common';
import { CreateCitaDto } from './dto/create-cita.dto';
import { UpdateCitaDto } from './dto/update-cita.dto';
import { DataSource } from 'typeorm';

@Injectable()
export class CitaService {
  constructor(private readonly dataSource: DataSource) {}
  async create(createCitaDto: CreateCitaDto): Promise<{ message: string; cita: CreateCitaDto }> {
    const { fecha, hora, motivo, estado, paciente_id, medico_id } = createCitaDto;

    try {
      const result = await this.dataSource.query(
        `SELECT public.crear_cita($1, $2, $3, $4, $5, $6) AS success`,
        [fecha, hora, motivo, estado, paciente_id, medico_id]
      );

      const success = result[0].success;

      if (success) {
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
      const result = await this.dataSource.query(`SELECT * FROM public.obtener_citas()`);
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
