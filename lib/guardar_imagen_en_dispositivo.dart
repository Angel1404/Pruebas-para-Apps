import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
//Guardar una imagen que viene por url en el dispositivo
//Paquetes DIO, path_provider, 'package:path/path.dart' as path;

Future saveImage() async {
  String file = 'https://amera.losolivoscartagena.com/storage/profiles/SP2410.png';
  //Instanciamos la clase donde hacemos la peticion
  final response = Cone();
  //Obtenemos la lista de int o bytes que nos refresa la peticion
  final data = await response.getImage(file);
  //Accedemos al directorio donde se encuentra nustra app en el dispositivo
  final documentDirectory = await getApplicationDocumentsDirectory();
  //Le damos un nombre, esto es opcional podemos darle uno nosotros o
  //dinamicamente como se mustra aqui con la fecha actual
  String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //Aqui creamos el archivo file que guardaremos en el dispositivo
  File files = File(path.join(documentDirectory.path, '$fileName.png'));
  //Y aqui escribimos o guardamos los bytes de la imagen en el archivo file antes creado
  files.writeAsBytes(data!);
}

class Cone {
  final dio = Dio();
  Future<List<int>?> getImage(String url) async {
    //Se manda una peticion a la immagen que se quiere descargar,
    // y le decimos que nos regrese una llista de int o bytes de la siguiente manera
    Response<List<int>> response = await dio.get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );

    //Y se retorna la data, que seria la lista de int o bytess
    return response.data;
  }
}
