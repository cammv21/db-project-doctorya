import { CreateCitaDto } from './dto/create-cita.dto';
import { UpdateCitaDto } from './dto/update-cita.dto';
export declare class CitaService {
    create(createCitaDto: CreateCitaDto): string;
    findAll(): string;
    findOne(id: number): string;
    update(id: number, updateCitaDto: UpdateCitaDto): string;
    remove(id: number): string;
}
