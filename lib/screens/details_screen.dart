import 'package:flutter/material.dart';
import 'package:flutter_animals_advanced/data/api_service.dart';
import 'package:flutter_animals_advanced/models/cat.dart';

class DetailsScreen extends StatelessWidget {
  final Cat cat;

  DetailsScreen({required this.cat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cat.name),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          FutureBuilder(
            future: ApiService().getImageUrlByBreedId(cat.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String url = snapshot.data as String;
                return Image.network(
                  url,
                  height: 250,
                ); // image is ready
              } else {
                return new Container(
                  height: 250,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ); // placeholder
              }
            },
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 24, 8, 8),
            child: Text(
              cat.name,
              style: TextStyle(fontSize: 24),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              cat.description,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
