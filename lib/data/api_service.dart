import 'dart:convert';

import 'package:flutter_animals_advanced/models/cat.dart';
import 'package:flutter_animals_advanced/models/cat_image.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Cat>> getAllCats() async {
    final response =
        await http.get(Uri.parse("https://api.thecatapi.com/v1/breeds"));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      Iterable list = result;
      return list.map((model) => Cat.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<String> getImageUrlByBreedId(String id) async {
    final response = await http.get(
        Uri.parse('https://api.thecatapi.com/v1/images/search?breed_ids=$id'));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      Iterable list = result;
      return list.map((model) => CatImage.fromJson(model)).toList()[0].url;
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
