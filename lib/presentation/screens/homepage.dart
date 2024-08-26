import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:lastbloc/buisness_logic/cubit/character_cubit.dart';
import 'package:lastbloc/buisness_logic/cubit/character_state.dart';
import 'package:lastbloc/data/models/charcter_model.dart';
import 'package:lastbloc/presentation/widgets/item.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late List<CharactersModel> allCharacters = [];
  late List<CharactersModel> searchedCharacters = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Image.asset(
            "assets/images/rick&morty_title.png",
            fit: BoxFit.contain,
            height: 65,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildSearchBar(),
            const SizedBox(height: 16),
            Expanded(
              child: OfflineBuilder(
                connectivityBuilder: (context, connectivity, child) {
                  final bool connected =
                      connectivity != ConnectivityResult.none;

                  return BlocBuilder<CharactersCubit, CharactersState>(
                    builder: (context, state) {
                      if (state is CharactersLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CharactersLoaded) {
                        allCharacters = state.characters;
                        return buildMovieGrid();
                      } else if (state is CharactersError) {
                        return const Center(
                          child: Text("Error: Could not load characters"),
                        );
                      } else {
                        return buildNoInternetWidget();
                      }
                    },
                  );
                },
                child: const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
Widget buildNoInternetWidget() {
  return SingleChildScrollView(
    child: Center(
      child: Container(
        height: 665,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.45),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          children: [
            const SizedBox(height: 20), // Adjusted spacing
            const Text(
              "Oops! No Connection!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              "It seems like you're offline. Please check your internet connection.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Image.asset(
              "assets/images/nointernet.png",
              height: 150,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your retry logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black12,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text("Retry"),
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search For Characters',
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear, color: Colors.white),
          onPressed: () {
            _searchController.clear(); // Clear the text field
            addSearchedCharactersToSearchedList(''); // Reset search
          },
        ),
      ),
      onChanged: (searchedCharacter) {
        addSearchedCharactersToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedCharactersToSearchedList(String searchedCharacter) {
    searchedCharacters = allCharacters
        .where(
          (character) => character.name!
              .toLowerCase()
              .startsWith(searchedCharacter.toLowerCase()),
        )
        .toList();
    setState(() {});
  }

  Widget buildMovieGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        crossAxisSpacing: 15,
        mainAxisSpacing: 12,
      ),
      itemCount: _searchController.text.isEmpty
          ? allCharacters.length
          : searchedCharacters.length,
      itemBuilder: (ctx, index) {
        return Item(
          character: _searchController.text.isEmpty
              ? allCharacters[index]
              : searchedCharacters[index],
        );
      },
    );
  }
}
