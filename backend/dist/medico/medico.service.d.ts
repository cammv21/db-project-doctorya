import { CreateMedicoDto } from './dto/create-medico.dto';
import { UpdateMedicoDto } from './dto/update-medico.dto';
import { DataSource } from 'typeorm';
export declare class MedicoService {
    private readonly dataSource;
    constructor(dataSource: DataSource);
    create(createMedicoDto: CreateMedicoDto): Promise<{
        message: string;
    }>;
    findAll(): Promise<any>;
    findOne(id: number): string;
    update(id: number, updateMedicoDto: UpdateMedicoDto): Promise<{
        message: string;
    }>;
    remove(id: number): Promise<{
        message: string;
    }>;
}
