import { Injectable } from '@nestjs/common';
import { CreateInformeDto } from './dto/create-informe.dto';
import { UpdateInformeDto } from './dto/update-informe.dto';
import { DataSource } from 'typeorm';

@Injectable()
export class InformeService {
  constructor(
    private readonly dataSource: DataSource
  ){}

  async generarInformeCitasMesMedico(medicoId: number) {
    try {
        const result = await this.dataSource.query(
            `CALL generar_informe_citas_mes_medico($1)`,
            [medicoId]
        );

        return {
            message: `Informe de citas del mes generado para el médico con ID ${medicoId}.`,
        };
    } catch (error) {
        console.error('Error generando informe de citas del mes del médico:', error);
        throw new Error('Error generando informe: ' + error.message);
    }
  }

  async generarInformeCitasPendientes() {
    try {
        await this.dataSource.query(`CALL generar_informe_citas_pendientes()`);

        return {
            message: 'Informe de citas pendientes generado exitosamente.',
        };
    } catch (error) {
        console.error('Error generando informe de citas pendientes:', error);
        throw new Error('Error generando informe: ' + error.message);
    } 
  }

  async generarInformeMedicamentosEntregados() {
    try {
        await this.dataSource.query(`CALL generar_informe_medicamentos_entregados()`);

        return {
            message: 'Informe de medicamentos entregados generado exitosamente.',
        };
    } catch (error) {
        console.error('Error generando informe de medicamentos entregados:', error);
        throw new Error('Error generando informe: ' + error.message);
    }
  }

  async obtenerInformes() {
    try {
      const informes = await this.dataSource.query(`SELECT * FROM obtener_informes()`);
      return informes;
    } catch (error) {
        console.error('Error obteniendo informes:', error);
        throw new Error('Error al obtener los informes: ' + error.message);
    }
  }


  async generarInformeExamenesPendientes() {
    try {
        await this.dataSource.query(`CALL generar_informe_examenes_pendientes()`);

        return {
            message: 'Informe de exámenes pendientes generado exitosamente.',
        };
    } catch (error) {
        console.error('Error generando informe de exámenes pendientes:', error);
        throw new Error('Error generando informe: ' + error.message);
    } 
  }

}
