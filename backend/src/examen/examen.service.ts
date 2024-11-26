import { Injectable } from '@nestjs/common';
import { CreateExamenDto } from './dto/create-examan.dto';
import { UpdateExamenDto } from './dto/update-examen.dto';
import { DataSource } from 'typeorm';

@Injectable()
export class ExamenService {
  constructor(private readonly dataSource: DataSource) {}

  async create(createExamenDto: CreateExamenDto): Promise<{ message: string, examen: CreateExamenDto }> {
    const { nombre, costo, cubre_seguro, fecha, estado, historia_clinica_id } = createExamenDto;

    try {
      // Llamada a la función almacenada 'crear_examen'
      const result = await this.dataSource.query(
        `SELECT crear_examen($1, $2, $3, $4, $5, $6) AS success`,
        [nombre, costo, cubre_seguro, fecha, estado, historia_clinica_id]
      );

      const success = result[0].success;

      if (success) {
        return { message: 'Examen creado exitosamente', examen: createExamenDto };
      } else {
        return { message: 'Error al crear examen', examen: null };
      }
    } catch (error) {
      console.error('Error creando examen:', error);
      throw new Error('Error creando examen: ' + error.message);
    }
  }

  async findAll(): Promise<any[]> {
    try {
      // Llamada a la función almacenada 'obtener_todos_examenes'
      const result = await this.dataSource.query(`SELECT * FROM obtener_todos_examenes()`);
      return result;
    } catch (error) {
      console.error('Error obteniendo exámenes:', error);
      throw new Error('Error obteniendo exámenes: ' + error.message);
    }
  }

  async update(id: number, updateExamenDto: UpdateExamenDto): Promise<{ message: string }> {
    const { nombre, costo, cubre_seguro, fecha, estado } = updateExamenDto;

    try {
      // Llamada a la función almacenada 'modificar_examen'
      const result = await this.dataSource.query(
        `SELECT modificar_examen($1, $2, $3, $4, $5, $6) AS success`,
        [id, nombre, costo, cubre_seguro, fecha, estado]
      );

      const success = result[0].success;

      if (success) {
        return { message: 'Examen modificado exitosamente' };
      } else {
        return { message: 'Error al modificar examen' };
      }
    } catch (error) {
      console.error('Error modificando examen:', error);
      throw new Error('Error modificando examen: ' + error.message);
    }
  }

  async remove(id: number): Promise<{ message: string }> {
    try {
      // Llamada a la función almacenada 'eliminar_examen'
      const result = await this.dataSource.query(
        `SELECT eliminar_examen($1) AS success`,
        [id]
      );

      const success = result[0].success;

      if (success) {
        return { message: 'Examen eliminado exitosamente' };
      } else {
        return { message: 'Error al eliminar examen' };
      }
    } catch (error) {
      console.error('Error eliminando examen:', error);
      throw new Error('Error eliminando examen: ' + error.message);
    }
  }
}
