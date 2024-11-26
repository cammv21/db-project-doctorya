CREATE OR REPLACE FUNCTION calendario_citas_medico_especialidad(p_medico_id INT DEFAULT NULL, p_especialidad VARCHAR DEFAULT NULL)
RETURNS TABLE(
    medico_nombre VARCHAR,
    especialidad VARCHAR,
    cita_fecha DATE,
    cita_hora TIME,
    paciente_nombre VARCHAR,
    motivo VARCHAR,
    estado VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT m.nombre AS medico_nombre, m.especialidad, c.fecha AS cita_fecha, c.hora AS cita_hora,
        p.nombre AS paciente_nombre, c.motivo, c.estado
    FROM 
        public.cita c
		    JOIN medico m ON c.medico_id = m.id
		    JOIN paciente p ON c.paciente_id = p.id
    WHERE (p_medico_id IS NULL OR m.id = p_medico_id) AND (p_especialidad IS NULL OR m.especialidad ILIKE p_especialidad)
    ORDER BY 
        m.nombre, c.fecha, c.hora;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM calendario_citas_medico_especialidad();
SELECT * FROM calendario_citas_medico_especialidad(p_medico_id := 1, p_especialidad := 'Cardiología');