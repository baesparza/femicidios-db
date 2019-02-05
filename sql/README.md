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
-- Poner las sentencias de creación
```
Al tener los dos modelos ahora era necesario realizar la migración de los datos del modelo no normalizado al modelo normalizado, como se menciona anteriormente esto se logró con la utilización de consultas para obtener los datos de cada tabla evitando obtener la redundancia de los datos
##### Sentencias 
```SQL
-- Poner las sentencias para migrar los datos 
```
##### Capturas de Pantalla

<div style="text-align:center"><img src=""
    alt="Creación del Modelo Normalizado"/></div>

<div style="text-align:center"><img src=""
    alt="Migración de los Datos"/></div>

<div style="text-align:center"><img src=""
    alt="Presentación de los Datos"/></div>
