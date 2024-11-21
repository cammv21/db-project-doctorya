import { CreateMedicamentoDto } from './dto/create-medicamento.dto';
import { UpdateMedicamentoDto } from './dto/update-medicamento.dto';
export declare class MedicamentoService {
    create(createMedicamentoDto: CreateMedicamentoDto): string;
    findAll(): string;
    findOne(id: number): string;
    update(id: number, updateMedicamentoDto: UpdateMedicamentoDto): string;
    remove(id: number): string;
}
