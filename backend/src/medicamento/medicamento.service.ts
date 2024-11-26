import { Injectable } from '@nestjs/common';
import { CreateMedicamentoDto } from './dto/create-medicamento.dto';
import { UpdateMedicamentoDto } from './dto/update-medicamento.dto';
import { DataSource } from 'typeorm';

@Injectable()
export class MedicamentoService {
  constructor(private readonly dataSource: DataSource) { }
  async create(createMedicamentoDto: CreateMedicamentoDto): Promise<{ message: string, medicamento: CreateMedicamentoDto }> {
    const { nombre, principio_activo, forma_farmaceutica, dosis, indicaciones, duracion, estado, historia_clinica_id } = createMedicamentoDto;

    try {
      const result = await this.dataSource.query(
        `SELECT public.crear_medicamento($1, $2, $3, $4, $5, $6, $7, $8) AS success`,
        [nombre, principio_activo, forma_farmaceutica, dosis, indicaciones, duracion, estado, historia_clinica_id]
      );

      const success = result[0].success;

      if (success) {
        return { message: 'Medicamento creado exitosamente', medicamento: createMedicamentoDto };
      } else {
        return { message: 'Error al crear medicamento', medicamento: null };
      }
    } catch (error) {
      console.error('Error creando medicamento:', error);
      throw new Error('Error creando medicamento: ' + error.message);
    }
  }


  async findAll(): Promise<any[]> {
    try {
      const result = await this.dataSource.query(`SELECT * FROM public.obtener_medicamentos()`);
      return result;
    } catch (error) {
      console.error('Error obteniendo medicamentos:', error);
      throw new Error('Error obteniendo medicamentos: ' + error.message);
    }
  }

  async update(id: number, updateMedicamentoDto: UpdateMedicamentoDto): Promise<{ message: string, medicamento: UpdateMedicamentoDto }> {
    const { nombre, principio_activo, forma_farmaceutica, dosis, indicaciones, duracion, estado } = updateMedicamentoDto;

    try {
      const result = await this.dataSource.query(
        `SELECT public.modificar_medicamento($1, $2, $3, $4, $5, $6, $7, $8) AS success`,
        [id, nombre, principio_activo, forma_farmaceutica, dosis, indicaciones, duracion, estado]
      );

      const success = result[0].success;

      if (success) {
        return { message: 'Medicamento modificado exitosamente', medicamento: updateMedicamentoDto };
      } else {
        return { message: 'Error al modificar medicamento', medicamento: null };
      }
    } catch (error) {
      console.error('Error modificando medicamento:', error);
      throw new Error('Error modificando medicamento: ' + error.message);
    }
  }


  async remove(id: number): Promise<{ message: string }> {
    try {
      const result = await this.dataSource.query(
        `SELECT public.eliminar_medicamento($1) AS success`,
        [id]
      );

      const success = result[0].success;

      if (success) {
        return { message: 'Medicamento eliminado exitosamente' };
      } else {
        return { message: 'Error al eliminar medicamento' };
      }
    } catch (error) {
      console.error('Error eliminando medicamento:', error);
      throw new Error('Error eliminando medicamento: ' + error.message);
    }
  }

}
