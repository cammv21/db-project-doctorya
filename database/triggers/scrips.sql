CREATE TRIGGER trigger_auditoria_cita
AFTER INSERT ON cita
FOR EACH ROW
EXECUTE FUNCTION registrar_auditoria_cita();

INSERT INTO cita (fecha, hora, motivo, estado, medico_id, paciente_id)
VALUES ('2024-12-30', '12:44', 'Chequeo general', 'programada', 1, 1);

CREATE TRIGGER trg_actualizar_estado_seguro
AFTER INSERT OR UPDATE ON seguro_medico
FOR EACH ROW
EXECUTE FUNCTION actualizar_estado_seguro_vencido();

UPDATE seguro_medico SET fecha_fin = '2024-06-13'::Date WHERE id = 1;

CREATE TRIGGER trg_verificar_camas_clinica
BEFORE INSERT ON clinica
FOR EACH ROW
EXECUTE FUNCTION verificar_camas_clinica();

CALL crear_clinica('<clinica><nombre>Clínica San Juan</nombre><director>Dr. Juan Pérez</director><camas>0</camas><direccion>Calle 123, Ciudad</direccion></clinica>');

CREATE TRIGGER trg_calcular_dosis_total
BEFORE INSERT OR UPDATE ON medicamento
FOR EACH ROW
EXECUTE FUNCTION calcular_dosis_total();

UPDATE medicamento SET dosis = '400mg' WHERE id = 1;

CREATE TRIGGER trg_verificar_citas_duplicadas
BEFORE INSERT ON cita
FOR EACH ROW
EXECUTE FUNCTION verificar_citas_duplicadas();

INSERT INTO cita(fecha, hora, motivo, estado, medico_id, paciente_id) VALUES ('2024-11-15', '10:00:00', 'Consulta general', 'programada', 1, 1);

CREATE TRIGGER trg_verificar_costo_examen
BEFORE INSERT OR UPDATE ON examen
FOR EACH ROW
EXECUTE FUNCTION verificar_costo_examen();

UPDATE examen SET costo = 0 WHERE id = 1;

CREATE TRIGGER trg_verificar_duracion_seguro
BEFORE INSERT OR UPDATE ON seguro_medico
FOR EACH ROW
EXECUTE FUNCTION verificar_duracion_seguro();

UPDATE seguro_medico SET fecha_fin = '2024-02-02'::Date WHERE id = 1;

CREATE TRIGGER trg_verificar_tipo_seguros
BEFORE INSERT ON seguro_medico
FOR EACH ROW
EXECUTE FUNCTION verificar_tipo_seguros();

CALL crear_seguro_medico('Seguro Vida','h','2024-01-01'::Date,'2025-01-01'::Date,'3001234567');

CREATE TRIGGER trg_verificar_medicamento_duplicado
BEFORE INSERT ON medicamento
FOR EACH ROW
EXECUTE FUNCTION verificar_medicamento_duplicado();

SELECT crear_medicamento('Paracetamol', 'Paracetamol', 'Tableta', '500mg', 'Tomar 1 cada 8 horas', '7 días', 'pendiente', 1);

CREATE TRIGGER trg_validar_horario_cita
BEFORE INSERT OR UPDATE ON cita
FOR EACH ROW
EXECUTE FUNCTION validar_horario_cita();

SELECT crear_cita('2024-11-15', '20:00:00', 'Consulta general', 'programada', 1, 1);