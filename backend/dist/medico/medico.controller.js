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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.MedicoController = void 0;
const common_1 = require("@nestjs/common");
const medico_service_1 = require("./medico.service");
const create_medico_dto_1 = require("./dto/create-medico.dto");
const update_medico_dto_1 = require("./dto/update-medico.dto");
const swagger_1 = require("@nestjs/swagger");
let MedicoController = class MedicoController {
    constructor(medicoService) {
        this.medicoService = medicoService;
    }
    create(createMedicoDto) {
        return this.medicoService.create(createMedicoDto);
    }
    findAll() {
        return this.medicoService.findAll();
    }
    update(id, updateMedicoDto) {
        return this.medicoService.update(id, updateMedicoDto);
    }
    remove(id) {
        return this.medicoService.remove(id);
    }
};
exports.MedicoController = MedicoController;
__decorate([
    (0, common_1.Post)(),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_medico_dto_1.CreateMedicoDto]),
    __metadata("design:returntype", void 0)
], MedicoController.prototype, "create", null);
__decorate([
    (0, common_1.Get)(),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], MedicoController.prototype, "findAll", null);
__decorate([
    (0, common_1.Patch)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, update_medico_dto_1.UpdateMedicoDto]),
    __metadata("design:returntype", void 0)
], MedicoController.prototype, "update", null);
__decorate([
    (0, common_1.Delete)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", void 0)
], MedicoController.prototype, "remove", null);
exports.MedicoController = MedicoController = __decorate([
    (0, swagger_1.ApiTags)('System - Medico'),
    (0, common_1.Controller)('medico'),
    __metadata("design:paramtypes", [medico_service_1.MedicoService])
], MedicoController);
//# sourceMappingURL=medico.controller.js.map