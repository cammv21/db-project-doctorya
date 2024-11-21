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
    async create(createPacienteDto) {
        const { nombre, identificacion, fecha_nacimiento, sexo, direccion, email, celular, seguro_id } = createPacienteDto;
        try {
            const result = await this.dataSource.query(`SELECT crear_paciente($1, $2, $3, $4, $5, $6, $7, $8) AS success`, [
                nombre,
                identificacion,
                fecha_nacimiento,
                sexo,
                direccion,
                email,
                celular,
                seguro_id || null,
            ]);
            if (result[0]?.success) {
                return { message: 'Paciente creado exitosamente' };
            }
            else {
                throw new Error('No se pudo crear el paciente');
            }
        }
        catch (error) {
            console.error('Error creando paciente:', error);
            throw new Error('Error creando paciente: ' + error.message);
        }
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
    async update(id, updatePacienteDto) {
        const { nombre, identificacion, fecha_nacimiento, sexo, direccion, email, celular, seguro_id, } = updatePacienteDto;
        try {
            const result = await this.dataSource.query(`SELECT modificar_paciente($1, $2, $3, $4, $5, $6, $7, $8, $9) AS success`, [
                id,
                nombre,
                identificacion,
                fecha_nacimiento,
                sexo,
                direccion,
                email,
                celular,
                seguro_id || null,
            ]);
            if (result[0]?.success) {
                return { message: 'Paciente actualizado exitosamente' };
            }
            else {
                throw new Error('No se pudo actualizar el paciente');
            }
        }
        catch (error) {
            console.error('Error actualizando paciente:', error);
            throw new Error('Error actualizando paciente: ' + error.message);
        }
    }
    async remove(id) {
        try {
            const result = await this.dataSource.query(`SELECT eliminar_paciente($1) AS success`, [id]);
            if (result[0]?.success) {
                return { message: 'Paciente eliminado exitosamente' };
            }
            else {
                throw new Error('No se pudo eliminar el paciente');
            }
        }
        catch (error) {
            console.error('Error eliminando paciente:', error);
            throw new Error('Error eliminando paciente: ' + error.message);
        }
    }
};
exports.PacienteService = PacienteService;
exports.PacienteService = PacienteService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [typeorm_1.DataSource])
], PacienteService);
//# sourceMappingURL=paciente.service.js.map