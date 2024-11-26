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