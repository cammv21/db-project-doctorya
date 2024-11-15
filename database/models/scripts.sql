-- Tabla seguro medico
CREATE TABLE public.seguro_medico(
	id serial NOT NULL,
	nombre varchar NULL,
	tipo varchar NULL,
	fecha_inicio date NULL,
	fecha_fin date NULL,
	celular varchar NULL,
	CONSTRAINT seguro_medico_pk PRIMARY KEY (id)
);

-- Tabla paciente
CREATE TABLE public.paciente (
	id serial NOT NULL,
	nombre varchar NULL,
	identificacion varchar NULL,
	fecha_nacimiento date NULL,
	sexo char NULL,
	direccion varchar NULL,
	email varchar NULL,
	celular varchar NULL,
	seguro_id int NULL,
	CONSTRAINT paciente_pk PRIMARY KEY (id),
	CONSTRAINT paciente_seguro_medico_fk FOREIGN KEY (seguro_id) REFERENCES public.seguro_medico(id)
);

-- Tabla medico
CREATE TABLE public.medico (
	id serial NOT NULL,
	nombre varchar NULL,
	identificacion varchar NULL,
	registro_medico varchar NULL,
	especialidad varchar NULL,
	email varchar NULL,
	celular varchar NULL,
	CONSTRAINT medico_pk PRIMARY KEY (id)
);

-- Tabla calendario
CREATE TABLE public.calendario (
	id serial NOT NULL,
	hora int NULL,
	dia int NULL,
	mes int NULL,
	año int NULL,
	medico_id int NULL,
	CONSTRAINT calendario_pk PRIMARY KEY (id),
	CONSTRAINT calendario_medico_fk FOREIGN KEY (medico_id) REFERENCES public.medico(id)
);

-- Tabla cita
CREATE TABLE public.cita (
	id serial NOT NULL,
	fecha date NULL,
	hora time without time zone NULL,
	motivo varchar NULL,
	estado varchar NULL,
	medico_id int NULL,
	paciente_id int NULL,
	CONSTRAINT cita_pk PRIMARY KEY (id),
	CONSTRAINT cita_paciente_fk FOREIGN KEY (paciente_id) REFERENCES public.paciente(id),
	CONSTRAINT cita_medico_fk FOREIGN KEY (medico_id) REFERENCES public.medico(id)
);

-- Tabla historia clinica
CREATE TABLE public.historia_clinica (
	id serial NOT NULL,
	fecha date NULL,
	sintomas varchar NULL,
	diagnostico varchar NULL,
	tratamiento varchar NULL,
	observaciones varchar NULL,
	cita_id int NULL,
	CONSTRAINT historia_clinica_pk PRIMARY KEY (id),
	CONSTRAINT historia_clinica_cita_fk FOREIGN KEY (cita_id) REFERENCES public.cita(id)
);

-- Tabla medicamento
CREATE TABLE public.medicamento (
	id serial NOT NULL,
	nombre varchar NULL,
	principio_activo varchar NULL,
	forma_farmaceutica varchar NULL,
	dosis varchar NULL,
	indicaciones varchar NULL,
	duracion varchar NULL,
	estado varchar NULL,
	historia_clinica_id int NULL,
	CONSTRAINT medicamento_pk PRIMARY KEY (id),
	CONSTRAINT medicamento_historia_clinica_fk FOREIGN KEY (historia_clinica_id) REFERENCES public.historia_clinica(id)
);

-- Tabla auditoria
CREATE TABLE public.auditoria (
	id serial NOT NULL,
	fecha date NULL,
	nombre_paciente varchar NULL,
	nombre_doctor varchar NULL,
	motivo_cita varchar NULL,
	diagnostico varchar NULL,
	nombre_medicamento varchar NULL,
	CONSTRAINT auditoria_pk PRIMARY KEY (id)
);

-- Tabla Informe
CREATE TABLE public.informe (
	id serial NOT NULL,
	fecha date NULL,
	tipo varchar NULL,
	contenido jsonb NULL,
	CONSTRAINT informe_pk PRIMARY KEY (id)
);

-- Tabla examen
CREATE TABLE public.examen (
	id serial NOT NULL,
	nombre varchar NULL,
	costo float4 NULL,
	cubre_seguro bool NULL,
	fecha date NULL,
	estado varchar NULL,
	historia_clinica_id int NULL,
	CONSTRAINT examen_pk PRIMARY KEY (id),
	CONSTRAINT examen_historia_clinica_fk FOREIGN KEY (historia_clinica_id) REFERENCES public.historia_clinica(id)
);

-- Tabla remision
CREATE TABLE public.remision (
	id serial NOT NULL,
	fecha date NULL,
	motivo varchar NULL,
	medico_id int NULL,
	historia_clinica_id int NULL,
	CONSTRAINT remision_pk PRIMARY KEY (id),
	CONSTRAINT remision_medico_fk FOREIGN KEY (medico_id) REFERENCES public.medico(id),
	CONSTRAINT remision_historia_clinica_fk FOREIGN KEY (historia_clinica_id) REFERENCES public.historia_clinica(id)
);

-- Tabla resultado
CREATE TABLE public.resultado (
	id serial NOT NULL,
	diagnostico varchar NULL,
	tratamiento varchar NULL,
	examen_id int NULL,
	medico_id int NULL,
	CONSTRAINT resultado_pk PRIMARY KEY (id),
	CONSTRAINT resultado_examen_fk FOREIGN KEY (examen_id) REFERENCES public.examen(id),
	CONSTRAINT resultado_medico_fk FOREIGN KEY (medico_id) REFERENCES public.medico(id)
);