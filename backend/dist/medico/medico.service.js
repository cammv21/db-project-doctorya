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
exports.MedicoService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("typeorm");
let MedicoService = class MedicoService {
    constructor(dataSource) {
        this.dataSource = dataSource;
    }
    async create(createMedicoDto) {
        const { nombre, identificacion, registro_medico, especialidad, email, celular } = createMedicoDto;
        try {
            const result = await this.dataSource.query(`SELECT crear_medico($1, $2, $3, $4, $5, $6) AS success`, [nombre, identificacion, registro_medico, especialidad, email, celular]);
            if (result[0]?.success) {
                return { message: 'Médico creado exitosamente' };
            }
            else {
                throw new Error('No se pudo crear el médico');
            }
        }
        catch (error) {
            console.error('Error creando médico:', error);
            throw new Error('Error creando médico: ' + error.message);
        }
    }
    async findAll() {
        try {
            const result = await this.dataSource.query(`SELECT * FROM obtener_medicos()`);
            return result;
        }
        catch (error) {
            console.error('Error obteniendo médicos:', error);
            throw new Error('Error al obtener los médicos: ' + error.message);
        }
    }
    findOne(id) {
        return `This action returns a #${id} medico`;
    }
    async update(id, updateMedicoDto) {
        const { nombre, identificacion, registro_medico, especialidad, email, celular } = updateMedicoDto;
        try {
            const result = await this.dataSource.query(`SELECT modificar_medico($1, $2, $3, $4, $5, $6, $7) AS success`, [id, nombre, identificacion, registro_medico, especialidad, email, celular]);
            if (result[0]?.success) {
                return { message: 'Médico actualizado exitosamente' };
            }
            else {
                throw new Error('No se pudo actualizar el médico');
            }
        }
        catch (error) {
            console.error('Error actualizando médico:', error);
            throw new Error('Error actualizando médico: ' + error.message);
        }
    }
    async remove(id) {
        try {
            const result = await this.dataSource.query(`SELECT eliminar_medico($1) AS success`, [id]);
            if (result[0]?.success) {
                return { message: 'Médico eliminado exitosamente' };
            }
            else {
                throw new Error('No se pudo eliminar el médico');
            }
        }
        catch (error) {
            console.error('Error eliminando médico:', error);
            throw new Error('Error eliminando médico: ' + error.message);
        }
    }
};
exports.MedicoService = MedicoService;
exports.MedicoService = MedicoService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [typeorm_1.DataSource])
], MedicoService);
//# sourceMappingURL=medico.service.js.map