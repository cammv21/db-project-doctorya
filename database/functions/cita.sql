-- 4. Funcion crear cita dependiendo de la disponibilidad del medico
CREATE OR REPLACE FUNCTION crear_cita(
    p_fecha DATE,
    p_hora TIME,
    p_motivo VARCHAR,
    p_estado VARCHAR,
    p_paciente_id INT,
    p_medico_id INT
) RETURNS INTEGER AS $$  -- Cambiamos el tipo de retorno a INTEGER
DECLARE
    disponibilidad INT := 0;
    cita_id INT;  -- Variable para almacenar el ID de la cita creada
BEGIN
    -- Verificar disponibilidad del médico
    SELECT COUNT(*) INTO disponibilidad 
    FROM cita
    WHERE fecha = p_fecha 
    AND hora = p_hora 
    AND medico_id = p_medico_id 
    AND estado = 'programada';

    -- Si el médico está disponible, proceder a crear la cita
    IF disponibilidad = 0 THEN
        -- Insertar la cita y obtener el ID generado
        INSERT INTO cita (fecha, hora, motivo, estado, paciente_id, medico_id)
        VALUES (p_fecha, p_hora, p_motivo, p_estado, p_paciente_id, p_medico_id)
        RETURNING id INTO cita_id;  -- Obtenemos el ID de la cita creada

        RAISE NOTICE 'Se agendó la cita correctamente con ID: %', cita_id;

        -- Retornar el ID de la cita creada
        RETURN cita_id;
    ELSE
        -- Si el médico está ocupado
        RAISE NOTICE 'El médico está ocupado en ese horario';
        RETURN NULL;  -- Retorna NULL si la cita no se pudo crear
    END IF;

EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error al crear la cita: %', SQLERRM;
        RETURN NULL;  -- Retorna NULL en caso de error
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION public.modificar_cita(
    p_id INT,
    p_fecha DATE,
    p_hora TIME,
    p_motivo VARCHAR,
    p_estado VARCHAR,
    p_medico_id INT,
    p_paciente_id INT
) RETURNS BOOLEAN AS $$
BEGIN
    UPDATE cita
    SET fecha = p_fecha,
        hora = p_hora,
        motivo = p_motivo,
        estado = p_estado,
        medico_id = p_medico_id,
        paciente_id = p_paciente_id
    WHERE id = p_id;

    RAISE NOTICE 'Cita con ID % modificada correctamente', p_id;
    RETURN TRUE;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error al modificar la cita: %', SQLERRM;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION public.eliminar_cita(p_id INT)
RETURNS BOOLEAN AS $$
BEGIN
    DELETE FROM cita WHERE id = p_id;

    RAISE NOTICE 'Cita con ID % eliminada correctamente', p_id;
    RETURN TRUE;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error al eliminar la cita: %', SQLERRM;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

-- Modo de uso de la función
SELECT crear_cita('2024-11-15', '10:00:00', 'Consulta general', 'programada', 1, 1);

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