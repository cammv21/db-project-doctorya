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
                	WHERE estado = 'Pendiente'
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

CREATE OR REPLACE FUNCTION obtener_informes()
RETURNS TABLE (
    id INT,
    fecha DATE,
    tipo VARCHAR,
    contenido JSONB
) AS $$
BEGIN
    RETURN QUERY SELECT i.id, i.fecha, i.tipo, i.contenido FROM informe as i;
END;
$$ LANGUAGE plpgsql;
