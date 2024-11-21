"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.MedicamentoService = void 0;
const common_1 = require("@nestjs/common");
let MedicamentoService = class MedicamentoService {
    create(createMedicamentoDto) {
        return 'This action adds a new medicamento';
    }
    findAll() {
        return `This action returns all medicamento`;
    }
    findOne(id) {
        return `This action returns a #${id} medicamento`;
    }
    update(id, updateMedicamentoDto) {
        return `This action updates a #${id} medicamento`;
    }
    remove(id) {
        return `This action removes a #${id} medicamento`;
    }
};
exports.MedicamentoService = MedicamentoService;
exports.MedicamentoService = MedicamentoService = __decorate([
    (0, common_1.Injectable)()
], MedicamentoService);
//# sourceMappingURL=medicamento.service.js.map