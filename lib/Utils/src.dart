import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

// Future<String> fileUpload1(String path) async {
//   return ImageKit.io(
//     File(path),
//     privateKey: "private_/ixEFm8zmvLC+cRnpsQoDFgPdQ0=",
//   );
// }

Future<String?> fileUpload(String path, {bool isKey = false}) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('https://api.zodoai.com/api/file-upload'),
  );
  request.files.add(await http.MultipartFile.fromPath('file', path));

  http.StreamedResponse response = await request.send();

  String body = await response.stream.bytesToString();
  log(body);
  if (response.statusCode == 200 || response.statusCode == 201) {
    var data = json.decode(body);
    return data["data"][(isKey) ? "key" : "url"];
  } else {
    print(response.reasonPhrase);
  }
}
