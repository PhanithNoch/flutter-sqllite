import 'package:flutter/material.dart';
import 'package:flutter_sqllite/api/models/photo_model.dart';
import 'package:flutter_sqllite/api/services/api_service.dart';

class APIHomeScreen extends StatefulWidget {
  const APIHomeScreen({Key key}) : super(key: key);

  @override
  _APIHomeScreenState createState() => _APIHomeScreenState();
}

class _APIHomeScreenState extends State<APIHomeScreen> {
  APIService apiService = APIService();
  @override
  void initState() {
    apiService.fetchPhoto();
    apiService.testing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Home Screen"),
      ),
      body: FutureBuilder<List<PhotoModel>>(
        future: apiService.fetchPhoto(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                PhotoModel data = snapshot.data[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      trailing: Image.network(data.thumbnailUrl),
                      title: Text(data.title),
                      leading: Text("${data.id}"),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
