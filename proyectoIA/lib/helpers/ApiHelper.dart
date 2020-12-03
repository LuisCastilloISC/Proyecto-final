import 'dart:core';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';

final _root = 'http://192.168.1.70:3000';

class ApiHelper {
  Client client = Client();

  Future postUserImageFile(File path) async {
    try {
      var url = "$_root/IAimage";

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
     

      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
      return {"Tipo":"Animal"};
    } catch (x) {
      print(x);
    }
  }

  Future test() async {
    
    final response = await client.get("http://192.168.1.70:3000/");

    final d = json.decode(response.body);
    print(d);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to get token');
    }
  }
}
