import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';

export type AuditoriaDocument = HydratedDocument<Auditoria>;

@Schema()
export class Auditoria {
    @Prop()
    fecha: string;

    @Prop()
    nombre_paciente: string;

    @Prop()
    nombre_medico: string;

    @Prop()
    motivo_cita: string;

    @Prop({ required: false, default: '' })  // Campo de cadena vacía por defecto
    diagnostico?: string;  // Campo opcional

    @Prop({ type: [String], default: [] })  // Campo de arreglo vacío por defecto
    medicamentos?: string[];  // Campo opcional
}

export const AuditoriaSchema = SchemaFactory.createForClass(Auditoria);