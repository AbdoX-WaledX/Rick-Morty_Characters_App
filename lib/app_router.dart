import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastbloc/buisness_logic/cubit/character_cubit.dart';
import 'package:lastbloc/constants/strings.dart';
import 'package:lastbloc/data/models/charcter_model.dart';
import 'package:lastbloc/presentation/screens/charcters_details.dart';
import 'package:lastbloc/presentation/screens/homepage.dart';

class Approuter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => CharactersCubit(),
              child: Homepage(),
            );
          },
        );
      case charactersdetailsScreen:
        final character = settings.arguments as CharactersModel;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => CharactersCubit(),
              child: CharctersDetails(
                character: character,
              ),
            );
          },
        );
    }
  }
}
