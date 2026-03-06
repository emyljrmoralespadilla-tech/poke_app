import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

class ApiService {
  Future<List<String>> fetchPokemonList() async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=20'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(
        data['results'].map((pokemon) => pokemon['name']),
      );
    } else {
      throw Exception('Error al cargar lista');
    }
  }

  Future<Pokemon> fetchPokemonDetail(String name) async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon/$name'),
    );

    if (response.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al cargar detalle');
    }
  }
}