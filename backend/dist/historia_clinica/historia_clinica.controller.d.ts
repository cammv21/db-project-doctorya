import { HistoriaClinicaService } from './historia_clinica.service';
import { CreateHistoriaClinicaDto } from './dto/create-historia_clinica.dto';
import { UpdateHistoriaClinicaDto } from './dto/update-historia_clinica.dto';
export declare class HistoriaClinicaController {
    private readonly historiaClinicaService;
    constructor(historiaClinicaService: HistoriaClinicaService);
    create(createHistoriaClinicaDto: CreateHistoriaClinicaDto): string;
    findAll(): string;
    findOne(id: string): string;
    update(id: string, updateHistoriaClinicaDto: UpdateHistoriaClinicaDto): string;
    remove(id: string): string;
}
