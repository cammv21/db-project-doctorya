import { CreatePacienteDto } from './dto/create-paciente.dto';
import { UpdatePacienteDto } from './dto/update-paciente.dto';
import { DataSource } from 'typeorm';
export declare class PacienteService {
    private readonly dataSource;
    constructor(dataSource: DataSource);
    create(createPacienteDto: CreatePacienteDto): string;
    findAll(): Promise<any>;
    findOne(id: number): string;
    update(id: number, updatePacienteDto: UpdatePacienteDto): string;
    remove(id: number): string;
}
