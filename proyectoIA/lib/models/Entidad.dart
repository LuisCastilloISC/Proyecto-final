class Entidad {
  int id;
  String tipo,
      nombre,
      descripcion,
      curiosidades,
      caracteristicas,
      dificultad,
      comida,
      golosinas,
      higiene,
      alimentacion,
      fisico,
      reproduccion,
      luz,
      fertilizante,
      agua,
      fertilizacion,
      temporada,
      propagacion;
  List<String> listImgurl;

  Entidad.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['Id'],
        tipo = parsedJson['Tipo'],
        nombre = parsedJson['Nombre'],
        descripcion = parsedJson['Descripcion'],
        curiosidades = parsedJson['Curiosidades'],
        caracteristicas = parsedJson['Caracteristicas'],
        dificultad = parsedJson['Dificultad'],
        comida = parsedJson['Comida'],
        golosinas = parsedJson['Golosinas'],
        higiene = parsedJson['Higiene'],
        alimentacion = parsedJson['Alimentacion'],
        fisico = parsedJson['Fisico'],
        reproduccion = parsedJson['Reproduccion'],
        luz = parsedJson['Luz'],
        fertilizante = parsedJson['Fertilizante'],
        agua = parsedJson['Agua'],
        fertilizacion = parsedJson['Fertilizacion'],
        temporada = parsedJson['Temporada'],
        propagacion = parsedJson['Propagacion'];
}
