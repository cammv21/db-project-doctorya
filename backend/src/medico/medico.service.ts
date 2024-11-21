import { Injectable } from '@nestjs/common';
import { CreateMedicoDto } from './dto/create-medico.dto';
import { UpdateMedicoDto } from './dto/update-medico.dto';
import { DataSource } from 'typeorm';

@Injectable()
export class MedicoService {
  constructor(
    private readonly dataSource: DataSource,
  ){}
  
  async create(createMedicoDto: CreateMedicoDto) {
    const { nombre, identificacion, registro_medico, especialidad, email, celular } = createMedicoDto;

  try {
    const result = await this.dataSource.query(
      `SELECT crear_medico($1, $2, $3, $4, $5, $6) AS success`,
      [nombre, identificacion, registro_medico, especialidad, email, celular]
    );

    if (result[0]?.success) {
      return { message: 'Médico creado exitosamente' };
    } else {
      throw new Error('No se pudo crear el médico');
    }
  } catch (error) {
    console.error('Error creando médico:', error);
    throw new Error('Error creando médico: ' + error.message);
  }
  }

  async findAll() {
    try {
      const result = await this.dataSource.query(
        `SELECT * FROM obtener_medicos()`
      );
  
      return result; // Devuelve un arreglo de médicos
    } catch (error) {
      console.error('Error obteniendo médicos:', error);
      throw new Error('Error al obtener los médicos: ' + error.message);
    }
  }

  findOne(id: number) {
    return `This action returns a #${id} medico`;
  }

  async update(id: number, updateMedicoDto: UpdateMedicoDto) {
    const { nombre, identificacion, registro_medico, especialidad, email, celular } = updateMedicoDto;

    try {
      const result = await this.dataSource.query(
        `SELECT modificar_medico($1, $2, $3, $4, $5, $6, $7) AS success`,
        [id, nombre, identificacion, registro_medico, especialidad, email, celular]
      );

      if (result[0]?.success) {
        return { message: 'Médico actualizado exitosamente' };
      } else {
        throw new Error('No se pudo actualizar el médico');
      }
    } catch (error) {
      console.error('Error actualizando médico:', error);
      throw new Error('Error actualizando médico: ' + error.message);
    }
  }

  async remove(id: number) {
    try {
      const result = await this.dataSource.query(
        `SELECT eliminar_medico($1) AS success`,
        [id]
      );
  
      if (result[0]?.success) {
        return { message: 'Médico eliminado exitosamente' };
      } else {
        throw new Error('No se pudo eliminar el médico');
      }
    } catch (error) {
      console.error('Error eliminando médico:', error);
      throw new Error('Error eliminando médico: ' + error.message);
    }
  }
}
