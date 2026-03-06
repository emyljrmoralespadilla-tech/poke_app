import '../models/pokemon_model.dart';
import '../services/api_service.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String name;

  const DetailScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name.toUpperCase())),
      body: FutureBuilder<Pokemon>(
        future: ApiService().fetchPokemonDetail(name),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final pokemon = snapshot.data!;
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero( // ✅ requisito Hero
                      tag: pokemon.name,
                      child: SizedBox(width: 300, child: Image.network(pokemon.image, fit: BoxFit.contain,)),
                    ),
                    const SizedBox(height: 20),
                    Text("Altura: ${pokemon.height}",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    ),
                    Text("Peso: ${pokemon.weight}",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}