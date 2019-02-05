// Insertar
db.femicidios.insert(
    { fecha_femicidio: "01/06/2018", mes: "06", año: "2018", pais: "México", departamento: "Tlajomulco de Zúñiga", provincia: "Jalisco", circunstancias: "Presentó un impacto de bala a la altura del pómulo izquierdo y otro en la espalda", causa_muerte: "Herida de bala", tipo_arma: "Arma de fuego", noticias: { url: "http://www.ntrguadalajara.com/post.php?id_nota=100169", fecha: "17/01/2019", texto: "Asesinan a otra mujer en Tlajomulco", autor: "Ezequiel Cruz", categoria: "Policiaca" } }
)
// Femicidios con victimas mayores de 18 años
db.femicidios.find({ "victima.edad": { $gt: 18 } })
// Femicidios con victimas mayores de 50 años mostrando solo los datos de la victima
db.femicidios.find({ "victima.edad": { $gt: 50 } }, { "victima": 1, _id: 0 })
// Mostar los datos de la victima de los femicidios donde se conozca el nombre de las victimas
db.femicidios.find({ "victima.nombre": { $ne: null } }, { "victima": 1, _id: 0 })
// Mortar a las victimas y agresores en los casos que posean dichos datos
db.femicidios.find({ $and: [{ "victima.nombre": { $ne: null } }, { "agresor.nombre": { $ne: null } }] }, { "victima": 1, "agresor": 1, _id: 0 })
// Mostar los femicidios efectuados con armas de fuego
db.femicidios.find({ tipo_arma: "Arma de fuego" }, { "victima": 0, "agresor": 0, "noticias": 0, _id: 0 })
// Mostar los femicidios efectuados con armas de fuego ordenados por la fecha
db.femicidios.find({ tipo_arma: "Arma de fuego" }, { "victima": 0, "agresor": 0, "noticias": 0, _id: 0 })
// Agrupar los femicidios por el departamento del suceso
db.femicidios.aggregate([{ $group: { _id: "$departamento" } }])
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
db.femicidios.find({ provincia: "Oaxaca" }, { "victima": 0, "agresor": 0, "noticias": 0, _id: 0 }).sort({fecha_femicidio: 1})