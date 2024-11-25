-- 1. y 2. Funciones para la creacion, modificacion y eliminacion de tanto paciente como doctores

-------------------------------------------------- Paciente
CREATE OR REPLACE FUNCTION obtener_pacientes()
RETURNS TABLE (
    p_id INT,
    p_nombre VARCHAR,
    p_identificacion VARCHAR,
    p_fecha_nacimiento DATE,
    p_sexo CHAR,
    p_direccion VARCHAR,
    p_email VARCHAR,
    p_celular VARCHAR,
    p_seguro_id INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        id,
        nombre,
        identificacion,
        fecha_nacimiento,
        sexo,
        direccion,
        email,
        celular,
        seguro_id
    FROM paciente;
END;
$$ LANGUAGE plpgsql;

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
    INSERT INTO paciente (nombre, identificacion, fecha_nacimiento, sexo, direccion, email, celular, seguro_id)
    VALUES (p_nombre, p_identificacion, p_fecha_nacimiento, p_sexo, p_direccion, p_email, p_celular, p_seguro_id);
    RETURN TRUE;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error: %', SQLERRM;
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
    UPDATE paciente
    SET nombre = p_nombre, identificacion = p_identificacion, fecha_nacimiento = p_fecha_nacimiento, sexo = p_sexo,
        direccion = p_direccion, email = p_email, celular = p_celular, seguro_id = p_seguro_id
    WHERE id = p_id;
    RETURN TRUE;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error: %', SQLERRM;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_paciente(p_id INT) RETURNS BOOLEAN AS $$
BEGIN
    DELETE FROM paciente WHERE id = p_id;
    RETURN TRUE;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error: %', SQLERRM;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------- Medico

CREATE OR REPLACE FUNCTION obtener_medicos()
RETURNS TABLE (
    m_id INT,
    m_nombre VARCHAR,
    m_identificacion VARCHAR,
    m_registro_medico VARCHAR,
    m_especialidad VARCHAR,
    m_email VARCHAR,
    m_celular VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        id,
        nombre,
        identificacion,
        registro_medico,
        especialidad,
        email,
        celular
    FROM medico;
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------- Medico

CREATE OR REPLACE FUNCTION obtener_medicos()
RETURNS TABLE (
    m_id INT,
    m_nombre VARCHAR,
    m_identificacion VARCHAR,
    m_registro_medico VARCHAR,
    m_especialidad VARCHAR,
    m_email VARCHAR,
    m_celular VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        id,
        nombre,
        identificacion,
        registro_medico,
        especialidad,
        email,
        celular
    FROM medico;
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
    INSERT INTO medico (nombre, identificacion, registro_medico, especialidad, email, celular)
    VALUES (p_nombre, p_identificacion, p_registro_medico, p_especialidad, p_email, p_celular);
    RETURN TRUE;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error: %', SQLERRM;
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
    UPDATE medico
    SET nombre = p_nombre, identificacion = p_identificacion, registro_medico = p_registro_medico,
        especialidad = p_especialidad, email = p_email, celular = p_celular
    WHERE id = p_id;
    RETURN TRUE;
EXCEPTION
    WHEN others THEN		
        RAISE EXCEPTION 'Error: %', SQLERRM;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_medico(p_id INT) RETURNS BOOLEAN AS $$
BEGIN
    DELETE FROM medico WHERE id = p_id;
    RETURN TRUE;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error: %', SQLERRM;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

-- Declaraciones de como podrian ser utilizadas las funciones
SELECT crear_paciente('Juan Perez', '12345678', '1990-05-12', 'M', 'Calle Falsa 123', 'juan@example.com', '555123456', 1);
SELECT modificar_paciente(1, 'Juan Perez', '87654321', '1990-05-12', 'M', 'Calle Verdadera 456', 'juan_new@example.com', '555654321', 1);
SELECT eliminar_paciente(1);
SELECT * FROM obtener_pacientes();

SELECT crear_medico('Dra. Ana Gomez', '23456789', 'RM12345', 'Cardiología', 'ana@example.com', '555987654');
SELECT modificar_medico(1, 'Dr. Carlos Lopez', '34567890', 'RM54321', 'Neurología', 'carlos@example.com', '555321987');
SELECT eliminar_medico(1);
SELECT * FROM obtener_medicos();

-- 4. Funcion crear cita dependiendo de la disponibilidad del medico
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
    SELECT COUNT(*) INTO disponibilidad FROM cita
    WHERE fecha = p_fecha AND hora = p_hora AND medico_id = p_medico_id AND estado = 'programada';

    IF disponibilidad = 0 THEN
        INSERT INTO cita (fecha, hora, motivo, estado, paciente_id, medico_id)
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

-- 6. Creación, modificacion y eliminacion de Historias Clínicas
CREATE OR REPLACE FUNCTION crear_historia_clinica(
    p_fecha DATE,
    p_sintomas VARCHAR,
    p_diagnostico VARCHAR,
    p_tratamiento VARCHAR,
    p_observaciones VARCHAR,
    p_cita_id INT
) RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO historia_clinica (fecha, sintomas, diagnostico, tratamiento, observaciones, cita_id)
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
    UPDATE historia_clinica
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
    DELETE FROM historia_clinica WHERE id = p_id;
    
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

-- 7. Funciones para la creación, modificacion y eliminacion de medicamento
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
    INSERT INTO medicamento (nombre, principio_activo, forma_farmaceutica, dosis, indicaciones, duracion, estado, historia_clinica_id)
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
    UPDATE medicamento
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
    DELETE FROM medicamento WHERE id = p_id;
    
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

-- 8. Funciones para la creación, modificacion y eliminacion de Examenes
CREATE OR REPLACE FUNCTION crear_examen(
    p_nombre VARCHAR,
    p_costo FLOAT4,
    p_cubre_seguro BOOL,
    p_fecha DATE,
    p_estado VARCHAR,
    p_historia_clinica_id INT
) RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO examen (nombre, costo, cubre_seguro, fecha, estado, historia_clinica_id)
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
    UPDATE examen
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
    DELETE FROM examen WHERE id = p_id;
    
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

-- 12. Cada vez que se genere una cita, se debe hacer un registro en la tabla auditoria
CREATE OR REPLACE FUNCTION registrar_auditoria_cita() 
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria (fecha, nombre_paciente, nombre_doctor, motivo_cita, diagnostico, nombre_medicamento)
    SELECT NEW.fecha, p.nombre, m.nombre, NEW.motivo, h.diagnostico, COALESCE(med.nombre, 'N/A') 
    FROM 
        paciente p 
        	JOIN medico m ON m.id = NEW.medico_id
	        LEFT JOIN historia_clinica h ON h.cita_id = NEW.id
	        LEFT JOIN medicamento med ON med.historia_clinica_id = h.id
    WHERE 
        p.id = NEW.paciente_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 13. Búsqueda de los registros de auditoria por los atributos fecha, nombre del paciente, nombre de doctor.
CREATE OR REPLACE FUNCTION buscar_auditoria(p_fecha DATE, p_nombre_paciente VARCHAR, p_nombre_doctor VARCHAR)
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
    FROM public.auditoria
    WHERE fecha = p_fecha AND nombre_paciente = p_nombre_paciente AND nombre_doctor = p_nombre_doctor;
END;
$$ LANGUAGE plpgsql;

-- Modo de uso de las funcion
SELECT * FROM buscar_auditoria('2024-12-30'::Date, 'Juan Perez', 'Dra. Ana Gomez');

-- 5. Registro de citas para el paciente
CREATE OR REPLACE FUNCTION registrar_cita(p_fecha DATE, p_hora TIME, p_motivo VARCHAR, p_estado VARCHAR, p_medico_id INT, p_paciente_id INT)
RETURNS TABLE(
    v_id INT,
    v_fecha DATE,
    v_hora TIME,
    v_motivo VARCHAR,
    v_estado VARCHAR,
    v_medico_id INT,
    v_paciente_id INT
) AS $$
BEGIN
    INSERT INTO cita (fecha, hora, motivo, estado, medico_id, paciente_id)
    VALUES (p_fecha, p_hora, p_motivo, p_estado, p_medico_id, p_paciente_id)
    RETURNING id, fecha, hora, motivo, estado, medico_id, paciente_id INTO STRICT v_id, v_fecha, v_hora, v_motivo, v_estado, v_medico_id, v_paciente_id;

    RETURN QUERY SELECT v_id, v_fecha, v_hora, v_motivo, v_estado, v_medico_id, v_paciente_id;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM registrar_cita('2024-11-20','8:30:00', 'Consulta general', 'completada', 1, 1);

-- 3. Calendario de citas por médico y especialidad.
CREATE OR REPLACE FUNCTION calendario_citas_medico_especialidad(p_medico_id INT DEFAULT NULL, p_especialidad VARCHAR DEFAULT NULL)
RETURNS TABLE(
    medico_nombre VARCHAR,
    especialidad VARCHAR,
    cita_fecha DATE,
    cita_hora TIME,
    paciente_nombre VARCHAR,
    motivo VARCHAR,
    estado VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT m.nombre AS medico_nombre, m.especialidad, c.fecha AS cita_fecha, c.hora AS cita_hora,
        p.nombre AS paciente_nombre, c.motivo, c.estado
    FROM 
        public.cita c
		    JOIN medico m ON c.medico_id = m.id
		    JOIN paciente p ON c.paciente_id = p.id
    WHERE (p_medico_id IS NULL OR m.id = p_medico_id) AND (p_especialidad IS NULL OR m.especialidad ILIKE p_especialidad)
    ORDER BY 
        m.nombre, c.fecha, c.hora;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM calendario_citas_medico_especialidad();
SELECT * FROM calendario_citas_medico_especialidad(p_medico_id := 1, p_especialidad := 'Cardiología');

-- 9. Registro de resultados de los exámenes.
CREATE OR REPLACE FUNCTION registrar_resultado_examen(
    p_diagnostico VARCHAR,
    p_tratamiento VARCHAR,
    p_examen_id INT,
    p_medico_id INT
)
RETURNS TABLE(
    v_resultado_id INT,
    v_diagnostico VARCHAR,
    v_tratamiento VARCHAR,
    v_examen_id INT,
    v_medico_id INT
) AS $$
BEGIN
    INSERT INTO resultado (diagnostico, tratamiento, examen_id, medico_id)
    VALUES (p_diagnostico, p_tratamiento, p_examen_id, p_medico_id)
    RETURNING id AS resultado_id, p_diagnostico, p_tratamiento, p_examen_id, p_medico_id
	INTO v_resultado_id, v_diagnostico, v_tratamiento, v_examen_id, v_medico_id;

	RETURN QUERY SELECT v_resultado_id, v_diagnostico, v_tratamiento, v_examen_id, v_medico_id;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM registrar_resultado_examen('Diagnóstico positivo para diabetes', 'Cambios en dieta y medicación', 1, 1);

-- Procedimiento insertar clinica
CREATE OR REPLACE PROCEDURE crear_clinica(p_detalles VARCHAR)
AS $$
BEGIN
    INSERT INTO clinica(detalles) VALUES (xmlparse(document p_detalles));
END;
$$ LANGUAGE plpgsql;


CALL crear_clinica('<clinica><nombre>Clínica San Juan</nombre><director>Dr. Juan Pérez</director><camas>100</camas><direccion>Calle 123, Ciudad</direccion></clinica>');

-- 10. Clínica en formato json con posibilidad de consultar datos el director de la clínica.
CREATE OR REPLACE PROCEDURE obtener_director_clinica(p_nombre_clinica VARCHAR)
AS $$
DECLARE
    v_director VARCHAR;
BEGIN
    SELECT c.director, c.nombre INTO v_director
	FROM clinica, xmltable('/clinica' passing detalles columns nombre text path 'nombre', director text path 'director') as c
    WHERE c.nombre = p_nombre_clinica;

    IF v_director IS NULL THEN
        RAISE EXCEPTION 'No se encontró una clínica con el nombre %', p_nombre_clinica;
    END IF;

    RAISE NOTICE 'El director es: %', v_director;
END;
$$ LANGUAGE plpgsql;

CALL obtener_director_clinica('Clínica San Juan');

-- 11. Informe de citas del mes del médico, citas pendientes por parte de cada paciente, medicamentos entregados, exámenes pendientes del paciente.
CREATE OR REPLACE PROCEDURE generar_informe_citas_mes_medico(p_medico_id INT)
AS $$
BEGIN
    INSERT INTO informe (fecha, tipo, contenido)
    VALUES (CURRENT_DATE,'Informe de citas del mes del médico',
           (SELECT jsonb_agg(jsonb_build_object(
                    'fecha', fecha,
                    'hora', hora,
                    'paciente_id', paciente_id,
                    'estado', estado           ))
            FROM cita
            WHERE medico_id = p_medico_id AND EXTRACT(MONTH FROM fecha) = EXTRACT(MONTH FROM CURRENT_DATE)));
END;
$$ LANGUAGE plpgsql;

CALL generar_informe_citas_mes_medico(1);

CREATE OR REPLACE PROCEDURE generar_informe_citas_pendientes()
AS $$
BEGIN
    INSERT INTO informe (fecha, tipo, contenido)
    VALUES (CURRENT_DATE, 'Informe de citas pendientes por parte de cada paciente',
           (SELECT jsonb_agg(jsonb_build_object(
                    'nombre paciente', p.nombre,
                    'citas pendientes', sub.citas_pendientes))
            FROM (SELECT paciente_id, COUNT(*) AS citas_pendientes
                	FROM cita
                	WHERE estado = 'programada'
                	GROUP BY paciente_id) sub
            JOIN paciente p ON p.id = sub.paciente_id));
END;
$$ LANGUAGE plpgsql;

CALL generar_informe_citas_pendientes();

CREATE OR REPLACE PROCEDURE generar_informe_medicamentos_entregados()
AS $$
BEGIN
    INSERT INTO informe (fecha, tipo, contenido)
    VALUES (
        CURRENT_DATE,
        'Informe de medicamentos entregados',
        (
            SELECT jsonb_agg(
                jsonb_build_object(
                    'historia clinica id', historia_clinica_id,
                    'medicamento', nombre,
                    'estado', estado
                )
            )
            FROM medicamento
            WHERE estado = 'entregado'
        )
    );
END;
$$ LANGUAGE plpgsql;

CALL generar_informe_medicamentos_entregados();

CREATE OR REPLACE PROCEDURE generar_informe_examenes_pendientes()
AS $$
BEGIN
    INSERT INTO informe (fecha, tipo, contenido)
    VALUES (CURRENT_DATE, 'Informe de exámenes pendientes',
           (SELECT jsonb_agg(jsonb_build_object(
                    'paciente', p.nombre,
                    'examen', e.nombre,
                    'fecha', e.fecha,
                    'estado', e.estado))
            FROM examen e
            JOIN historia_clinica hc ON e.historia_clinica_id = hc.id
			JOIN cita c ON c.id = hc.cita_id
			JOIN  paciente p ON c.paciente_id = p.id
            WHERE e.estado = 'pendiente'));
END;
$$ LANGUAGE plpgsql;

CALL generar_informe_examenes_pendientes();

-- Modificación y eliminación de nodos en el dato de xml.
CREATE OR REPLACE PROCEDURE modificar_clinica_por_director(director_nombre VARCHAR, p_detalles VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE clinica
    SET detalles = xmlparse(document p_detalles)
    WHERE id IN (SELECT id FROM clinica, XMLTABLE('/clinica' PASSING detalles COLUMNS director TEXT PATH 'director') AS c
        WHERE c.director = director_nombre);
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró una clínica con el director %', director_nombre;
    END IF;
END;
$$;

CALL modificar_clinica_por_director('Dr. Juan Pérez','<clinica><nombre>Clínica San Juan de Dios</nombre><director>Juan Pérez</director><camas>100</camas><direccion>Calle Nueva 456</direccion></clinica>');

CREATE OR REPLACE PROCEDURE eliminar_clinica_por_nombre(nombre_clinica VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM clinica
    WHERE id IN (
        SELECT id
        FROM clinica,
        XMLTABLE(
            '/clinica'
            PASSING detalles
            COLUMNS nombre TEXT PATH 'nombre'
        ) AS c
        WHERE c.nombre = nombre_clinica
    );
   

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró una clínica con el nombre %', nombre_clinica;
    END IF;
END;
$$;

CALL eliminar_clinica_por_nombre('Clínica San Juan de Dios');

-- Funciones de obtener ciertas tablas
CREATE OR REPLACE FUNCTION obtener_todas_las_citas()
RETURNS TABLE(
    id INT,
    fecha DATE,
    hora TIME WITHOUT TIME ZONE,
    motivo VARCHAR,
    estado VARCHAR,
    nombre_medico VARCHAR,
    nombre_paciente VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT c.id, c.fecha, c.hora, c.motivo, c.estado,
	       m.nombre AS nombre_medico, p.nombre AS nombre_paciente
    FROM  cita c
	    LEFT JOIN medico m ON c.medico_id = m.id
	    LEFT JOIN paciente p ON c.paciente_id = p.id;
END;
$$;

SELECT * FROM obtener_todas_las_citas();

CREATE OR REPLACE FUNCTION obtener_todos_examenes()
RETURNS TABLE(
    v_id INT,
    v_nombre VARCHAR,
    v_costo FLOAT4,
    v_cubre_seguro BOOL,
    v_fecha DATE,
    v_estado VARCHAR,
    v_historia_clinica_id INT
) 
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT id, nombre, costo, cubre_seguro, fecha, estado, historia_clinica_id
    FROM examen;
END;
$$;

SELECT * FROM obtener_todos_examenes();

CREATE OR REPLACE FUNCTION obtener_todas_historias_clinicas()
RETURNS TABLE(
    id INT,
    fecha DATE,
    sintomas VARCHAR,
    diagnostico VARCHAR,
    tratamiento VARCHAR,
    observaciones VARCHAR,
    cita_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT *
    FROM historia_clinica;
END;
$$;

SELECT * FROM obtener_todas_historias_clinicas();

CREATE OR REPLACE FUNCTION obtener_medicamentos()
RETURNS TABLE (
    id INT,
    nombre VARCHAR,
    principio_activo VARCHAR,
    forma_farmaceutica VARCHAR,
    dosis VARCHAR,
    indicaciones VARCHAR,
    duracion VARCHAR,
    estado VARCHAR,
    historia_clinica_id INT
) 
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT *
    FROM medicamento;
END;
$$;

SELECT * FROM obtener_medicamentos();

-- Otros procedimientos
CREATE OR REPLACE PROCEDURE crear_seguro_medico(
    p_nombre VARCHAR,
    p_tipo VARCHAR,
    p_fecha_inicio DATE,
    p_fecha_fin DATE,
    p_celular VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO seguro_medico (nombre, tipo, fecha_inicio, fecha_fin, celular)
    VALUES (p_nombre, p_tipo, p_fecha_inicio, p_fecha_fin, p_celular);

	RAISE NOTICE 'Se creo el seguro medico';
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error: %', SQLERRM;
        RETURN FALSE;
END;
$$;

CALL crear_seguro_medico('Seguro Vida','Premium','2024-01-01'::Date,'2025-01-01'::Date,'3001234567');

CREATE OR REPLACE PROCEDURE vincular_seguro_a_paciente(p_paciente_id INT, p_seguro_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE paciente SET seguro_id = p_seguro_id
    WHERE id = p_paciente_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró un paciente con el ID %', p_paciente_id;
    END IF;
END;
$$;

CALL vincular_seguro_a_paciente(1, 2);

-- Implementacion de cursores
CREATE OR REPLACE FUNCTION listar_citas_pendientes_por_medico()
RETURNS TABLE(medico_nombre VARCHAR, cita_fecha DATE, cita_hora TIME, paciente_nombre VARCHAR)
LANGUAGE plpgsql
AS $$
DECLARE
    cur_citas CURSOR FOR
        SELECT m.nombre AS medico_nombre, c.fecha AS cita_fecha, 
            c.hora AS cita_hora, p.nombre AS paciente_nombre
        FROM cita c
	        JOIN medico m ON c.medico_id = m.id
	        JOIN paciente p ON c.paciente_id = p.id
        WHERE c.estado = 'programada';
BEGIN
    OPEN cur_citas;

    LOOP
        FETCH cur_citas INTO medico_nombre, cita_fecha, cita_hora, paciente_nombre;
        EXIT WHEN NOT FOUND;

        RETURN NEXT;
    END LOOP;

    CLOSE cur_citas;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error: %', SQLERRM;
END;
$$;

SELECT * FROM listar_citas_pendientes_por_medico();

CREATE OR REPLACE FUNCTION calcular_disponibilidad_camas()
RETURNS TABLE(clinica_nombre VARCHAR, camas_disponibles INT)
LANGUAGE plpgsql
AS $$
DECLARE
    cur_clinicas CURSOR FOR
        SELECT 
            id, 
            (xpath('//clinica/nombre/text()', detalles))[1]::TEXT AS clinica_nombre,
            (xpath('//clinica/camas/text()', detalles))[1]::TEXT AS total_camas
        FROM clinica;
    row RECORD;
    camas_ocupadas INT;
BEGIN
    OPEN cur_clinicas;

    LOOP
        FETCH cur_clinicas INTO row;
        EXIT WHEN NOT FOUND;

        SELECT COUNT(*) INTO camas_ocupadas FROM paciente;

        clinica_nombre := row.clinica_nombre;		
        camas_disponibles := row.total_camas::INT - camas_ocupadas;
        RETURN NEXT;
    END LOOP;

    CLOSE cur_clinicas;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error: %', SQLERRM;
END;
$$;

SELECT * FROM calcular_disponibilidad_camas();

CREATE OR REPLACE PROCEDURE registrar_alertas_seguros_vencimiento()
LANGUAGE plpgsql
AS $$
DECLARE
    cur_seguros CURSOR FOR
        SELECT id, nombre, fecha_fin FROM seguro_medico WHERE fecha_fin <= CURRENT_DATE + INTERVAL '30 days';
    row RECORD;
BEGIN
    OPEN cur_seguros;

    LOOP
        FETCH cur_seguros INTO row;
        EXIT WHEN NOT FOUND;

        RAISE NOTICE 'Vencimiento Seguro Médico';
        RAISE NOTICE 'El seguro %, está próximo a vencer el %', row.nombre, row.fecha_fin; 
    END LOOP;

    CLOSE cur_seguros;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error: %', SQLERRM;
END;
$$;

CALL registrar_alertas_seguros_vencimiento();

-- Registro de disparadores
CREATE OR REPLACE FUNCTION actualizar_estado_seguro_vencido()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.fecha_fin < CURRENT_DATE THEN
        RAISE NOTICE 'Seguro % vencido el %', NEW.nombre, NEW.fecha_fin;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION verificar_camas_clinica()
RETURNS TRIGGER AS $$
DECLARE
    cantidad_camas INTEGER;
BEGIN
    cantidad_camas := COALESCE((xpath('//cantidad_camas/text()', NEW.detalles::xml)::text[])[1]::INTEGER,0);

    IF cantidad_camas < 1 THEN
        RAISE EXCEPTION 'La clínica debe tener al menos una cama';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION calcular_dosis_total()
RETURNS TRIGGER AS $$
DECLARE
    cantidad_diaria INTEGER; 
    dias INTEGER; 
    total_miligramos INTEGER; 
BEGIN
    cantidad_diaria := regexp_replace(NEW.dosis, '[^0-9]', '', 'g')::INTEGER;
    dias := regexp_replace(NEW.duracion, '[^0-9]', '', 'g')::INTEGER;

    total_miligramos := cantidad_diaria * dias;

    RAISE NOTICE 'El paciente tomará un total de % miligramos durante % días', total_miligramos, dias;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION verificar_citas_duplicadas()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM cita
        WHERE paciente_id = NEW.paciente_id AND medico_id = NEW.medico_id AND fecha = NEW.fecha
    ) THEN
        RAISE EXCEPTION 'El paciente ya tiene una cita con este médico en esta fecha';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION verificar_costo_examen()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.costo < 1 THEN
        RAISE EXCEPTION 'El debe de tener valor mayor a 0';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION verificar_duracion_seguro()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.fecha_inicio >= NEW.fecha_fin THEN
        RAISE NOTICE 'La fecha de inicio del seguro (%), debe ser anterior a la fecha de finalización (%)', NEW.fecha_inicio, NEW.fecha_fin;
        RAISE EXCEPTION 'Duración del seguro no válida';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION verificar_tipo_seguros()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipo != 'Premium' AND NEW.tipo != 'Privado'THEN
        RAISE EXCEPTION 'El tipo de seguro debe ser Premium o Privado';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION verificar_medicamento_duplicado()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM medicamento
        WHERE nombre = NEW.nombre AND principio_activo = NEW.principio_activo
    ) THEN
        RAISE EXCEPTION 'El medicamento % de tipo % ya existe en la base de datos', NEW.nombre, NEW.principio_activo;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION validar_horario_cita()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.hora < '08:00:00'::Time OR NEW.hora > '18:00:00'::Time THEN
        RAISE EXCEPTION 'El horario de la cita % está fuera del rango permitido (08:00 - 18:00)', NEW.hora;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;