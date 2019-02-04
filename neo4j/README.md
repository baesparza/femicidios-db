# Neo4j
Para iniciar con el trabajo de Neo4j, nos encontramos con Cypher un lenguaje de consulta de base de datos expresivo (pero compacto). Aunque actualmente es específico de Neo4j, su estrecha afinidad con nuestro hábito de representar gráficos como diagramas lo hace ideal para la descripción de gráficos mediante programación.
En este proyecto se utilizó completamente la interfaz grafica de Neo4j Desktop que permite observar de ampiimiente la relacion de los grafos.

### Datos

Para subir los datos a las base de datos de Neo4j, se trabajo con la version normalizada del modelo utilizado en la base de datos relacional, permitiendo obtener un grafo mas explicito

Para subir información como se menciono anteriormete se usa el lenjuage Cypher siguinedo la siguinete estructura:

```SQL
CREATE (v:Victima {_id: 1, nombre: "Lambertina",apellidos: "Jiménez Ramírez",nacionalidad: "Mexicana", causa_muerte: "Herida de bala" , hora_muerte: "14:00"}),
    (a:Agresor {_id: 1, nombre: "Aníbal Ignacio", apellidos: "Valente", situacion: "Profugos"}),
    (f:Femicidio {_id: 1, fecha:["01","06","2018"], relacion: "Conyugue", estado_caso: "Investigación", tipo_arma: "Arma de fuego", circunstancias: "Fue herida a balazos por su pareja sentimental en el interior de su domicilio"}),
    (l:Lugar {_id: 1, nombre: "Buena Vista de la Salud"}),
    (p:Provincia {_id: 1, nombre: "Guerrero"}),
    (d:Departamento {_id: 1, nombre: "Chilpancingo de los Bravo"}),
    (n:Noticia {_id: 1,nombre: "Mujer fue asesinada a balazos por su pareja en Buena Vista de la Salud", fecha: "17/01/2019", url: "http://redesdelsur.com.mx/2016/index.php/seguridad-y-justicias/35967-mujer-fue-asesinada-a-balazos-por-su-pareja-en-buena-vista-de-la-salud"}),
    (pa:Pais {_id: 1, nombre: "México"}),
    (c:Categoria {_id: 1,nombre: "Seguridad y Justicia"})
```
Pero el esquema anterior solo permite crear cada uno de los grafos que conforman a un femicidio. Por lo que es necesario crear las relaciones entre ellos de la siguiente forma:
```SQL
-- Se recupera los nodos que sean victima y femicidio
MATCH (v:Victima), (f:Femicidio)
-- Cuando cumplan la condicion
WHERE f._id=1 AND v._id=1 
-- Creamos la relacion entre el femicidio y la victima
CREATE (f)-[d:tieneVictima]->(v) 
```
Para mejorar o crear un proceso mas rapido se puede combinar el proceso de crear los nodos y los nodos en una misma sentencia CREATE, pero para los nodos que se relacionen con nodos ya creados en necesario realizar el proceso anterior.

```SQL
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
```