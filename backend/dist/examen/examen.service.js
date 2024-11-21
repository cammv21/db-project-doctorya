"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ExamenService = void 0;
const common_1 = require("@nestjs/common");
let ExamenService = class ExamenService {
    create(createExamanDto) {
        return 'This action adds a new examan';
    }
    findAll() {
        return `This action returns all examen`;
    }
    findOne(id) {
        return `This action returns a #${id} examan`;
    }
    update(id, updateExamanDto) {
        return `This action updates a #${id} examan`;
    }
    remove(id) {
        return `This action removes a #${id} examan`;
    }
};
exports.ExamenService = ExamenService;
exports.ExamenService = ExamenService = __decorate([
    (0, common_1.Injectable)()
], ExamenService);
//# sourceMappingURL=examen.service.js.map