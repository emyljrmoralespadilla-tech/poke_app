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
  late TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    pokemonList = ApiService().fetchPokemonList();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pokédex")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar Pokémon',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<String>>(
              future: pokemonList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final filteredList = snapshot.data!.where((name) => name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
                  return SingleChildScrollView( // ✅ requisito
                    child: Column(
                      children: filteredList.map((name) {
                        return ListTile(
                          title: Text(name.toUpperCase(), style: const TextStyle(fontSize: 30)),
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
          ),
        ],
      ),
    );
  }
}