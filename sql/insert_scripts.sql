INSERT INTO personas (
	id,
	nombre,
	apellido,
	edad,
	nacionalidad,
	ocupacion
)
	SELECT DISTINCT
		nro                    id,
		nombres_victima        nombre,
		apellidos_victima      apellido,
		edad_victima           edad,
		nacionalidad_victima   nacionalidad,
		ocupacion_victima      ocupacion
	FROM
		big_table
	ORDER BY
		nro;

INSERT INTO personas (
	id,
	nombre,
	apellido,
	edad,
	nacionalidad,
	ocupacion
)
	SELECT DISTINCT
		nro_agresor            id,
		nombres_agresor        nombre,
		apellidos_agresor      apellido,
		edad_agresor           edad,
		nacionalidad_agresor   nacionalidad,
		ocupacion_agresor      ocupacion
	FROM
		big_table
	ORDER BY
		nro_agresor;

INSERT INTO noticias (
	id,
	url,
	nombre,
	fecha_acceso,
	autor
)
	SELECT DISTINCT
		nro_url1              id,
		url1                  url,
		texto_completo_url1   nombre,
		fecha_url1            fecha_acceso,
		autor_url1            autor
	FROM
		big_table
	ORDER BY
		nro_url1;

INSERT INTO noticias (
	id,
	url,
	nombre,
	fecha_acceso,
	autor
)
	SELECT DISTINCT
		nro_url2              id,
		url2                  url,
		texto_completo_url2   nombre,
		fecha_url2            fecha_acceso,
		autor_url2            autor
	FROM
		big_table
	WHERE
		nro_url2 IS NOT NULL
	ORDER BY
		nro_url2;

INSERT INTO noticias (
	id,
	url,
	nombre,
	fecha_acceso,
	autor
)
	SELECT DISTINCT
		nro_url3              id,
		url3                  url,
		texto_completo_url3   nombre,
		fecha_url3            fecha_acceso,
		autor_url3            autor
	FROM
		big_table
	WHERE
		nro_url3 IS NOT NULL
	ORDER BY
		nro_url3;

INSERT INTO agresores (
	id,
	situacion,
	sentencia
)
	SELECT DISTINCT
		nro_agresor         id,
		situacion_agresor   situacion,
		sentencia           sentencia
	FROM
		big_table
	ORDER BY
		nro_agresor;

INSERT INTO victimas (
	id,
	hora_muerte,
	causa_muerte
)
	SELECT DISTINCT
		nro   id,
		hora_muerte,
		causa_muerte
	FROM
		big_table
	ORDER BY
		nro;

CREATE SEQUENCE categoria_seq MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 100;

INSERT INTO categorias (
	id,
	nombre
)
	SELECT
		categoria_seq.NEXTVAL AS id,
		nombre
	FROM
		(
			SELECT DISTINCT
				lower(categoria_url1) nombre
			FROM
				big_table
			WHERE
				categoria_url1 NOT IN (
					SELECT
						nombre
					FROM
						categorias
				)
		);

INSERT INTO categorias (
	id,
	nombre
)
	SELECT
		categoria_seq.NEXTVAL AS id,
		nombre
	FROM
		(
			SELECT DISTINCT
				lower(categoria_url2) nombre
			FROM
				big_table
			WHERE
				categoria_url2 NOT IN (
					SELECT
						nombre
					FROM
						categorias
				)
		);

INSERT INTO categorias (
	id,
	nombre
)
	SELECT
		categoria_seq.NEXTVAL AS id,
		nombre
	FROM
		(
			SELECT DISTINCT
				lower(categoria_url3) nombre
			FROM
				big_table
			WHERE
				categoria_url3 NOT IN (
					SELECT
						nombre
					FROM
						categorias
				)
		);

CREATE SEQUENCE palabrasclave_seq MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 100;

INSERT INTO palabrasclave (
	id,
	nombre
)
	SELECT
		palabrasclave_seq.NEXTVAL AS id,
		nombre
	FROM
		(
			SELECT DISTINCT
				lower(palabras_clave_url1) nombre
			FROM
				big_table
			WHERE
				palabras_clave_url1 NOT IN (
					SELECT
						nombre
					FROM
						palabrasclave
				)
		);

INSERT INTO palabrasclave (
	id,
	nombre
)
	SELECT
		palabrasclave_seq.NEXTVAL AS id,
		nombre
	FROM
		(
			SELECT DISTINCT
				lower(palabras_clave_url2) nombre
			FROM
				big_table
			WHERE
				palabras_clave_url2 NOT IN (
					SELECT
						nombre
					FROM
						palabrasclave
				)
		);

INSERT INTO palabrasclave (
	id,
	nombre
)
	SELECT
		palabrasclave_seq.NEXTVAL AS id,
		nombre
	FROM
		(
			SELECT DISTINCT
				lower(palabras_clave_url3) nombre
			FROM
				big_table
			WHERE
				palabras_clave_url3 NOT IN (
					SELECT
						nombre
					FROM
						palabrasclave
				)
		);

INSERT INTO noticias_categorias (
	id_noticia,
	id_categoria
)
	SELECT
		bt.nro_url1   id_noticia,
		c.id          id_categoria
	FROM
		big_table bt,
		categorias c
	WHERE
		lower(bt.categoria_url1) = c.nombre
	GROUP BY
		bt.nro_url1,
		c.id;

INSERT INTO noticias_categorias (
	id_noticia,
	id_categoria
)
	SELECT
		bt.nro_url2   id_noticia,
		c.id          id_categoria
	FROM
		big_table bt,
		categorias c
	WHERE
		lower(bt.categoria_url2) = c.nombre
	GROUP BY
		bt.nro_url2,
		c.id;

INSERT INTO noticias_categorias (
	id_noticia,
	id_categoria
)
	SELECT
		bt.nro_url3   id_noticia,
		c.id          id_categoria
	FROM
		big_table bt,
		categorias c
	WHERE
		lower(bt.categoria_url3) = c.nombre
	GROUP BY
		bt.nro_url3,
		c.id;

INSERT INTO noticias_palabrasclave (
	id_noticia,
	id_palabraclave
)
	SELECT
		bt.nro_url1   id_noticia,
		pc.id         id_palabraclave
	FROM
		big_table bt,
		palabrasclave pc
	WHERE
		lower(bt.palabras_clave_url1) = pc.nombre
	GROUP BY
		bt.nro_url1,
		pc.id;

INSERT INTO noticias_palabrasclave (
	id_noticia,
	id_palabraclave
)
	SELECT
		bt.nro_url2   id_noticia,
		pc.id         id_palabraclave
	FROM
		big_table bt,
		palabrasclave pc
	WHERE
		lower(bt.palabras_clave_url2) = pc.nombre
	GROUP BY
		bt.nro_url2,
		pc.id;

INSERT INTO noticias_palabrasclave (
	id_noticia,
	id_palabraclave
)
	SELECT
		bt.nro_url3   id_noticia,
		pc.id         id_palabraclave
	FROM
		big_table bt,
		palabrasclave pc
	WHERE
		lower(bt.palabras_clave_url3) = pc.nombre
	GROUP BY
		bt.nro_url3,
		pc.id;

CREATE SEQUENCE departamento_seq MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 100;

INSERT INTO departamentos (
	id,
	nombre
)
	SELECT
		departamento_seq.NEXTVAL id,
		nombre
	FROM
		(
			SELECT
				lower(departamento_femisidio) nombre
			FROM
				big_table
			GROUP BY
				departamento_femisidio
		);

CREATE SEQUENCE provincia_seq MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 100;

INSERT INTO provincias (
	id,
	nombre
)
	SELECT
		provincia_seq.NEXTVAL id,
		nombre
	FROM
		(
			SELECT
				lower(provincia_femisidio) nombre
			FROM
				big_table
			GROUP BY
				provincia_femisidio
		);

CREATE SEQUENCE lugar_seq MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 100;

INSERT INTO lugares (
	id,
	nombre
)
	SELECT
		lugar_seq.NEXTVAL id,
		nombre
	FROM
		(
			SELECT
				lower(lugar_femicidio) nombre
			FROM
				big_table
			GROUP BY
				lugar_femicidio
		);

INSERT INTO femisidios (
	id,
	id_victima,
	id_agresor,
	testigo,
	fecha,
	relacion,
	id_lugar,
	id_provincia,
	id_departamento,
	pais,
	tipo_arma,
	circunstancia,
	agresion_previa,
	estado_caso
)
	SELECT DISTINCT
		bt.nro                        id,
		v.id                          id_victima,
		a.id                          id_agresor,
		bt.testigos                   testigo,
		bt.fecha_femicidio            fecha,
		bt.relacion_victima           relacion,
		l.id                          id_lugar,
		p.id                          id_provincia,
		d.id                          id_departamento,
		'mexico' pais,
		bt.tipo_arma                  tipo_arma,
		bt.circunstancias_femisidio   circunstancia,
		bt.agresion_previa            agresion_previa,
		bt.estado_caso                estado_caso
	FROM
		big_table bt,
		agresores a,
		victimas v,
		lugares l,
		departamentos d,
		provincias p
	WHERE
		bt.nro = v.id
		AND bt.nro_agresor = a.id
		AND lower(bt.lugar_femicidio) = l.nombre
		AND lower(bt.departamento_femisidio) = d.nombre
		AND lower(bt.provincia_femisidio) = p.nombre;

INSERT INTO femisidios (
	id,
	id_victima,
	id_agresor,
	testigo,
	fecha,
	relacion,
	id_lugar,
	id_provincia,
	id_departamento,
	pais,
	tipo_arma,
	circunstancia,
	agresion_previa,
	estado_caso
)
	SELECT DISTINCT
		bt.nro                        id,
		v.id                          id_victima,
		a.id                          id_agresor,
		bt.testigos                   testigo,
		bt.fecha_femicidio            fecha,
		bt.relacion_victima           relacion,
		NULL id_lugar,
		p.id                          id_provincia,
		d.id                          id_departamento,
		'mexico' pais,
		bt.tipo_arma                  tipo_arma,
		bt.circunstancias_femisidio   circunstancia,
		bt.agresion_previa            agresion_previa,
		bt.estado_caso                estado_caso
	FROM
		big_table bt,
		agresores a,
		victimas v,
		departamentos d,
		provincias p
	WHERE
		bt.nro = v.id
		AND bt.nro_agresor = a.id
		AND lower(bt.departamento_femisidio) = d.nombre
		AND lower(bt.provincia_femisidio) = p.nombre
		AND bt.nro NOT IN (
			SELECT
				id
			FROM
				femisidios
		);

INSERT INTO femisidios (
	id,
	id_victima,
	id_agresor,
	testigo,
	fecha,
	relacion,
	id_lugar,
	id_provincia,
	id_departamento,
	pais,
	tipo_arma,
	circunstancia,
	agresion_previa,
	estado_caso
)
	SELECT DISTINCT
		bt.nro                        id,
		v.id                          id_victima,
		a.id                          id_agresor,
		bt.testigos                   testigo,
		bt.fecha_femicidio            fecha,
		bt.relacion_victima           relacion,
		NULL id_lugar,
		NULL id_provincia,
		NULL id_departamento,
		'mexico' pais,
		bt.tipo_arma                  tipo_arma,
		bt.circunstancias_femisidio   circunstancia,
		bt.agresion_previa            agresion_previa,
		bt.estado_caso                estado_caso
	FROM
		big_table bt,
		agresores a,
		victimas v
	WHERE
		bt.nro = v.id
		AND bt.nro_agresor = a.id
		AND bt.nro NOT IN (
			SELECT
				id
			FROM
				femisidios
		);

INSERT INTO femisidios_noticias (
	id_femisidio,
	id_noticia
)
	SELECT DISTINCT
		f.id   id_femisidio,
		n.id   id_noticia
	FROM
		big_table bt,
		femisidios f,
		noticias n
	WHERE
		bt.nro = f.id
		AND bt.nro_url1 = n.id;

INSERT INTO femisidios_noticias (
	id_femisidio,
	id_noticia
)
	SELECT DISTINCT
		f.id   id_femisidio,
		n.id   id_noticia
	FROM
		big_table bt,
		femisidios f,
		noticias n
	WHERE
		bt.nro = f.id
		AND bt.nro_url2 = n.id;

INSERT INTO femisidios_noticias (
	id_femisidio,
	id_noticia
)
	SELECT DISTINCT
		f.id   id_femisidio,
		n.id   id_noticia
	FROM
		big_table bt,
		femisidios f,
		noticias n
	WHERE
		bt.nro = f.id
		AND bt.nro_url3 = n.id;