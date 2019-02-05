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
