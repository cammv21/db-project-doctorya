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