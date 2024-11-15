import { Injectable } from '@nestjs/common';
import { CreatePacienteDto } from './dto/create-paciente.dto';
import { UpdatePacienteDto } from './dto/update-paciente.dto';
import { DataSource } from 'typeorm';

@Injectable()
export class PacienteService {
  constructor(
    private readonly dataSource: DataSource,
  ) {
    
  }
  create(createPacienteDto: CreatePacienteDto) {
    return 'This action adds a new paciente';
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

  update(id: number, updatePacienteDto: UpdatePacienteDto) {
    return `This action updates a #${id} paciente`;
  }

  remove(id: number) {
    return `This action removes a #${id} paciente`;
  }
}
