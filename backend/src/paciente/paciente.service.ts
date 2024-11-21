import { Injectable } from '@nestjs/common';
import { CreatePacienteDto } from './dto/create-paciente.dto';
import { UpdatePacienteDto } from './dto/update-paciente.dto';
import { DataSource } from 'typeorm';

@Injectable()
export class PacienteService {
  constructor(
    private readonly dataSource: DataSource,
  ) {}

  async create(createPacienteDto: CreatePacienteDto) {
    const { nombre, identificacion, fecha_nacimiento, sexo, direccion, email, celular, seguro_id } = createPacienteDto;
  
    try {
      const result = await this.dataSource.query(
        `SELECT crear_paciente($1, $2, $3, $4, $5, $6, $7, $8) AS success`,
        [
          nombre,
          identificacion,
          fecha_nacimiento,
          sexo,
          direccion,
          email,
          celular,
          seguro_id || null, // Pasar null si no se especifica seguro_id
        ]
      );
  
      // Verifica el resultado
      if (result[0]?.success) {
        return { message: 'Paciente creado exitosamente' };
      } else {
        throw new Error('No se pudo crear el paciente');
      }
    } catch (error) {
      console.error('Error creando paciente:', error);
      throw new Error('Error creando paciente: ' + error.message);
    }
  }
  

  async findAll() {
    try {
      const result = await this.dataSource.query(
        `SELECT * FROM obtener_pacientes()`
      );
      
      // El resultado contiene los registros devueltos por la función
      return result;  // Devuelve un arreglo de pacientes
    } catch (error) {
      console.error('Error obteniendo pacientes', error);
      return [];
    }
  }

  findOne(id: number) {
    return `This action returns a #${id} paciente`;
  }

  async update(id: number, updatePacienteDto: UpdatePacienteDto) {
    const {
      nombre,
      identificacion,
      fecha_nacimiento,
      sexo,
      direccion,
      email,
      celular,
      seguro_id,
    } = updatePacienteDto;
  
    try {
      const result = await this.dataSource.query(
        `SELECT modificar_paciente($1, $2, $3, $4, $5, $6, $7, $8, $9) AS success`,
        [
          id,
          nombre,
          identificacion,
          fecha_nacimiento,
          sexo,
          direccion,
          email,
          celular,
          seguro_id || null, // Pasar null si el campo es opcional
        ]
      );
  
      if (result[0]?.success) {
        return { message: 'Paciente actualizado exitosamente' };
      } else {
        throw new Error('No se pudo actualizar el paciente');
      }
    } catch (error) {
      console.error('Error actualizando paciente:', error);
      throw new Error('Error actualizando paciente: ' + error.message);
    }
  }
  

  async remove(id: number) {
    try {
      const result = await this.dataSource.query(
        `SELECT eliminar_paciente($1) AS success`,
        [id]
      );
  
      // Verifica el resultado
      if (result[0]?.success) {
        return { message: 'Paciente eliminado exitosamente' };
      } else {
        throw new Error('No se pudo eliminar el paciente');
      }
    } catch (error) {
      console.error('Error eliminando paciente:', error);
      throw new Error('Error eliminando paciente: ' + error.message);
    }
  }
  
}
