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
exports.SeguroMedicoController = void 0;
const common_1 = require("@nestjs/common");
const seguro_medico_service_1 = require("./seguro_medico.service");
const create_seguro_medico_dto_1 = require("./dto/create-seguro_medico.dto");
const update_seguro_medico_dto_1 = require("./dto/update-seguro_medico.dto");
const swagger_1 = require("@nestjs/swagger");
let SeguroMedicoController = class SeguroMedicoController {
    constructor(seguroMedicoService) {
        this.seguroMedicoService = seguroMedicoService;
    }
    create(createSeguroMedicoDto) {
        return this.seguroMedicoService.create(createSeguroMedicoDto);
    }
    findAll() {
        return this.seguroMedicoService.findAll();
    }
    findOne(id) {
        return this.seguroMedicoService.findOne(+id);
    }
    update(id, updateSeguroMedicoDto) {
        return this.seguroMedicoService.update(+id, updateSeguroMedicoDto);
    }
    remove(id) {
        return this.seguroMedicoService.remove(+id);
    }
};
exports.SeguroMedicoController = SeguroMedicoController;
__decorate([
    (0, common_1.Post)(),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_seguro_medico_dto_1.CreateSeguroMedicoDto]),
    __metadata("design:returntype", void 0)
], SeguroMedicoController.prototype, "create", null);
__decorate([
    (0, common_1.Get)(),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], SeguroMedicoController.prototype, "findAll", null);
__decorate([
    (0, common_1.Get)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], SeguroMedicoController.prototype, "findOne", null);
__decorate([
    (0, common_1.Patch)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, update_seguro_medico_dto_1.UpdateSeguroMedicoDto]),
    __metadata("design:returntype", void 0)
], SeguroMedicoController.prototype, "update", null);
__decorate([
    (0, common_1.Delete)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], SeguroMedicoController.prototype, "remove", null);
exports.SeguroMedicoController = SeguroMedicoController = __decorate([
    (0, swagger_1.ApiTags)('System Seguro Medico'),
    (0, common_1.Controller)('seguro-medico'),
    __metadata("design:paramtypes", [seguro_medico_service_1.SeguroMedicoService])
], SeguroMedicoController);
//# sourceMappingURL=seguro_medico.controller.js.map