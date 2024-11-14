-- Funciones para la creacion, modificacion y eliminacion de tanto pacientes como doctores
CREATE OR REPLACE FUNCTION crear_paciente(
    p_nombre VARCHAR,
    p_identificacion VARCHAR,
    p_fecha_nacimiento DATE,
    p_sexo CHAR,
    p_direccion VARCHAR,
    p_email VARCHAR,
    p_celular VARCHAR,
    p_seguro_id INT
) RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO pacientes (nombre, identificacion, fecha_nacimiento, sexo, direccion, email, celular, seguro_id)
    VALUES (p_nombre, p_identificacion, p_fecha_nacimiento, p_sexo, p_direccion, p_email, p_celular, p_seguro_id);
    RETURN TRUE;
EXCEPTION
    WHEN others THEN
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION modificar_paciente(
    p_id INT,
    p_nombre VARCHAR,
    p_identificacion VARCHAR,
    p_fecha_nacimiento DATE,
    p_sexo CHAR,
    p_direccion VARCHAR,
    p_email VARCHAR,
    p_celular VARCHAR,
    p_seguro_id INT
) RETURNS BOOLEAN AS $$
BEGIN
    UPDATE pacientes
    SET nombre = p_nombre, identificacion = p_identificacion, fecha_nacimiento = p_fecha_nacimiento, sexo = p_sexo,
        direccion = p_direccion, email = p_email, celular = p_celular, seguro_id = p_seguro_id
    WHERE id = p_id;
    RETURN TRUE;
EXCEPTION
    WHEN others THEN
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_paciente(p_id INT) RETURNS BOOLEAN AS $$
BEGIN
    DELETE FROM pacientes WHERE id = p_id;
    RETURN TRUE;
EXCEPTION
    WHEN others THEN
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION crear_medico(
    p_nombre VARCHAR,
    p_identificacion VARCHAR,
    p_registro_medico VARCHAR,
    p_especialidad VARCHAR,
    p_email VARCHAR,
    p_celular VARCHAR
) RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO medicos (nombre, identificacion, registro_medico, especialidad, email, celular)
    VALUES (p_nombre, p_identificacion, p_registro_medico, p_especialidad, p_email, p_celular);
    RETURN TRUE;
EXCEPTION
    WHEN others THEN
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION modificar_medico(
    p_id INT,
    p_nombre VARCHAR,
    p_identificacion VARCHAR,
    p_registro_medico VARCHAR,
    p_especialidad VARCHAR,
    p_email VARCHAR,
    p_celular VARCHAR
) RETURNS BOOLEAN AS $$
BEGIN
    UPDATE medicos
    SET nombre = p_nombre, identificacion = p_identificacion, registro_medico = p_registro_medico,
        especialidad = p_especialidad, email = p_email, celular = p_celular
    WHERE id = p_id;
    RETURN TRUE;
EXCEPTION
    WHEN others THEN
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_medico(p_id INT) RETURNS BOOLEAN AS $$
BEGIN
    DELETE FROM public.medicos WHERE id = p_id;
    RETURN TRUE;
EXCEPTION
    WHEN others THEN
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

-- Declaraciones de como podrian ser utilizadas las funciones
SELECT crear_paciente('Juan Perez', '12345678', '1990-05-12', 'M', 'Calle Falsa 123', 'juan@example.com', '555123456', 1);
SELECT modificar_paciente(1, 'Juan Perez', '87654321', '1990-05-12', 'M', 'Calle Verdadera 456', 'juan_new@example.com', '555654321', 1);
SELECT eliminar_paciente(1);

SELECT crear_medico('Dra. Ana Gomez', '23456789', 'RM12345', 'Cardiología', 'ana@example.com', '555987654');
SELECT modificar_medico(1, 'Dr. Carlos Lopez', '34567890', 'RM54321', 'Neurología', 'carlos@example.com', '555321987');
SELECT eliminar_medico(1);

--Funcion crear cita dependiendo de la disponibilidad del medico
CREATE OR REPLACE FUNCTION crear_cita(
    p_fecha DATE,
    p_hora TIME,
    p_motivo VARCHAR,
    p_estado VARCHAR,
    p_paciente_id INT,
    p_medico_id INT
) RETURNS BOOLEAN AS $$
DECLARE
    disponibilidad INT := 0;
BEGIN
    SELECT COUNT(*) INTO disponibilidad FROM citas
    WHERE fecha = p_fecha AND hora = p_hora AND medico_id = p_medico_id AND estado = 'programada';

    IF disponibilidad = 0 THEN
        INSERT INTO citas (fecha, hora, motivo, estado, paciente_id, medico_id)
        VALUES (p_fecha, p_hora, p_motivo, p_estado, p_paciente_id, p_medico_id);
		RAISE NOTICE 'Se agendo la cita correctamente';
        RETURN TRUE;
    ELSE
		RAISE NOTICE 'El medico esta ocupado';
        RETURN FALSE;  
    END IF;
EXCEPTION
    WHEN others THEN
		RAISE EXCEPTION 'Error al crear la cita: %', SQLERRM;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

-- Modo de uso de la función
SELECT crear_cita('2024-11-15', '10:00:00', 'Consulta general', 'programada', 1, 1);

-- Creación, modificacion y eliminacion de Historias Clínicas
CREATE OR REPLACE FUNCTION crear_historia_clinica(
    p_fecha DATE,
    p_sintomas VARCHAR,
    p_diagnostico VARCHAR,
    p_tratamiento VARCHAR,
    p_observaciones VARCHAR,
    p_cita_id INT
) RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO historias_clinicas (fecha, sintomas, diagnostico, tratamiento, observaciones, cita_id)
    VALUES (p_fecha, p_sintomas, p_diagnostico, p_tratamiento, p_observaciones, p_cita_id);
    RETURN TRUE;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error: %', SQLERRM;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION modificar_historia_clinica(
    p_id INT,
    p_fecha DATE,
    p_sintomas VARCHAR,
    p_diagnostico VARCHAR,
    p_tratamiento VARCHAR,
    p_observaciones VARCHAR
) RETURNS BOOLEAN AS $$
BEGIN
    UPDATE historias_clinicas
    SET fecha = p_fecha, sintomas = p_sintomas, diagnostico = p_diagnostico,
        tratamiento = p_tratamiento, observaciones = p_observaciones
    WHERE id = p_id;
    
    IF FOUND THEN
        RETURN TRUE;
    ELSE
        RAISE EXCEPTION 'No se encontró la historia clínica con ID %', p_id;
        RETURN FALSE;
    END IF;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error: %', SQLERRM;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_historia_clinica(
    p_id INT
) RETURNS BOOLEAN AS $$
BEGIN
    DELETE FROM historias_clinicas WHERE id = p_id;
    
    IF FOUND THEN
        RETURN TRUE;
    ELSE
        RAISE EXCEPTION 'No se encontró la historia clínica con ID %', p_id;
        RETURN FALSE;
    END IF;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error: %', SQLERRM;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

-- Modo de uso de las funciones
SELECT crear_historia_clinica('2024-11-15', 'Dolor de cabeza', 'Migraña', 'Paracetamol', 'Descanso', 1);
SELECT modificar_historia_clinica(1, '2024-11-16'::Date, 'Fiebre', 'Gripe', 'Ibuprofeno', 'Reposo');
SELECT eliminar_historia_clinica(1);

-- Funciones para la creación, modificacion y eliminacion de Medicamentos
CREATE OR REPLACE FUNCTION crear_medicamento(
    p_nombre VARCHAR,
    p_principio_activo VARCHAR,
    p_forma_farmaceutica VARCHAR,
    p_dosis VARCHAR,
    p_indicaciones VARCHAR,
    p_duracion VARCHAR,
    p_estado VARCHAR,
    p_historia_clinica_id INT
) RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO medicamentos (nombre, principio_activo, forma_farmaceutica, dosis, indicaciones, duracion, estado, historia_clinica_id)
    VALUES (p_nombre, p_principio_activo, p_forma_farmaceutica, p_dosis, p_indicaciones, p_duracion, p_estado, p_historia_clinica_id);
    RETURN TRUE;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error: %', SQLERRM;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION modificar_medicamento(
    p_id INT,
    p_nombre VARCHAR,
    p_principio_activo VARCHAR,
    p_forma_farmaceutica VARCHAR,
    p_dosis VARCHAR,
    p_indicaciones VARCHAR,
    p_duracion VARCHAR,
    p_estado VARCHAR
) RETURNS BOOLEAN AS $$
BEGIN
    UPDATE medicamentos
    SET nombre = p_nombre, principio_activo = p_principio_activo, forma_farmaceutica = p_forma_farmaceutica,
        dosis = p_dosis, indicaciones = p_indicaciones, duracion = p_duracion, estado = p_estado
    WHERE id = p_id;
    
    IF FOUND THEN
        RETURN TRUE;
    ELSE
        RAISE EXCEPTION 'No se encontró el medicamento con ID %', p_id;
        RETURN FALSE;
    END IF;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error: %', SQLERRM;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_medicamento(
    p_id INT
) RETURNS BOOLEAN AS $$
BEGIN
    DELETE FROM medicamentos WHERE id = p_id;
    
    IF FOUND THEN
        RETURN TRUE;
    ELSE
        RAISE EXCEPTION 'No se encontró el medicamento con ID %', p_id;
        RETURN FALSE;
    END IF;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error: %', SQLERRM;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

-- Modo de uso de las funciones
SELECT crear_medicamento('Paracetamol', 'Paracetamol', 'Tableta', '500mg', 'Tomar 1 cada 8 horas', '7 días', 'pendiente', 1);
SELECT modificar_medicamento(1, 'Paracetamol', 'Paracetamol', 'Tableta', '500mg', 'Tomar 1 cada 6 horas', '7 días', 'entregado');
SELECT eliminar_medicamento(1);

-- Funciones para la creación, modificacion y eliminacion de Examenes
CREATE OR REPLACE FUNCTION crear_examen(
    p_nombre VARCHAR,
    p_costo FLOAT4,
    p_cubre_seguro BOOL,
    p_fecha DATE,
    p_estado VARCHAR,
    p_historia_clinica_id INT
) RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO public.examenes (nombre, costo, cubre_seguro, fecha, estado, historia_clinica_id)
    VALUES (p_nombre, p_costo, p_cubre_seguro, p_fecha, p_estado, p_historia_clinica_id);
    RETURN TRUE;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error: %', SQLERRM;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION modificar_examen(
    p_id INT,
    p_nombre VARCHAR,
    p_costo FLOAT4,
    p_cubre_seguro BOOL,
    p_fecha DATE,
    p_estado VARCHAR
) RETURNS BOOLEAN AS $$
BEGIN
    UPDATE public.examenes
    SET nombre = p_nombre, costo = p_costo, cubre_seguro = p_cubre_seguro,
        fecha = p_fecha, estado = p_estado
    WHERE id = p_id;
    
    IF FOUND THEN
        RETURN TRUE;
    ELSE
        RAISE EXCEPTION 'No se encontró el examen con ID %', p_id;
        RETURN FALSE;
    END IF;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error: %', SQLERRM;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_examen(
    p_id INT
) RETURNS BOOLEAN AS $$
BEGIN
    DELETE FROM public.examenes WHERE id = p_id;
    
    IF FOUND THEN
        RETURN TRUE;
    ELSE
        RAISE EXCEPTION 'No se encontró el examen con ID %', p_id;
        RETURN FALSE;
    END IF;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error: %', SQLERRM;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

-- Modo de uso de las funciones
SELECT crear_examen('Hemograma', 200.0, TRUE, '2024-11-20', 'pendiente', 1);
SELECT modificar_examen(1, 'Hemograma', 250.0, TRUE, '2024-11-21', 'completado');
SELECT eliminar_examen(1);

-- Búsqueda de los registros de auditoria por los atributos fecha, nombre del paciente, nombre de doctor.
CREATE OR REPLACE FUNCTION buscar_auditorias(p_fecha DATE, p_nombre_paciente VARCHAR, p_nombre_doctor VARCHAR)
RETURNS TABLE(
    v_id INT,
    v_fecha DATE,
    v_nombre_paciente VARCHAR,
    v_nombre_doctor VARCHAR,
    v_motivo_cita VARCHAR,
    v_diagnostico VARCHAR,
    v_nombre_medicamento VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT id, fecha, nombre_paciente, nombre_doctor, motivo_cita, diagnostico, nombre_medicamento
    FROM public.auditorias
    WHERE fecha = p_fecha AND nombre_paciente = p_nombre_paciente AND nombre_doctor = p_nombre_doctor;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM buscar_auditorias('2024-12-30'::Date, 'Juan Perez', 'Dra. Ana Gomez');