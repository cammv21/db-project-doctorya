"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AppModule = void 0;
const common_1 = require("@nestjs/common");
const app_controller_1 = require("./app.controller");
const app_service_1 = require("./app.service");
const health_module_1 = require("./health/health.module");
const typeorm_1 = require("@nestjs/typeorm");
const seguro_medico_module_1 = require("./seguro_medico/seguro_medico.module");
const paciente_module_1 = require("./paciente/paciente.module");
const medico_module_1 = require("./medico/medico.module");
const cita_module_1 = require("./cita/cita.module");
const config_1 = require("@nestjs/config");
const mongoose_1 = require("@nestjs/mongoose");
const historia_clinica_module_1 = require("./historia_clinica/historia_clinica.module");
const medicamento_module_1 = require("./medicamento/medicamento.module");
const examen_module_1 = require("./examen/examen.module");
let AppModule = class AppModule {
};
exports.AppModule = AppModule;
exports.AppModule = AppModule = __decorate([
    (0, common_1.Module)({
        imports: [
            config_1.ConfigModule.forRoot({
                isGlobal: true,
                envFilePath: '.env'
            }),
            mongoose_1.MongooseModule.forRootAsync({
                imports: [config_1.ConfigModule],
                useFactory: async (configService) => ({
                    uri: configService.get('MONGODB_URI'),
                }),
                inject: [config_1.ConfigService],
            }),
            typeorm_1.TypeOrmModule.forRootAsync({
                imports: [config_1.ConfigModule],
                useFactory: (configService) => ({
                    type: 'postgres',
                    host: configService.get('DB_HOST'),
                    port: configService.get('DB_PORT'),
                    username: configService.get('DB_USERNAME'),
                    password: configService.get('DB_PASSWORD'),
                    database: configService.get('DB_DATABASE'),
                    synchronize: false,
                    autoLoadEntities: true,
                }),
                inject: [config_1.ConfigService],
            }),
            health_module_1.HealthModule,
            seguro_medico_module_1.SeguroMedicoModule,
            paciente_module_1.PacienteModule,
            medico_module_1.MedicoModule,
            cita_module_1.CitaModule,
            historia_clinica_module_1.HistoriaClinicaModule,
            medicamento_module_1.MedicamentoModule,
            examen_module_1.ExamenModule,
        ],
        controllers: [app_controller_1.AppController],
        providers: [app_service_1.AppService],
    })
], AppModule);
//# sourceMappingURL=app.module.js.map