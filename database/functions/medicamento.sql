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