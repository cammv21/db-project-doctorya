"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.SeguroMedicoModule = void 0;
const common_1 = require("@nestjs/common");
const seguro_medico_service_1 = require("./seguro_medico.service");
const seguro_medico_controller_1 = require("./seguro_medico.controller");
const typeorm_1 = require("@nestjs/typeorm");
const seguro_medico_entity_1 = require("./entities/seguro_medico.entity");
let SeguroMedicoModule = class SeguroMedicoModule {
};
exports.SeguroMedicoModule = SeguroMedicoModule;
exports.SeguroMedicoModule = SeguroMedicoModule = __decorate([
    (0, common_1.Module)({
        imports: [typeorm_1.TypeOrmModule.forFeature([seguro_medico_entity_1.SeguroMedico])],
        controllers: [seguro_medico_controller_1.SeguroMedicoController],
        providers: [seguro_medico_service_1.SeguroMedicoService],
    })
], SeguroMedicoModule);
//# sourceMappingURL=seguro_medico.module.js.map