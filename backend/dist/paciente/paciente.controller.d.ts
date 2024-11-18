import { PacienteService } from './paciente.service';
import { CreatePacienteDto } from './dto/create-paciente.dto';
import { UpdatePacienteDto } from './dto/update-paciente.dto';
export declare class PacienteController {
    private readonly pacienteService;
    constructor(pacienteService: PacienteService);
    create(createPacienteDto: CreatePacienteDto): string;
    findAll(): Promise<any>;
    findOne(id: string): string;
    update(id: string, updatePacienteDto: UpdatePacienteDto): string;
    remove(id: string): string;
}
