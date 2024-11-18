import { SeguroMedicoService } from './seguro_medico.service';
import { CreateSeguroMedicoDto } from './dto/create-seguro_medico.dto';
import { UpdateSeguroMedicoDto } from './dto/update-seguro_medico.dto';
export declare class SeguroMedicoController {
    private readonly seguroMedicoService;
    constructor(seguroMedicoService: SeguroMedicoService);
    create(createSeguroMedicoDto: CreateSeguroMedicoDto): string;
    findAll(): Promise<import("./entities/seguro_medico.entity").SeguroMedico[]>;
    findOne(id: string): string;
    update(id: string, updateSeguroMedicoDto: UpdateSeguroMedicoDto): string;
    remove(id: string): string;
}
