import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<String>> pokemonList;

  @override
  void initState() {
    super.initState();
    pokemonList = ApiService().fetchPokemonList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pokédex")),
      body: FutureBuilder<List<String>>(
        future: pokemonList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView( // ✅ requisito
              child: Column(
                children: snapshot.data!.map((name) {
                  return ListTile(
                    title: Text(name.toUpperCase()),
                    onTap: () {
                      Navigator.push( // ✅ redirección
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(name: name),
                        ),
                      );
                    },
                  );
                }).toList(),
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