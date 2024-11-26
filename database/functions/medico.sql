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

SELECT crear_medico('Dra. Ana Gomez', '23456789', 'RM12345', 'Cardiología', 'ana@example.com', '555987654');
SELECT modificar_medico(1, 'Dr. Carlos Lopez', '34567890', 'RM54321', 'Neurología', 'carlos@example.com', '555321987');
SELECT eliminar_medico(1);
SELECT * FROM obtener_medicos();