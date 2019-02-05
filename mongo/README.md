# MongoDB
### Comandos - Consola
Para comenzar el proyecto inicializamos MongoDB y determinamos en que base de datos vamos a trabajar a través de los siguientes comandos:
```shell
mongod # inicia el servidor de mongodb, deja el servicio corriendo
mongo # para ejecutar comandos de mongo, habilita el shell propio de mongo
show dbs # muestra las bases de datos, (como show databases en mysql)
use femicidioMexicoDB # crea la base de datos (pero no la crea exactamente hasta exista un valor en la base)
mongodump --db femicidioMexicoDB # generar un resapaldo de la base de datos 
mongorestore --db femicidioMexicoDB dump/femicidioMexicoDB # recupera la base de datos en base a los documentos creados del comando anterior
```
### Sentencias
Para empezar a subir datos desde consola es necesario crear un usuario con los permisos pertinentes para que pueda editar, borrar o actualizar los datos.
```javascript
// Crear un Usuario
db.createUser({
  user: 'Admin',
  pwd: 'admin',
  roles: ['readWrite', 'dbAdmin']
});

```
Cabe recalcar que el funcionamiento de MongoDB se da con el uso de colecciones, las mismas que buscan agrupar un conjunto de documentos que posean una estructura similar, pero la libertad que posee MongoDB puede generar ciertos fallos por la extensa liberta que ofrece por lo que se definió el siguiente jsonSchema:
```javascript
}
// Crear Collection
db.createCollection( "femicidios", { 
   validator: { 
      $jsonSchema: { 
      bsonType: "object", 
      required: [ "fecha_femicidio", "pais", "provincia", "departamento", "noticias.url", "noticias.fecha", "noticias.texto"], 
      properties: { 
         fecha_femicidio: { 
            bsonType: "string", 
            description: "required and must be a string" 
         }, 
         pais: { 
            bsonType: "string", 
            description: "required and must be a string" 
         },
         provincia: {
            bsonType: "string", 
            description: "required and must be a string"
         },
         departamento: {
            bsonType: "string", 
            description: "required and must be a string" 
         },
         testigos: {
            enum: [ "Si", "No" ],
            description: "can be only Si or NO" 
         },
         "noticias.url": {
            bsonType: "string", 
            description: "required and must be a string" 
         },
         "noticias.fecha": {
            bsonType: "string", 
            description: "required and must be a string" 
         },
         "noticias.texto": {
            bsonType: "string", 
            description: "required and must be a string" 
         }
      }
   }
}})
// Ver Collection
db.getCollectionInfos({name: "femicidios"})
// Mostrar Datos
db.customers.find().pretty()
```

### Datos
Para agregar datos en la base de datos creada se puede realizar en documento por documento o un arreglo de documentos siguiendo la siguiente estructura
```javascript
db.femicidios.insert(
    { fecha_femicidio: "01/06/2018", mes: "06", año: "2018", pais: "México", departamento: "Tlajomulco de Zúñiga", provincia: "Jalisco", circunstancias: "Presentó un impacto de bala a la altura del pómulo izquierdo y otro en la espalda", causa_muerte: "Herida de bala", tipo_arma: "Arma de fuego", noticias: { url: "http://www.ntrguadalajara.com/post.php?id_nota=100169", fecha: "17/01/2019", texto: "Asesinan a otra mujer en Tlajomulco", autor: "Ezequiel Cruz", categoria: "Policiaca" } }
)
```
Pero para facilitar este proceso se lo realizo con el uso de la propia interfaz gráfica ofrecida por MongoDB que nos permite cargar directamente desde un archivo JSON
<div style="text-align:center"><img src="https://raw.githubusercontent.com/jahurtadod/femisidios-db/master/mongo/datos.PNG"
     alt="Cargar datos desde MongoDB Compass"/></div>
```JSON
{"fecha_femicidio": "01/06/2018","mes": "06","año": "2018","hora": "14:00","pais": "México","lugar": "Buena Vista de la Salud","departamento": "Chilpancingo de los Bravo","provincia": "Guerrero","circunstancias": "Fue herida a balazos por su pareja sentimental en el interior de su domicilio","victima": {"nombre": "Lambertina","apellidos": "Jiménez Ramírez","nacionalidad": "Mexicana"},"agresor": {"nombre": "Aníbal Ignacio","apellidos": "Valente","situación": "Profugos"},"causa_muerte": "Herida de bala","relacion": "Conyugue","estado_caso": "Investigación","tipo_arma": "Arma de fuego","noticias": {"url": "http://redesdelsur.com.mx/2016/index.php/seguridad-y-justicias/35967-mujer-fue-asesinada-a-balazos-por-su-pareja-en-buena-vista-de-la-salud","fecha": "17/01/2019","texto": "Mujer fue asesinada a balazos por su pareja en Buena Vista de la Salud","categoria": "Seguridad y Justicia"}}
{"fecha_femicidio": "01/06/2018","mes": "06","año": "2018","pais": "México","departamento": "Tlajomulco de Zúñiga","provincia": "Jalisco","circunstancias": "Presentó un impacto de bala a la altura del pómulo izquierdo y otro en la espalda","causa_muerte": "Herida de bala","tipo_arma": "Arma de fuego","noticias": {"url": "http://www.ntrguadalajara.com/post.php?id_nota=100169","fecha": "17/01/2019","texto": "Asesinan a otra mujer en Tlajomulco","autor": "Ezequiel Cruz","categoria": "Policiaca"}}
{"fecha_femicidio": "02/06/2018","mes": "06","año": "2018","hora": "03:00","pais": "México","lugar": "Centro de Juchitán","departamento": "Juchitán","provincia": "Oaxaca","circunstancias": "Un grupo armado abrió fuego contra los tres cuando salían del establecimiento","victima": {"nombre": "Pamela","apellidos": "Terán","nacionalidad": "Mexicana"},"agresor": {"nombre": "Juan","apellidos": "Terán","situación": "Profugos"},"causa_muerte": "Herida de bala","relacion": "Padre","tipo_arma": "Arma de fuego","noticias": [{"url": "https://www.huffingtonpost.com.mx/2018/06/02/asesinan-a-candidata-en-juchitan-oaxaca_a_23449331/","fecha": "17/01/2019","texto": "Asesinan a candidata del PRI en Juchitán, Oaxaca","autor": "Guillermina Ortiz Cortez","categoria": "Política"}, {"url": "https://www.nvinoticias.com/nota/93948/junto-con-la-candidata-concejal-pamela-teran-asesinan-la-jefa-de-comunicacion-de-la-sai","fecha": "17/01/2019","texto": "Triple asesinato en Juchitán, Oaxaca devela uso de recursos públicos en campañas del PRI","autor": "Nadia Altamirano"}]}
{"fecha_femicidio": "03/06/2018","mes": "06","año": "2018","pais": "México","lugar": "Bahía de Los Ángeles, el pequeño pueblo de menos de mil habitantes, ubicado a nueve horas de Tijuana.","departamento": "Ensenada","provincia": "Baja California","circunstancias": "Una pareja de ciudadanos americanos de la tercera edad fue asesinada a balazos para despojarlos de sus pertenencias, en especial de un yate.","victima": {"nacionalidad": "Estadounidense"},"causa_muerte": "Herida de bala","tipo_arma": "Arma de fuego","testigos":"Si","noticias": {"url": "https://www.elsoldetijuana.com.mx/policiaca/asesinan-a-pareja-en-bahia-de-los-angeles-1735998.html","fecha": "23/01/2019","texto": "Asesinan a pareja en Bahía de Los Ángeles","palabras_clave": "Pareja","autor": "Juan Miguel Hernández","categoria": "Policiaca"}}
{"fecha_femicidio": "04/06/2018","mes": "06","año": "2018","pais": "México","lugar": "Hotel Santa Fe","departamento": "Acuña","provincia": "Coahuila de Zaragoza","circunstancias": "Había sido ahorcada pero antes golpeada brutalmente.","victima": {"nombre": "Ángela Fernández","apellidos": "Hernández","edad": 60,"nacionalidad": "Mexicana"},"agresor": {"nombre": "Juan","situación": "Cumpliendo sentencia"},"causa_muerte": "Ahorcada","estado_caso": "Cerrado","sentencia": "Prisión","noticias": {"url": "http://www.elheraldodesaltillo.mx/2018/06/06/feminicida-es-vinculado-a-proceso/","fecha": "23/01/2019","texto": "Feminicida es vinculado a proceso","palabras_clave": "Coahuila"}}
{"fecha_femicidio": "05/06/2018","mes": "06","año": "2018","pais": "México","lugar": "En una casa de la colonia Amalia G. de Castillo Ledón de Ciudad Victoria.","departamento": "Victoria","provincia": "Tamaulipas","circunstancias": "Una mujer murió al ser apuñalada en varias ocasiones con un cuchillo","victima": {"nombre": "Irma","edad": 66},"causa_muerte": "Herida de arma blanca","relacion": "Nieto","tipo_arma": "Arma blanca","noticias": {"url": "http://www.hoytamaulipas.net/notas/344513/Asesina-a-punialadas-a-su-abuelita-en-Ciudad-Victoria.html","fecha": "23/01/2019","texto": "Asesina a puñaladas a su abuelita en Ciudad Victoria","autor": "Guadalupe Delgado"}}
{"fecha_femicidio": "06/06/2018","mes": "06","año": "2018","pais": "México","lugar": "Bosque del poblado de San Juan Tlacotenco","departamento": "Tepoztlán","provincia": "Morelos","circunstancias": "Quemada en más de 70% de su cuerpo fue encontrado el cuerpo de una mujer","victima": {"nombre": "Lesley","edad": 20,"nacionalidad": "Mexicana","ocupacion": "Estudiante de Odontología "},"noticias": {"url": "http://www.elgrafico.mx/morelos/07-06-2018/asesinan-una-mujer-y-luego-le-prenden-fuego-en-tepoztlan","fecha": "23/01/2019","texto": "Asesinan a una mujer y luego le prenden fuego, en Tepoztlán","palabras_clave": "Femicidio","autor": "Carlos de la Fuente"}}
{"fecha_femicidio": "10/06/2018","mes": "06","año": "2018","pais": "México","departamento": "San Juan Bautista Tuxtepec","provincia": "Oaxaca","circunstancias": "Una mujer que viajaba en una motocicleta fue asesinada.","victima": {"nombre": "Martina","apellidos": "López Pestaña","edad": 59},"causa_muerte": "Herida de bala","estado_caso": "Investigación","tipo_arma": "Arma de fuego","noticias": {"url": "https://www.nvinoticias.com/nota/94611/ejecutan-pareja-en-tuxtepec-oaxaca","fecha": "23/01/2019","texto": "Ejecutan a pareja en Tuxtepec, Oaxaca","autor": "Geovvanni H. González","categoria": "Roja"}}
{"fecha_femicidio": "09/06/2018","mes": "06","año": "2018","pais": "México","lugar": "Vía pública, en la prolongación Paseo de los Héroes de la colonia 20 de noviembre.","departamento": "Tijuana","provincia": "Baja California","circunstancias": "Fue declarada sin vida por paramédicos de la Cruz Roja, después de que fuera encontrada con lesiones en el cuello y huellas de golpes","victima": {"edad": 30},"causa_muerte": "Degollada","noticias": {"url": "https://www.elsoldetijuana.com.mx/policiaca/muere-mujer-tras-ser-degollada-1751792.html","fecha": "23/01/2019","texto": "Muere mujer tras ser degollada","autor": "Uriel Saucedo","categoria": "Policiaca"}}
{"fecha_femicidio": "08/06/2018","mes": "06","año": "2018","pais": "México","lugar": "En la colonia Lomas de San Juan, en la agencia de San Juan Chapultepec, conurbada a la capital de Oaxaca.","departamento": "Oaxaca de Juárez","provincia": "Oaxaca","circunstancias": "El ataque lo ejecutaron dos hombres que viajaban en una motocicleta que dispararon contra la mujer que quedó muerta al interior de la camioneta.","victima": {"nombre": "Claudia Mercedes","apellidos": "Gómez Méndez","edad": 34, "ocupacion": "Ingeniera Civil"},"causa_muerte": "Herida de bala","tipo_arma": "Arma de fuego","noticias": {"url": "https://www.nvinoticias.com/nota/94398/otro-feminicidio-en-oaxaca-ejecutan-mujer-en-san-juan-chapultepec","fecha": "23/01/2019","texto": "Otro feminicidio en Oaxaca; ejecutan a mujer en San Juan Chapultepec","autor": "Tomás Martínez","categoria": "Roja"}}

```
### Funcionamiento
A medida que sus datos crecen, la necesidad de establecer índices adecuados se vuelve fundamental para el rendimiento. MongoDB admite una amplia gama de opciones de indexación para permitir una consulta rápida de sus datos, en este caso no se considera permitente la creación de un nuevo índex debido a la cantidad de datos que se posee.
Un apartado interesante que podemos encontrar en MongoDB es la existencias de ciertas características de SQL como es el GROUP BY:

```javascript
db.femicidios.aggregate([{
    $group: {
        _id: "$provincia",
        "Victimas": {
            $push: "$victima"
        }
    }
}])
```
Para realizar consultas a través desde MongoDB Compas se sigue la siguiente estructura:
```shell
FILTER { provincia: "Oaxaca" } # Filtra los datos 
PROJECT { "victima": 0, "agresor": 0, "noticias": 0, _id: 0 } # Selecciona que atribustos mostar
SORT {fecha_femicidio: 1} # Ordena
```
<div style="text-align:center"><img src="https://raw.githubusercontent.com/jahurtadod/femisidios-db/master/mongo/busqueda.PNG"
     alt="Buscar datos desde MongoDB Compass"/></div>

Ahora observemos como se realizaría consultas directamente en el Shell de MondoDB
```javascript
// Femicidios con victimas mayores de 18 años
db.femicidios.find({ "victima.edad": { $gt: 18 } })
// Femicidios con victimas mayores de 50 años mostrando solo los datos de la victima
db.femicidios.find(
    { "victima.edad": { $gt: 50 } },
    { "victima": 1, _id: 0 }
)
// Mostar los datos de la victima de los femicidios donde se conozca el nombre de las victimas
db.femicidios.find(
    { "victima.nombre": { $ne: null } },
    { "victima": 1, _id: 0 }
)
// Mortar a las victimas y agresores en los casos que posean dichos datos
db.femicidios.find(
    {
        $and: [{ "victima.nombre": { $ne: null } },
        { "agresor.nombre": { $ne: null } }]
    },
    { "victima": 1, "agresor": 1, _id: 0 }
)
// Mostar los femicidios efectuados con armas de fuego
db.femicidios.find(
    { tipo_arma: "Arma de fuego" },
    { "victima": 0, "agresor": 0, "noticias": 0, _id: 0 }
)
// Mostar los femicidios efectuados con armas de fuego ordenados por la fecha
db.femicidios.find(
    { tipo_arma: "Arma de fuego" },
    { "victima": 0, "agresor": 0, "noticias": 0, _id: 0 }
)
// Agrupar los femicidios por el departamento del suceso
db.femicidios.aggregate([{
    $group: { _id: "$departamento" }
}])
// Mostar la cantidad de femicidios por cada provincia
db.femicidios.aggregate([{
    $group: {
        _id: "$provincia",
        "cantidad": {
            $sum: 1
        }
    }
}])
// Mostar quienes fueron asesinadas por cada provincia
db.femicidios.aggregate([{
    $group: {
        _id: "$provincia",
        "Victimas": {
            $push: "$victima"
        }
    }
}])
// Calcular el total de femicidios
db.femicidios.aggregate([{ $count: 'Total' }])
// Mostrar los femicidios ocuridos en Oaxaca ordenados por la fecha de forma scedente
db.femicidios.find(
    { provincia: "Oaxaca" },
    { "victima": 0, "agresor": 0, "noticias": 0, _id: 0 }
).sort({ fecha_femicidio: 1 })
```
### Resultado - MongoDB
<div style="text-align:center"><img src="https://raw.githubusercontent.com/jahurtadod/femisidios-db/master/mongo/base.PNG"
     alt="Femicidios MongoDB"/></div>
