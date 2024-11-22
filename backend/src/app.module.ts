import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { HealthModule } from './health/health.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SeguroMedicoModule } from './seguro_medico/seguro_medico.module';
import { PacienteModule } from './paciente/paciente.module';
import { MedicoModule } from './medico/medico.module';
import { CitaModule } from './cita/cita.module';
import { MongooseModule } from '@nestjs/mongoose';
import { HistoriaClinicaModule } from './historia_clinica/historia_clinica.module';
import { MedicamentoModule } from './medicamento/medicamento.module';
import { ExamenModule } from './examen/examen.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: '.env'
    }),
    MongooseModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: async (configService: ConfigService) => ({
        uri: configService.get<string>('MONGODB_URI'),
      }),
      inject: [ConfigService],
    }),

    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        type: 'postgres',
        host: configService.get<string>('DB_HOST'),
        port: configService.get<number>('DB_PORT'),
        username: configService.get<string>('DB_USERNAME'),
        password: configService.get<string>('DB_PASSWORD'),
        database: configService.get<string>('DB_DATABASE'),
        synchronize: false,
        autoLoadEntities: true,
      }),
    
        // type: 'postgres',
        // host: 'localhost',
        // port: 5432,
        // username: 'postgres',
        // password: '2108',
        // database: 'db_project_doctorya',
        // synchronize: true,
        // autoLoadEntities: true,

      // useFactory: async (configService: ConfigService) => {
      //   const dbUrl = new URL(configService.get<string>('DATABASE_URL'));
      //   const routingId = dbUrl.searchParams.get('options');
      //   dbUrl.searchParams.delete('options');
      //   return {
      //     type: 'cockroachdb',
      //     url: dbUrl.toString(),
      //     ssl: true,
      //     extra: {
      //       options: routingId,
      //     },
      //     synchronize: false, // Cambiar a true si quieres sincronizar en desarrollo
      //     autoLoadEntities: true,
      //   };
      // },
      inject: [ConfigService],
    }),
    HealthModule,
    SeguroMedicoModule,
    PacienteModule,
    MedicoModule,
    CitaModule,
    HistoriaClinicaModule,
    MedicamentoModule,
    ExamenModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
