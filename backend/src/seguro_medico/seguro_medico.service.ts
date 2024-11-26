import { Injectable } from '@nestjs/common';
import { CreateSeguroMedicoDto } from './dto/create-seguro_medico.dto';
import { UpdateSeguroMedicoDto } from './dto/update-seguro_medico.dto';
import { DataSource } from 'typeorm';

@Injectable()
export class SeguroMedicoService {
  constructor(private readonly dataSource: DataSource){}

  async create(createSeguroMedicoDto: CreateSeguroMedicoDto): Promise<{ message: string, seguroMedico: CreateSeguroMedicoDto }> {
    const { nombre, tipo, fecha_inicio, fecha_fin, celular } = createSeguroMedicoDto;
  
    try {
      await this.dataSource.query(
        `CALL crear_seguro_medico($1, $2, $3, $4, $5)`,
        [nombre, tipo, fecha_inicio, fecha_fin, celular]
      );
  
      return { message: 'Seguro médico creado exitosamente', seguroMedico: createSeguroMedicoDto };
    } catch (error) {
      console.error('Error creando seguro médico:', error);
      return { message: 'Error al crear seguro médico', seguroMedico: null };
    }
  }

  async findAll(): Promise<any[]> {
    try {
      const result = await this.dataSource.query(`SELECT * FROM obtener_seguros_medicos()`);
      return result;
    } catch (error) {
      console.error('Error obteniendo seguros médicos:', error);
      throw new Error('Error obteniendo seguros médicos: ' + error.message);
    }
  }

  async update(id: number, updateSeguroMedicoDto: UpdateSeguroMedicoDto): Promise<{ message: string, seguroMedico: UpdateSeguroMedicoDto }> {
    const { nombre, tipo, fecha_inicio, fecha_fin, celular } = updateSeguroMedicoDto;

    try {
      const result = await this.dataSource.query(
        `CALL modificar_seguro_medico($1, $2, $3, $4, $5, $6)`,
        [id, nombre, tipo, fecha_inicio, fecha_fin, celular]
      );

      const success = result[0].success;

      if (success) {
        return { message: 'Seguro médico modificado exitosamente', seguroMedico: updateSeguroMedicoDto };
      } else {
        return { message: 'Error al modificar seguro médico', seguroMedico: null };
      }
    } catch (error) {
      console.error('Error modificando seguro médico:', error);
      throw new Error('Error modificando seguro médico: ' + error.message);
    }
  }

  async remove(id: number): Promise<{ message: string }> {
    try {
      const result = await this.dataSource.query(
        `CALL eliminar_seguro_medico($1)`,
        [id]
      );

      const success = result[0].success;

      if (success) {
        return { message: 'Seguro médico eliminado exitosamente' };
      } else {
        return { message: 'Error al eliminar seguro médico' };
      }
    } catch (error) {
      console.error('Error eliminando seguro médico:', error);
      throw new Error('Error eliminando seguro médico: ' + error.message);
    }
  }

  async vincularSeguroAPaciente(pacienteId: number, seguroId: number): Promise<{ message: string }> {
    try {
      const result = await this.dataSource.query(
        `CALL vincular_seguro_a_paciente($1, $2)`,
        [pacienteId, seguroId]
      );

      const success = result[0].success;

      if (success) {
        return { message: 'Seguro médico vinculado al paciente exitosamente' };
      } else {
        return { message: 'Error al vincular seguro médico al paciente' };
      }
    } catch (error) {
      console.error('Error vinculando seguro médico al paciente:', error);
      throw new Error('Error vinculando seguro médico al paciente: ' + error.message);
    }
  }
}
