import { Injectable } from '@nestjs/common';
import { CreateHistoriaClinicaDto } from './dto/create-historia_clinica.dto';
import { UpdateHistoriaClinicaDto } from './dto/update-historia_clinica.dto';
import { DataSource } from 'typeorm';

@Injectable()
export class HistoriaClinicaService {
  constructor( private readonly dataSource: DataSource) {}
  async create(createHistoriaClinicaDto: CreateHistoriaClinicaDto): Promise<{ message: string; historia_clinica: CreateHistoriaClinicaDto }> {
    const { fecha, sintomas, diagnostico, tratamiento, observaciones, cita_id } = createHistoriaClinicaDto;

    try {
      const result = await this.dataSource.query(
        `SELECT public.crear_historia_clinica($1, $2, $3, $4, $5, $6) AS success`,
        [fecha, sintomas, diagnostico, tratamiento, observaciones, cita_id]
      );

      const success = result[0].success;

      if (success) {
        return { message: 'Historia clínica creada exitosamente', historia_clinica: createHistoriaClinicaDto };
      } else {
        return { message: 'No se pudo crear la historia clínica', historia_clinica: null }; 
      }
    } catch (error) {
      console.error('Error creando historia clínica:', error);
      throw new Error('Error creando historia clínica: ' + error.message);
    }
  }

  async findAll(): Promise<any[]> {
    try {
      const result = await this.dataSource.query(
        `SELECT * FROM public.obtener_todas_historias_clinicas()`
      );
      return result;
    } catch (error) {
      console.error('Error obteniendo historias clínicas:', error);
      throw new Error('Error obteniendo historias clínicas: ' + error.message);
    }
  }

  async update(
    id: number,
    updateHistoriaClinicaDto: UpdateHistoriaClinicaDto,
  ): Promise<{ message: string; success: boolean }> {
    const { fecha, sintomas, diagnostico, tratamiento, observaciones } = updateHistoriaClinicaDto;

    try {
      const result = await this.dataSource.query(
        `SELECT public.modificar_historia_clinica($1, $2, $3, $4, $5, $6) AS success`,
        [id, fecha, sintomas, diagnostico, tratamiento, observaciones]
      );

      const success = result[0].success;

      if (success) {
        return { message: 'Historia clínica actualizada exitosamente', success: true };
      } else {
        return { message: `No se encontró la historia clínica con ID ${id}`, success: false };
      }
    } catch (error) {
      console.error('Error actualizando historia clínica:', error);
      throw new Error('Error actualizando historia clínica: ' + error.message);
    }
  }

  async delete(id: number): Promise<{ message: string; success: boolean }> {
    try {
      const result = await this.dataSource.query(
        `SELECT public.eliminar_historia_clinica($1) AS success`,
        [id]
      );

      const success = result[0].success;

      if (success) {
        return { message: 'Historia clínica eliminada exitosamente', success: true };
      } else {
        return { message: `No se encontró la historia clínica con ID ${id}`, success: false };
      }
    } catch (error) {
      console.error('Error eliminando historia clínica:', error);
      throw new Error('Error eliminando historia clínica: ' + error.message);
    }
  }
}
