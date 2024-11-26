import { Injectable } from '@nestjs/common';
import { CreateClinicaDto } from './dto/create-clinica.dto';
import { UpdateClinicaDto } from './dto/update-clinica.dto';
import { DataSource } from 'typeorm';

@Injectable()
export class ClinicaService {
  constructor( private readonly dataSource: DataSource ) {}

  async create(createClinicaDto: CreateClinicaDto): Promise<{ message: string; clinica: CreateClinicaDto }> {
    const { detalles } = createClinicaDto;

    try {
      const result = await this.dataSource.query(
        `SELECT public.crear_clinica($1) AS success`,
        [detalles]
      );

      const success = result[0].success;

      if (success) {
        return { message: 'Clínica creada exitosamente', clinica: createClinicaDto };
      } else {
        return { message: 'No se pudo crear la clínica', clinica: null };
      }
    } catch (error) {
      console.error('Error creando clínica:', error);
      throw new Error('Error creando clínica: ' + error.message);
    }
  }

  async findAll(): Promise<{ message: string; clinicas: any[] }> {
    try {
      const result = await this.dataSource.query(
        `SELECT * FROM public.obtener_todas_clinicas()`
      );

      if (result.length > 0) {
        return { message: 'Clínicas obtenidas exitosamente', clinicas: result };
      } else {
        return { message: 'No se encontraron clínicas', clinicas: [] };
      }
    } catch (error) {
      console.error('Error obteniendo todas las clínicas:', error);
      throw new Error('Error obteniendo todas las clínicas: ' + error.message);
    }
  }

  async obtenerDirector(nombre_clinica: string): Promise<{ message: string; director: string }> {
    try {
      const result = await this.dataSource.query(
        `SELECT public.obtener_director_clinica($1) AS director`,
        [nombre_clinica]
      );

      const director = result[0]?.director;

      if (director) {
        return { message: 'Director encontrado', director };
      } else {
        return { message: `No se encontró director para la clínica ${nombre_clinica}`, director: null };
      }
    } catch (error) {
      console.error('Error obteniendo el director de la clínica:', error);
      throw new Error('Error obteniendo director: ' + error.message);
    }
  }

  async modificarClinica(director_nombre: string, detalles: string): Promise<{ message: string; success: boolean }> {
    try {
      const result = await this.dataSource.query(
        `SELECT public.modificar_clinica_por_director($1, $2) AS success`,
        [director_nombre, detalles]
      );

      const success = result[0].success;

      if (success) {
        return { message: 'Clínica modificada correctamente', success: true };
      } else {
        return { message: `No se encontró la clínica con director ${director_nombre}`, success: false };
      }
    } catch (error) {
      console.error('Error modificando clínica:', error);
      throw new Error('Error modificando clínica: ' + error.message);
    }
  }

  async delete(nombre_clinica: string): Promise<{ message: string; success: boolean }> {
    try {
      const result = await this.dataSource.query(
        `SELECT public.eliminar_clinica_por_nombre($1) AS success`,
        [nombre_clinica]
      );

      const success = result[0].success;

      if (success) {
        return { message: 'Clínica eliminada correctamente', success: true };
      } else {
        return { message: `No se encontró la clínica con nombre ${nombre_clinica}`, success: false };
      }
    } catch (error) {
      console.error('Error eliminando clínica:', error);
      throw new Error('Error eliminando clínica: ' + error.message);
    }
  }
}
