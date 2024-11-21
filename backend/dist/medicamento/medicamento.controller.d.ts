import { MedicamentoService } from './medicamento.service';
import { CreateMedicamentoDto } from './dto/create-medicamento.dto';
import { UpdateMedicamentoDto } from './dto/update-medicamento.dto';
export declare class MedicamentoController {
    private readonly medicamentoService;
    constructor(medicamentoService: MedicamentoService);
    create(createMedicamentoDto: CreateMedicamentoDto): string;
    findAll(): string;
    findOne(id: string): string;
    update(id: string, updateMedicamentoDto: UpdateMedicamentoDto): string;
    remove(id: string): string;
}
