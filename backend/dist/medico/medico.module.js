"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.MedicoModule = void 0;
const common_1 = require("@nestjs/common");
const medico_service_1 = require("./medico.service");
const medico_controller_1 = require("./medico.controller");
const typeorm_1 = require("@nestjs/typeorm");
const medico_entity_1 = require("./entities/medico.entity");
let MedicoModule = class MedicoModule {
};
exports.MedicoModule = MedicoModule;
exports.MedicoModule = MedicoModule = __decorate([
    (0, common_1.Module)({
        imports: [typeorm_1.TypeOrmModule.forFeature([medico_entity_1.Medico])],
        controllers: [medico_controller_1.MedicoController],
        providers: [medico_service_1.MedicoService],
    })
], MedicoModule);
//# sourceMappingURL=medico.module.js.map