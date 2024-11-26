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

-- Declaraciones de como podrian ser utilizadas las funciones
SELECT crear_paciente('Juan Perez', '12345678', '1990-05-12', 'M', 'Calle Falsa 123', 'juan@example.com', '555123456', 1);
SELECT modificar_paciente(1, 'Juan Perez', '87654321', '1990-05-12', 'M', 'Calle Verdadera 456', 'juan_new@example.com', '555654321', 1);
SELECT eliminar_paciente(1);
SELECT * FROM obtener_pacientes();