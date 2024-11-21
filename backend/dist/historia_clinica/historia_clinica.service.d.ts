import { CreateHistoriaClinicaDto } from './dto/create-historia_clinica.dto';
import { UpdateHistoriaClinicaDto } from './dto/update-historia_clinica.dto';
export declare class HistoriaClinicaService {
    create(createHistoriaClinicaDto: CreateHistoriaClinicaDto): string;
    findAll(): string;
    findOne(id: number): string;
    update(id: number, updateHistoriaClinicaDto: UpdateHistoriaClinicaDto): string;
    remove(id: number): string;
}
