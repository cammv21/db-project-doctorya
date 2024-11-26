CREATE OR REPLACE PROCEDURE crear_clinica(p_detalles VARCHAR)
AS $$
BEGIN
    INSERT INTO clinica(detalles) VALUES (xmlparse(document p_detalles));
END;
$$ LANGUAGE plpgsql;


CALL crear_clinica('<clinica><nombre>Clínica San Juan</nombre><director>Dr. Juan Pérez</director><camas>100</camas><direccion>Calle 123, Ciudad</direccion></clinica>');

CREATE OR REPLACE FUNCTION obtener_todas_clinicas()
RETURNS TABLE (
    id SERIAL,
    detalles XML
) AS $$
BEGIN
    RETURN QUERY
    SELECT id, detalles
    FROM clinica;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM obtener_todas_clinicas();
-- 10. Clínica en formato json con posibilidad de consultar datos el director de la clínica.
CREATE OR REPLACE PROCEDURE obtener_director_clinica(p_nombre_clinica VARCHAR)
AS $$
DECLARE
    v_director VARCHAR;
BEGIN
    SELECT c.director, c.nombre INTO v_director
	FROM clinica, xmltable('/clinica' passing detalles columns nombre text path 'nombre', director text path 'director') as c
    WHERE c.nombre = p_nombre_clinica;

    IF v_director IS NULL THEN
        RAISE EXCEPTION 'No se encontró una clínica con el nombre %', p_nombre_clinica;
    END IF;

    RAISE NOTICE 'El director es: %', v_director;
END;
$$ LANGUAGE plpgsql;

CALL obtener_director_clinica('Clínica San Juan');

CREATE OR REPLACE PROCEDURE modificar_clinica_por_director(director_nombre VARCHAR, p_detalles VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE clinica
    SET detalles = xmlparse(document p_detalles)
    WHERE id IN (SELECT id FROM clinica, XMLTABLE('/clinica' PASSING detalles COLUMNS director TEXT PATH 'director') AS c
        WHERE c.director = director_nombre);
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró una clínica con el director %', director_nombre;
    END IF;
END;
$$;

CALL modificar_clinica_por_director('Dr. Juan Pérez','<clinica><nombre>Clínica San Juan de Dios</nombre><director>Juan Pérez</director><camas>100</camas><direccion>Calle Nueva 456</direccion></clinica>');

CREATE OR REPLACE PROCEDURE eliminar_clinica_por_nombre(nombre_clinica VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM clinica
    WHERE id IN (
        SELECT id
        FROM clinica,
        XMLTABLE(
            '/clinica'
            PASSING detalles
            COLUMNS nombre TEXT PATH 'nombre'
        ) AS c
        WHERE c.nombre = nombre_clinica
    );

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró una clínica con el nombre %', nombre_clinica;
    END IF;
END;
$$;

CALL eliminar_clinica_por_nombre('Clínica San Juan de Dios');