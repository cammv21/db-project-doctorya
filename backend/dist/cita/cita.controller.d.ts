import { CitaService } from './cita.service';
import { CreateCitaDto } from './dto/create-cita.dto';
import { UpdateCitaDto } from './dto/update-cita.dto';
export declare class CitaController {
    private readonly citaService;
    constructor(citaService: CitaService);
    create(createCitaDto: CreateCitaDto): string;
    findAll(): string;
    update(id: string, updateCitaDto: UpdateCitaDto): string;
    remove(id: string): string;
}
