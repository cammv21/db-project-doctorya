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
    RETURN TRUE;
EXCEPTION
    WHEN others THEN
        RAISE EXCEPTION 'Error: %', SQLERRM;
        RETURN FALSE;
END;
$$;

CALL crear_seguro_medico('Seguro Vida','Premium','2024-01-01'::Date,'2025-01-01'::Date,'3001234567');

CREATE OR REPLACE FUNCTION obtener_seguros_medicos()
RETURNS TABLE (
    id INT,
    nombre VARCHAR,
    tipo VARCHAR,
    fecha_inicio DATE,
    fecha_fin DATE,
    celular VARCHAR
) 
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM seguro_medico;
END;
$$;

SELECT * FROM obtener_seguros_medicos();

CREATE OR REPLACE PROCEDURE modificar_seguro_medico(
    p_id INT,
    p_nombre VARCHAR,
    p_tipo VARCHAR,
    p_fecha_inicio DATE,
    p_fecha_fin DATE,
    p_celular VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE seguro_medico
    SET nombre = p_nombre,
        tipo = p_tipo,
        fecha_inicio = p_fecha_inicio,
        fecha_fin = p_fecha_fin,
        celular = p_celular
    WHERE id = p_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró el seguro médico con ID %', p_id;
    END IF;
END;
$$;

CALL modificar_seguro_medico(1,'Seguro Vida','Premium','2024-01-01'::Date,'2025-01-01'::Date,'3001234567');

CREATE OR REPLACE PROCEDURE eliminar_seguro_medico(
    p_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM seguro_medico WHERE id = p_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró el seguro médico con ID %', p_id;
    END IF;
END;
$$;


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