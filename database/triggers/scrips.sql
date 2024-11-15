CREATE TRIGGER trigger_auditoria_cita
AFTER INSERT ON cita
FOR EACH ROW
EXECUTE FUNCTION registrar_auditoria_cita();

INSERT INTO cita (fecha, hora, motivo, estado, medico_id, paciente_id)
VALUES ('2024-12-30', '12:44', 'Chequeo general', 'programada', 1, 1);