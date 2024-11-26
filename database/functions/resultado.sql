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
