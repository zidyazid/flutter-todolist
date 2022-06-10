import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_list/model.dart';

class Repository {
  var baseUrl = "https://6288b11c7af826e39e63fea5.mockapi.io";

  Future getAllData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + "/todolist"));

      print(response.statusCode);
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        print(response.body);
        List<Model> todo = it.map((e) => Model.fromJson(e)).toList();

        // var jsonObject = json.decode(response.body);
        // var todo = (jsonObject as Map<String, dynamic>)["data"];
        print(todo);

        return todo;
      }
    } catch (e) {
      print(e.toString());
    }
  }

// code dibawah dapat diabaikan terlebih dahulu
  Future postData(String judul, String deskripsi) async {
    try {
      final response = await http.post(Uri.parse(baseUrl + "/todolist"), body: {
        "judul": judul,
        "deskripsi": deskripsi,
      });

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getSingleData(String id) async {
    try {
      final response = await http.get(Uri.parse(baseUrl + "/todolist/$id"));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString);
    }
  }

  Future deleteData(String id) async {
    try {
      final response = await http.delete(Uri.parse(baseUrl + "/todolist/$id"));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateData(String id, String judul, String deskripsi) async {
    try {
      final response =
          await http.put(Uri.parse(baseUrl + "/todolist/$id"), body: {
        "judul": judul,
        "deskripsi": deskripsi,
      });

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
