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