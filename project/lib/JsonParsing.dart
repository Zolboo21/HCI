import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'Mail.dart';

class JsonParsing {
  Future<void> saveData(List<Mail> data) async {
    debugPrint("origin : $data");
    debugPrint("origin : ${data[0].title}");

    String jsonData = jsonEncode(data.map((item) => item.toJson()).toList());

    debugPrint("jsonData : $jsonData");

    await saveJsonToFile(jsonData);

    /*
      var file = File('$_localPath/mail.json');
      file.writeAsStringSync(jsonData);
      debugPrint("file : $file");
       */
    //getData(jsonData);  //working well
  }
  List<Mail> getData(String jsonData) {
    List<dynamic> myList = json.decode(jsonData);
    List<Mail> mailObj = <Mail>[];

    for(int i = 0 ; i < myList.length ; i++) {
      var sender = myList[0]["sender"].toString();
      var title = myList[0]["title"].toString();
      var subTitle = myList[0]["subTitle"].toString();
      var message = myList[0]["message"].toString();
      var time = myList[0]["time"].toString();
      var isStar = myList[0]["isStar"] as bool;

      var temp = Mail(sender, title, subTitle, message, time, isStar);

      mailObj.add(temp);
    }

    //debugPrint("obj : ${mailObj[0].title}");
    return mailObj;
  }
  Future<void> saveJsonToFile(String jsonData) async {
    var fileName = 'mail.json';
    //const directory = "/data/user/0/project/app_flutter/";
    //var directory = await getApplicationDocumentsDirectory();
    //debugPrint("directory : $directory");

    var path = 'assets/mail/$fileName';

    final file = File(path);
    debugPrint("asd");
    if (await file.exists()) {
      debugPrint("true");
      // File exists, open it using the platform's default app
      await file.open();
    } else {
      debugPrint("else");
      // File does not exist, create it
      await file.create(recursive: true);
      debugPrint('File created: $path');
    }

    debugPrint("file : $file");

    //var filePath = path.join(directory.path, fileName);
    //var file = File(path);

    var sink = file.openWrite();

    sink.write(jsonData);
    debugPrint("jsonData after write");

    await sink.flush();
    await sink.close();

  }
}