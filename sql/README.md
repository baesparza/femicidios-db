# Femicidios – México 
Para comenzar con el desarrollo del proyecto se partió de una tabla general que contenía los datos de cada femicidio y a si mimo se procedió a realizar la recolección de los datos, como es de esperar la redundancia de los datos es elevada por lo que se procede aplicar procesos de normalización para reducir la redundancia de los datos.
#### Esquema – Tabla General
<div style="text-align:center"><img src="https://raw.githubusercontent.com/jahurtadod/femisidios-db/master/sql/tablaGeneral.png"
     alt="Tabla General"/></div>
#### Esquema Normalizado
Tras aplicar las reglas de normalización, se determinaron las sientes tablas a crear, considerando a las tablas intermedias que nacen por las relaciones de N:M:
-	Femicido
-	Lugares 
-	Provincias
-	Departamentos
-	Victimas
-	Agresor
-	Personas
-	FemicidiosNoticias
-	Noticias
-	NoticasCategorias
-	NoticiasPalabrasClave
-	PalabrasClave

##### Cambios en el Esquema
Debido a la realidad de los datos ofrecidos por las noticias encontradas, el modelo anterior contiene errores debido a la existencia de valores nulos en la tabla de lugares, complicado crear las relaciones entre los departamentos y lugar, por tal motivo se procedio a realizar cambios en modelo.
<div style="text-align:center"><img src="https://raw.githubusercontent.com/jahurtadod/femisidios-db/master/sql/tablaNormalizada.png"
    alt="Modelo Normalizado"/></div>

### Creación de la Base de Datos
Para la recolección de los datos se utilizó de apoyo un archivo de Excel, facilitando la generación de las sentencias para subir información de cada femicidio, cabe recalcar que las sentencias que se generaron fueron en base a la tabla general ya que para obtener la importación de los datos se procede a realizar un esquema general en Oracle Database, para tras el uso de consultas obtener la información necesaria y ser pasadas al modelo normalizado de la base de datos.
##### Sentencia obtenida del Excel
```SQL
insert into big_table values (100,2,'43252','0,583333333333333','México','Buena Vista de la Salud','Chilpancingo de los Bravo','Guerrero','Fue herida a balazos por su pareja sentimental en el interior de su domicilio','Lambertina','Jiménez Ramírez','','Mexicana','',2101,'Aníbal Ignacio','Valente','','','','Herida de bala','Conyugue','','','Investigación','Profugos','','','Arma de fuego',4101,'http://redesdelsur.com.mx/2016/index.php/seguridad-y-justicias/35967-mujer-fue-asesinada-a-balazos-por-su-pareja-en-buena-vista-de-la-salud','43482','Mujer fue asesinada a balazos por su pareja en Buena Vista de la Salud','','','Seguridad y Justicia',,'','','','','','',,'','','','','','');
```
Tras la creación de la tabla general en Oracle, se procedió a realizar la creación del modelo normalizado con el uso de las siguientes sentencias:
```SQL
CREATE TABLE big_table (
	nro                        NUMBER(16, 0) NOT NULL,
	grupo                      NUMBER(16, 0) NOT NULL,
	fecha_femicidio            VARCHAR(255) NULL,
	hora_muerte                VARCHAR(255) NULL,
	pais                       VARCHAR(255) NULL,
	lugar_femicidio            VARCHAR(255) NULL,
	departamento_femisidio     VARCHAR(255) NULL,
	provincia_femisidio        VARCHAR(255) NULL,
	circunstancias_femisidio   VARCHAR(255) NULL,
	nombres_victima            VARCHAR(255) NULL,
	apellidos_victima          VARCHAR(255) NULL,
	edad_victima               VARCHAR(255) NULL,
	nacionalidad_victima       VARCHAR(255) NULL,
	ocupacion_victima          VARCHAR(255) NULL,
	nro_agresor                NUMBER(16, 0) NULL,
	nombres_agresor            VARCHAR(255) NULL,
	apellidos_agresor          VARCHAR(255) NULL,
	edad_agresor               VARCHAR(255) NULL,
	nacionalidad_agresor       VARCHAR(255) NULL,
	ocupacion_agresor          VARCHAR(255) NULL,
	causa_muerte               VARCHAR(255) NULL,
	relacion_victima           VARCHAR(255) NULL,
	tiempo_relacion            VARCHAR(255) NULL,
	agresion_previa            VARCHAR(255) NULL,
	estado_caso                VARCHAR(255) NULL,
	situacion_agresor          VARCHAR(255) NULL,
	sentencia                  VARCHAR(255) NULL,
	testigos                   VARCHAR(255) NULL,
	tipo_arma                  VARCHAR(255) NULL,
	nro_url1                   NUMBER(16, 0) NULL,
	url1                       VARCHAR(255) NULL,
	fecha_url1                 VARCHAR(255) NULL,
	texto_completo_url1        VARCHAR(255) NULL,
	palabras_clave_url1        VARCHAR(255) NULL,
	autor_url1                 VARCHAR(255) NULL,
	categoria_url1             VARCHAR(255) NULL,
	nro_url2                   NUMBER(16, 0) NULL,
	url2                       VARCHAR(255) NULL,
	fecha_url2                 VARCHAR(255) NULL,
	texto_completo_url2        VARCHAR(255) NULL,
	palabras_clave_url2        VARCHAR(255) NULL,
	autor_url2                 VARCHAR(255) NULL,
	categoria_url2             VARCHAR(255) NULL,
	nro_url3                   NUMBER(16, 0) NULL,
	url3                       VARCHAR(255) NULL,
	fecha_url3                 VARCHAR(255) NULL,
	texto_completo_url3        VARCHAR(255) NULL,
	palabras_clave_url3        VARCHAR(255) NULL,
	autor_url3                 VARCHAR(255) NULL,
	categoria_url3             VARCHAR(255) NULL
);

CREATE TABLE personas (
	id             NUMBER(16, 0) NOT NULL,
	nombre         VARCHAR2(255) NULL,
	apellido       VARCHAR2(255) NULL,
	edad           VARCHAR2(255) NULL,
	nacionalidad   VARCHAR2(255) NULL,
	ocupacion      VARCHAR2(255) NULL,
	CONSTRAINT persona_pk PRIMARY KEY ( id )
);

CREATE TABLE categorias (
	id       NUMBER(16, 0) NOT NULL,
	nombre   VARCHAR2(255) NULL,
	CONSTRAINT categoria_pk PRIMARY KEY ( id )
);

CREATE TABLE palabrasclave (
	id       NUMBER(16, 0) NOT NULL,
	nombre   VARCHAR2(255) NULL,
	CONSTRAINT palabraclave_pk PRIMARY KEY ( id )
);

CREATE TABLE noticias (
	id             NUMBER(16, 0) NOT NULL,
	url            VARCHAR2(255) NULL,
	nombre         VARCHAR2(255) NULL,
	fecha_acceso   VARCHAR2(255) NULL,
	autor          VARCHAR2(255) NULL,
	CONSTRAINT noticia_pk PRIMARY KEY ( id )
);

CREATE TABLE agresores (
	id          NUMBER(16, 0) NOT NULL,
	situacion   VARCHAR2(255) NULL,
	sentencia   VARCHAR2(255) NULL,
	CONSTRAINT agresor_pk PRIMARY KEY ( id ),
	CONSTRAINT agresor_persona_fk FOREIGN KEY ( id )
		REFERENCES personas ( id )
);

CREATE TABLE victimas (
	id             NUMBER(16, 0) NOT NULL,
	hora_muerte    VARCHAR2(255) NULL,
	causa_muerte   VARCHAR2(255) NULL,
	CONSTRAINT victima_pk PRIMARY KEY ( id ),
	CONSTRAINT victima_persona_fk FOREIGN KEY ( id )
		REFERENCES personas ( id )
);

CREATE TABLE departamentos (
	id       NUMBER(16, 0) NOT NULL,
	nombre   VARCHAR2(255) NULL,
	CONSTRAINT departamento_pk PRIMARY KEY ( id )
);

CREATE TABLE provincias (
	id       NUMBER(16, 0) NOT NULL,
	nombre   VARCHAR2(255) NULL,
	CONSTRAINT provincia_pk PRIMARY KEY ( id )
);

CREATE TABLE lugares (
	id       NUMBER(16, 0) NOT NULL,
	nombre   VARCHAR2(255) NULL,
	CONSTRAINT lugar_pk PRIMARY KEY ( id )
);

CREATE TABLE femisidios (
	id                NUMBER(16, 0) NOT NULL,
	id_victima        NUMBER(16, 0) NOT NULL,
	id_agresor        NUMBER(16, 0) NOT NULL,
	testigo           VARCHAR2(255) NULL,
	fecha             VARCHAR2(255) NULL,
	relacion          VARCHAR2(255) NULL,
	id_lugar          NUMBER(16, 0) NULL,
	id_provincia      NUMBER(16, 0) NULL,
	id_departamento   NUMBER(16, 0) NULL,
	pais              VARCHAR2(255) NULL,
	tipo_arma         VARCHAR2(255) NULL,
	circunstancia     VARCHAR2(255) NULL,
	agresion_previa   VARCHAR2(255) NULL,
	estado_caso       VARCHAR2(255) NULL,
	CONSTRAINT femisidio_pk PRIMARY KEY ( id ),
	CONSTRAINT victima_femicidio_fk FOREIGN KEY ( id_victima )
		REFERENCES victimas ( id ),
	CONSTRAINT agresor_femicidio_fk FOREIGN KEY ( id_agresor )
		REFERENCES agresores ( id ),
	CONSTRAINT lugar_femicidio_fk FOREIGN KEY ( id_lugar )
		REFERENCES lugares ( id ),
	CONSTRAINT provincia_femicidio_fk FOREIGN KEY ( id_provincia )
		REFERENCES provincias ( id ),
	CONSTRAINT departamento_femicidio_fk FOREIGN KEY ( id_departamento )
		REFERENCES departamentos ( id )
);

CREATE TABLE noticias_palabrasclave (
	id_noticia        NUMBER(16, 0) NOT NULL,
	id_palabraclave   NUMBER(16, 0) NOT NULL,
	CONSTRAINT noticia_palabraclave_pk PRIMARY KEY ( id_noticia,
	                                                 id_palabraclave ),
	CONSTRAINT noticia_palabraclave_fk FOREIGN KEY ( id_noticia )
		REFERENCES noticias ( id ),
	CONSTRAINT palabraclave_noticia_fk FOREIGN KEY ( id_palabraclave )
		REFERENCES palabrasclave ( id )
);

CREATE TABLE noticias_categorias (
	id_noticia     NUMBER(16, 0) NOT NULL,
	id_categoria   NUMBER(16, 0) NOT NULL,
	CONSTRAINT noticia_categoria_pk PRIMARY KEY ( id_noticia,
	                                              id_categoria ),
	CONSTRAINT noticia_categoria_fk FOREIGN KEY ( id_noticia )
		REFERENCES noticias ( id ),
	CONSTRAINT categoria_noticia_fk FOREIGN KEY ( id_categoria )
		REFERENCES categorias ( id )
);

CREATE TABLE femisidios_noticias (
	id_femisidio   NUMBER(16, 0) NOT NULL,
	id_noticia     NUMBER(16, 0) NOT NULL,
	CONSTRAINT femisidio_noticia_pk PRIMARY KEY ( id_femisidio,
	                                              id_noticia ),
	CONSTRAINT femisidio_noticia_fk FOREIGN KEY ( id_femisidio )
		REFERENCES femisidios ( id ),
	CONSTRAINT noticia_femisidio_fk FOREIGN KEY ( id_noticia )
		REFERENCES noticias ( id )
);
```
Al tener los dos modelos ahora era necesario realizar la migración de los datos del modelo no normalizado al modelo normalizado, como se menciona anteriormente esto se logró con la utilización de consultas para obtener los datos de cada tabla evitando obtener la redundancia de los datos
##### Sentencias 
```SQL
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
```