"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.PacienteService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("typeorm");
let PacienteService = class PacienteService {
    constructor(dataSource) {
        this.dataSource = dataSource;
    }
    create(createPacienteDto) {
        return 'This action adds a new paciente';
    }
    async findAll() {
        try {
            const result = await this.dataSource.query(`SELECT * FROM obtener_pacientes()`);
            return result;
        }
        catch (error) {
            console.error('Error obteniendo pacientes', error);
            return [];
        }
    }
    findOne(id) {
        return `This action returns a #${id} paciente`;
    }
    update(id, updatePacienteDto) {
        return `This action updates a #${id} paciente`;
    }
    remove(id) {
        return `This action removes a #${id} paciente`;
    }
};
exports.PacienteService = PacienteService;
exports.PacienteService = PacienteService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [typeorm_1.DataSource])
], PacienteService);
//# sourceMappingURL=paciente.service.js.map