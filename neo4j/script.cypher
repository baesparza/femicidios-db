CREATE (v:Victima {_id: 1, nombre: "Lambertina",apellidos: "Jiménez Ramírez",nacionalidad: "Mexicana", causa_muerte: "Herida de bala" , hora_muerte: "14:00"}),
    (a:Agresor {_id: 1, nombre: "Aníbal Ignacio", apellidos: "Valente", situacion: "Profugos"}),
    (f:Femicidio {_id: 1, fecha:["01","06","2018"], relacion: "Conyugue", estado_caso: "Investigación", tipo_arma: "Arma de fuego", circunstancias: "Fue herida a balazos por su pareja sentimental en el interior de su domicilio"}),
    (l:Lugar {_id: 1, nombre: "Buena Vista de la Salud"}),
    (p:Provincia {_id: 1, nombre: "Guerrero"}),
    (d:Departamento {_id: 1, nombre: "Chilpancingo de los Bravo"}),
    (n:Noticia {_id: 1,nombre: "Mujer fue asesinada a balazos por su pareja en Buena Vista de la Salud", fecha: "17/01/2019", url: "http://redesdelsur.com.mx/2016/index.php/seguridad-y-justicias/35967-mujer-fue-asesinada-a-balazos-por-su-pareja-en-buena-vista-de-la-salud"}),
    (pa:Pais {_id: 1, nombre: "México"}),
    (c:Categoria {_id: 1,nombre: "Seguridad y Justicia"})

MATCH (v:Victima), (f:Femicidio)
WHERE f._id=1 AND v._id=1 
CREATE (f)-[d:tieneVictima]->(v)

MATCH (a:Agresor), (f:Femicidio)
WHERE f._id=1 AND a._id=1 
CREATE (f)-[d:tieneAgresor]->(a)

MATCH (l:Lugar), (f:Femicidio)
WHERE f._id=1 AND l._id=1 
CREATE (f)-[d:sucedioEn]->(l)

MATCH (n:Noticia), (f:Femicidio)
WHERE f._id=1 AND n._id=1 
CREATE (f)-[d:respaldado]->(n)

MATCH (n:Noticia), (c:Categoria)
WHERE c._id=1 AND n._id=1 
CREATE (n)-[d:clasificado]->(c)

MATCH (l:Lugar), (p:Provincia)
WHERE p._id=1 AND l._id=1 
CREATE (l)-[d:tieneProvincia]->(p)

MATCH (de:Departamento), (pa:Pais)
WHERE pa._id=1 AND de._id=1 
CREATE (de)-[d:estaDepartamento]->(pa)

MATCH (de:Departamento), (p:Provincia)
WHERE p._id=1 AND de._id=1 
CREATE (p)-[d:estaDepartamento]->(de)

CREATE (v:Victima {_id: 2, causa_muerte: "Herida de bala"}),
    (f:Femicidio {_id: 2, fecha:["01","06","2018"], estado_caso: "Investigación", tipo_arma: "Arma de fuego", circunstancias: "Presentó un impacto de bala a la altura del pómulo izquierdo y otro en la espalda"}),
    (p:Provincia {_id: 2, nombre: "Jalisco"}),
    (de:Departamento {_id: 2, nombre: "Tlajomulco de Zúñiga"}),
    (n:Noticia {_id: 2,nombre: "Asesinan a otra mujer en Tlajomulco", fecha: "17/01/2019", url: "http://www.ntrguadalajara.com/post.php?id_nota=100169"}),
    (c:Categoria {_id: 2,nombre: "Policiaca"}),
    (f)-[d:tieneVictima]->(v),
    (f)-[d2:sucedioEn]->(p),
    (f)-[d3:respaldado]->(n),
    (n)-[d4:clasificado]->(c)

MATCH (de:Departamento), (p:Provincia)
WHERE p._id=2 AND de._id=2 
CREATE (p)-[d:estaDepartamento]->(de)

MATCH (de:Departamento), (pa:Pais)
WHERE pa._id=1 AND de._id=2
CREATE (de)-[d:estaDepartamento]->(pa)

CREATE (v:Victima {_id: 3, nombre: "Pamela",apellidos: "Terán",nacionalidad: "Mexicana", causa_muerte: "Herida de bala"}),
    (a:Agresor {_id: 3, nombre: "Juan", apellidos: "Terán", situacion: "Profugos"}),
    (f:Femicidio {_id: 3, fecha:["02","06","2018"], relacion: "Padre", tipo_arma: "Arma de fuego", circunstancias: "Un grupo armado abrió fuego contra los tres cuando salían del establecimiento"}),
    (l:Lugar {_id: 3, nombre: "Centro de Juchitán"}),
    (p:Provincia {_id: 3, nombre: "Oaxaca"}),
    (de:Departamento {_id: 3, nombre: "Juchitán"}),
    (n:Noticia {_id: 3,nombre: "Asesinan a candidata del PRI en Juchitán, Oaxaca", fecha: "17/01/2019", url: "https://www.huffingtonpost.com.mx/2018/06/02/asesinan-a-candidata-en-juchitan-oaxaca_a_23449331/", autor: "Guillermina Ortiz Cortez"}),
    (n2:Noticia {_id: 4,nombre: "Triple asesinato en Juchitán, Oaxaca devela uso de recursos públicos en campañas del PRI", fecha: "17/01/2019", url: "https://www.nvinoticias.com/nota/93948/junto-con-la-candidata-concejal-pamela-teran-asesinan-la-jefa-de-comunicacion-de-la-sai", autor: "Nadia Altamirano"}),
    (f)-[d:tieneVictima]->(v),
    (f)-[d2:tieneAgresor]->(a),
    (f)-[d3:sucedioEn]->(l),
    (f)-[d4:respaldado]->(n),
    (f)-[d5:respaldado]->(n2)

MATCH (l:Lugar), (p:Provincia)
WHERE p._id=3 AND l._id=3
CREATE (l)-[d:tieneProvincia]->(p)

MATCH (de:Departamento), (p:Provincia)
WHERE p._id=3 AND de._id=3
CREATE (p)-[d:estaDepartamento]->(de)

MATCH (de:Departamento), (pa:Pais)
WHERE pa._id=1 AND de._id=3
CREATE (de)-[d:estaDepartamento]->(pa)

MATCH (n:Noticia), (c:Categoria)
WHERE c._id=2 AND n._id=3
CREATE (n)-[d:clasificado]->(c)

CREATE (v:Victima {_id: 4,nacionalidad: "Estadounidense", causa_muerte: "Herida de bala"}),
    (f:Femicidio {_id: 4, fecha:["03","06","2018"], testigos: "Si", tipo_arma: "Arma de fuego", circunstancias: "Un grupo armado abrió fuego contra los tres cuando salían del establecimiento"}),
    (l:Lugar {_id: 4, nombre: "Bahía de Los Ángeles, el pequeño pueblo de menos de mil habitantes, ubicado a nueve horas de Tijuana."}),
    (p:Provincia {_id: 4, nombre: "Baja California"}),
    (de:Departamento {_id: 4, nombre: "Ensenada"}),
    (n:Noticia {_id: 5,nombre: "Asesinan a pareja en Bahía de Los Ángeles", fecha: "23/01/2019", url: "https://www.elsoldetijuana.com.mx/policiaca/asesinan-a-pareja-en-bahia-de-los-angeles-1735998.html", autor: "Juan Miguel Hernández"}),
    (f)-[d:tieneVictima]->(v),
    (f)-[d2:sucedioEn]->(l),
    (f)-[d3:respaldado]->(n)

MATCH (l:Lugar), (p:Provincia)
WHERE p._id=4 AND l._id=4
CREATE (l)-[d:tieneProvincia]->(p)

MATCH (de:Departamento), (p:Provincia)
WHERE p._id=4 AND de._id=4
CREATE (p)-[d:estaDepartamento]->(de)

MATCH (de:Departamento), (pa:Pais)
WHERE pa._id=1 AND de._id=4
CREATE (de)-[d:estaDepartamento]->(pa)

MATCH (n:Noticia), (c:Categoria)
WHERE c._id=2 AND n._id=4
CREATE (n)-[d:clasificado]->(c)

CREATE (v:Victima {_id: 5, nombre: "Martina",apellidos: "López Pestaña",edad: 59, causa_muerte: "Herida de bala"}),
    (f:Femicidio {_id: 5, fecha:["10","06","2018"], estado_caso: "Investigación", tipo_arma: "Arma de fuego", circunstancias: "Una mujer que viajaba en una motocicleta fue asesinada."}),
    (l:Lugar {_id: 5, nombre: "Bahía de Los Ángeles, el pequeño pueblo de menos de mil habitantes, ubicado a nueve horas de Tijuana."}),
    (de:Departamento {_id: 5, nombre: "San Juan Bautista Tuxtepec"}),
    (n:Noticia {_id: 6,nombre: "Ejecutan a pareja en Tuxtepec, Oaxaca", fecha: "23/01/2019", url: "https://www.nvinoticias.com/nota/94611/ejecutan-pareja-en-tuxtepec-oaxaca", autor: "Geovvanni H. González"}),
    (c:Categoria {_id: 3,nombre: "Roja"}),
    (f)-[d:tieneVictima]->(v),
    (f)-[d2:sucedioEn]->(l),
    (n)-[d3:clasificado]->(c),
    (f)-[d4:respaldado]->(n)

MATCH (l:Lugar), (p:Provincia)
WHERE p._id=3 AND l._id=5
CREATE (l)-[d:tieneProvincia]->(p)

MATCH (de:Departamento), (p:Provincia)
WHERE p._id=3 AND de._id=5
CREATE (p)-[d:estaDepartamento]->(de)

MATCH (de:Departamento), (pa:Pais)
WHERE pa._id=1 AND de._id=5
CREATE (de)-[d:estaDepartamento]->(pa)

CREATE (v:Victima {_id: 6, nombre: "Claudia Mercedes",apellidos: "Gómez Méndez",edad: 34, ocupacion: "Ingeniera Civil",causa_muerte: "Herida de bala"}),
    (f:Femicidio {_id: 6, fecha:["08","06","2018"], tipo_arma: "Arma de fuego", circunstancias: "El ataque lo ejecutaron dos hombres que viajaban en una motocicleta que dispararon contra la mujer que quedó muerta al interior de la camioneta."}),
    (l:Lugar {_id: 6, nombre: "En la colonia Lomas de San Juan, en la agencia de San Juan Chapultepec, conurbada a la capital de Oaxaca."}),
    (de:Departamento {_id: 6, nombre: "Oaxaca de Juárez"}),
    (n:Noticia {_id: 7,nombre: "Otro feminicidio en Oaxaca; ejecutan a mujer en San Juan Chapultepec", fecha: "23/01/2019", url: "https://www.nvinoticias.com/nota/94398/otro-feminicidio-en-oaxaca-ejecutan-mujer-en-san-juan-chapultepec", autor: "Tomás Martínez"}),
    (f)-[d:tieneVictima]->(v),
    (f)-[d2:sucedioEn]->(l),
    (f)-[d3:respaldado]->(n)

MATCH (l:Lugar), (p:Provincia)
WHERE p._id=3 AND l._id=6
CREATE (l)-[d:tieneProvincia]->(p)

MATCH (de:Departamento), (p:Provincia)
WHERE p._id=3 AND de._id=6
CREATE (p)-[d:estaDepartamento]->(de)

MATCH (de:Departamento), (pa:Pais)
WHERE pa._id=1 AND de._id=6
CREATE (de)-[d:estaDepartamento]->(pa)

MATCH (n:Noticia), (c:Categoria)
WHERE c._id=3 AND n._id=7
CREATE (n)-[d:clasificado]->(c)