"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UpdateMedicoDto = void 0;
const swagger_1 = require("@nestjs/swagger");
const create_medico_dto_1 = require("./create-medico.dto");
class UpdateMedicoDto extends (0, swagger_1.PartialType)(create_medico_dto_1.CreateMedicoDto) {
}
exports.UpdateMedicoDto = UpdateMedicoDto;
//# sourceMappingURL=update-medico.dto.js.map