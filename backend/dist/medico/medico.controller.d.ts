import { MedicoService } from './medico.service';
import { CreateMedicoDto } from './dto/create-medico.dto';
import { UpdateMedicoDto } from './dto/update-medico.dto';
export declare class MedicoController {
    private readonly medicoService;
    constructor(medicoService: MedicoService);
    create(createMedicoDto: CreateMedicoDto): Promise<{
        message: string;
    }>;
    findAll(): Promise<any>;
    update(id: number, updateMedicoDto: UpdateMedicoDto): Promise<{
        message: string;
    }>;
    remove(id: number): Promise<{
        message: string;
    }>;
}
