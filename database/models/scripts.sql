-- Tabla seguro medico
CREATE TABLE public.seguros_medicos (
	id serial4 NOT NULL,
	nombre varchar NULL,
	tipo varchar NULL,
	fecha_inicio date NULL,
	fecha_fin date NULL,
	celular varchar NULL,
	CONSTRAINT seguro_medico_pk PRIMARY KEY (id)
);

-- Tabla paciente
CREATE TABLE public.pacientes (
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

-- Tabla medicos
CREATE TABLE public.medicos (
	id serial4 NOT NULL,
	nombre varchar NULL,
	identificacion varchar NULL,
	registro_medico varchar NULL,
	especialidad varchar NULL,
	email varchar NULL,
	celular varchar NULL,
	CONSTRAINT medicos_pk PRIMARY KEY (id)
);

-- Tabla calendario
CREATE TABLE public.calendarios (
	id serial NOT NULL,
	hora int NULL,
	dia int NULL,
	mes int NULL,
	año int NULL,
	medico_id int NULL,
	CONSTRAINT calendario_pk PRIMARY KEY (id),
	CONSTRAINT calendario_medicos_fk FOREIGN KEY (medico_id) REFERENCES public.medicos(id)
);

-- Tabla citas
CREATE TABLE public.citas (
	id serial NOT NULL,
	fecha date NULL,
	hora time without time zone NULL,
	motivo varchar NULL,
	estado varchar NULL,
	medico_id int NULL,
	paciente_id int NULL,
	CONSTRAINT citas_pk PRIMARY KEY (id),
	CONSTRAINT citas_paciente_fk FOREIGN KEY (paciente_id) REFERENCES public.paciente(id),
	CONSTRAINT citas_medicos_fk FOREIGN KEY (medico_id) REFERENCES public.medicos(id)
);

-- Tabla historia clinica
CREATE TABLE public.historias_clinicas (
	id serial NOT NULL,
	fecha date NULL,
	sintomas varchar NULL,
	diagnostico varchar NULL,
	tratamiento varchar NULL,
	observaciones varchar NULL,
	cita_id int NULL,
	CONSTRAINT historia_clinica_pk PRIMARY KEY (id),
	CONSTRAINT historia_clinica_citas_fk FOREIGN KEY (cita_id) REFERENCES public.citas(id)
);

-- Tabla medicamentos
CREATE TABLE public.medicamentos (
	id serial NOT NULL,
	nombre varchar NULL,
	principio_activo varchar NULL,
	forma_farmaceutica varchar NULL,
	dosis varchar NULL,
	indicaciones varchar NULL,
	duracion varchar NULL,
	estado varchar NULL,
	historia_clinica_id int NULL,
	CONSTRAINT medicamentos_pk PRIMARY KEY (id),
	CONSTRAINT medicamentos_historia_clinica_fk FOREIGN KEY (historia_clinica_id) REFERENCES public.historia_clinica(id)
);

-- Tabla auditorias
CREATE TABLE public.auditorias (
	id serial4 NOT NULL,
	fecha date NULL,
	nombre_paciente varchar NULL,
	nombre_doctor varchar NULL,
	motivo_cita varchar NULL,
	diagnostico varchar NULL,
	nombre_medicamento varchar NULL,
	CONSTRAINT auditoria_pk PRIMARY KEY (id)
);

-- Tabla Informe
CREATE TABLE public.informes (
	id serial4 NOT NULL,
	fecha date NULL,
	tipo varchar NULL,
	contenido jsonb NULL,
	CONSTRAINT informe_pk PRIMARY KEY (id)
);

-- Tabla examenes
CREATE TABLE public.examenes (
	id serial NOT NULL,
	nombre varchar NULL,
	costo float4 NULL,
	cubre_seguro bool NULL,
	fecha date NULL,
	estado varchar NULL,
	historia_clinica_id int NULL,
	CONSTRAINT examenes_pk PRIMARY KEY (id),
	CONSTRAINT examenes_historia_clinica_fk FOREIGN KEY (historia_clinica_id) REFERENCES public.historia_clinica(id)
);

-- Tabla remisiones
CREATE TABLE public.remisiones (
	id serial NOT NULL,
	fecha date NULL,
	motivo varchar NULL,
	medico_id int NULL,
	historia_clinica_id int NULL,
	CONSTRAINT remisiones_pk PRIMARY KEY (id),
	CONSTRAINT remisiones_medicos_fk FOREIGN KEY (medico_id) REFERENCES public.medicos(id),
	CONSTRAINT remisiones_historia_clinica_fk FOREIGN KEY (historia_clinica_id) REFERENCES public.historia_clinica(id)
);

-- Tabla resultados
CREATE TABLE public.resultados (
	id serial NOT NULL,
	diagnostico varchar NULL,
	tratamiento varchar NULL,
	examen_id int NULL,
	medico_id int NULL,
	CONSTRAINT resultados_pk PRIMARY KEY (id),
	CONSTRAINT resultados_examenes_fk FOREIGN KEY (examen_id) REFERENCES public.examenes(id),
	CONSTRAINT resultados_medicos_fk FOREIGN KEY (medico_id) REFERENCES public.medicos(id)
);
