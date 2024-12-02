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

CREATE OR REPLACE FUNCTION obtener_detalles_cita(cita_id INT)
RETURNS TABLE (
    fecha DATE,
    nombre_paciente VARCHAR,
    nombre_doctor VARCHAR,
    motivo_cita VARCHAR,
    diagnostico VARCHAR,
    medicamentos JSON
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.fecha AS fecha,
        p.nombre AS nombre_paciente,
        m.nombre AS nombre_doctor,
        c.motivo AS motivo_cita,
        hc.diagnostico AS diagnostico,
        COALESCE(
            json_agg(jsonb_build_object('nombre', med.nombre)) FILTER (WHERE med.id IS NOT NULL),
            '[]'::json
        ) AS medicamentos
    FROM 
        citas c
    JOIN 
        pacientes p ON c.paciente_id = p.id
    JOIN 
        medicos m ON c.medico_id = m.id
    LEFT JOIN 
        historias_clinicas hc ON c.id = hc.cita_id
    LEFT JOIN 
        medicamentos med ON hc.id = med.historia_clinica_id
    WHERE 
        c.id = cita_id
    GROUP BY 
        c.fecha, p.nombre, m.nombre, c.motivo, hc.diagnostico;
END;
$$ LANGUAGE plpgsql;

