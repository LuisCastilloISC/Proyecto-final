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
      : id = parsedJson['id'],
        tipo = parsedJson['tipo'],
        nombre = parsedJson['nombre'],
        descripcion = parsedJson['descripcion'],
        curiosidades = parsedJson['curiosidades'],
        caracteristicas = parsedJson['caracteristicas'],
        dificultad = parsedJson['dificultad'],
        comida = parsedJson['comida'],
        golosinas = parsedJson['golosinas'],
        higiene = parsedJson['higiene'],
        alimentacion = parsedJson['alimentacion'],
        fisico = parsedJson['fisico'],
        reproduccion = parsedJson['reproduccion'],
        luz = parsedJson['luz'],
        fertilizante = parsedJson['fertilizante'],
        agua = parsedJson['agua'],
        fertilizacion = parsedJson['fertilizacion'],
        temporada = parsedJson['temporada'],
        propagacion = parsedJson['propagacion'];
}
