import 'package:flutter/material.dart';
import 'package:lastbloc/app_router.dart';
import 'package:lastbloc/buisness_logic/cubit/character_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocApp());
}

class BlocApp extends StatelessWidget {
  final CharactersCubit charactersCubit = CharactersCubit();
  final Approuter appRouter = Approuter();

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        theme: ThemeData.dark(),
        onGenerateRoute: appRouter.generateRoute,
      
    );
  }
}
