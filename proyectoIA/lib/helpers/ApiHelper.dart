import 'dart:core';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';

import 'package:proyectoIA/models/Entidad.dart';

final _root = 'http://192.168.1.70:3000';

class ApiHelper {
  Client client = Client();

  Future postPlantFile(File path) async {
    try {
      var url = "$_root/IAPlanta";

// open a bytestream
      var stream = new ByteStream(DelegatingStream.typed(path.openRead()));
      // get file length
      var length = await path.length();
      // string to uri
      var uri = Uri.parse(url);
      // create multipart request
      var request = new MultipartRequest("POST", uri);
      // multipart that takes file
      var multipartFile = new MultipartFile('image', stream, length,
          filename: basename(path.path));
      // add file to multipart
      request.files.add(multipartFile);
      // send
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      var jsonres = json.decode(respStr);
      var entidad = await getEntidadByName(jsonres["planta"]);
      entidad.listImgurl = await getImagesByname(jsonres["planta"]);
      return entidad;
    } catch (x) {
      print(x);
    }
  }

  Future postPetFile(File path) async {
    try {
      var url = "$_root/IAAnimal";

// open a bytestream
      var stream = new ByteStream(DelegatingStream.typed(path.openRead()));
      // get file length
      var length = await path.length();
      // string to uri
      var uri = Uri.parse(url);
      // create multipart request
      var request = new MultipartRequest("POST", uri);
      // multipart that takes file
      var multipartFile = new MultipartFile('image', stream, length,
          filename: basename(path.path));
      // add file to multipart
      request.files.add(multipartFile);
      // send
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      var jsonres = json.decode(respStr);

      var entidad = await getEntidadByName(jsonres["animal"]);
      entidad.listImgurl = await getImagesByname(jsonres["animal"]);
      return entidad;
    } catch (x) {
      print(x);
    }
  }

  Future<Entidad> getEntidadByName(String nombre) async {
    final response =
        await client.get('$_root/getEntidad', headers: {"Nombre": "$nombre"});
    if (response.body != '[]') {
      dynamic resBody = json.decode(response.body);
      Entidad entidad = new Entidad.fromJson(resBody[0]);
      return entidad;
    } else {
      return null;
    }
  }

  Future<List<String>> getImagesByname(String nombre) async {
    var urls = new List<String>();
    final response =
        await client.get('$_root/getImages', headers: {"Nombre": "$nombre"});
    if (response.body != '[]') {
      for (Map<String, dynamic> object in json.decode(response.body)) {
        urls.add(object["url"]);
      }
      return urls;
    } else {
      return null;
    }
  }

  Future test() async {
    final response = await client.get("http://192.168.1.70:3000/");

    final d = json.decode(response.body);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to get token');
    }
  }
}
