import 'package:flutter_sqllite/api/models/photo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  Future<List<PhotoModel>> fetchPhoto() async {
    var url =
        Uri.parse('https://jsonplaceholder.typicode.com/photos?_limit=10');
    // get response from api
    var response = await http.get(url);
    List lstPhotos = json.decode(response.body); // convert json to dart object
    List<PhotoModel> photos =
        lstPhotos.map((photo) => PhotoModel.fromJson(photo)).toList();
    return photos;
  }

  Future testing() async {
    var url = Uri.parse('http://10.0.2.2:3000/posts');
    // get response from api
    var response = await http.get(url);
    print(" response : ${response.body}");
  }
}
