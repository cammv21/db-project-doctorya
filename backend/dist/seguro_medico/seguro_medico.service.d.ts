import { CreateSeguroMedicoDto } from './dto/create-seguro_medico.dto';
import { UpdateSeguroMedicoDto } from './dto/update-seguro_medico.dto';
import { SeguroMedico } from './entities/seguro_medico.entity';
import { Repository } from 'typeorm';
export declare class SeguroMedicoService {
    private readonly seguroMedicoRepository;
    constructor(seguroMedicoRepository: Repository<SeguroMedico>);
    create(createSeguroMedicoDto: CreateSeguroMedicoDto): string;
    findAll(): Promise<SeguroMedico[]>;
    findOne(id: number): string;
    update(id: number, updateSeguroMedicoDto: UpdateSeguroMedicoDto): string;
    remove(id: number): string;
}
