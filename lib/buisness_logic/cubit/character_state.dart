import 'package:flutter/material.dart';
import 'package:lastbloc/data/models/charcter_model.dart';

@immutable
sealed class CharactersState {}

final class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<CharactersModel> characters;

  CharactersLoaded(this.characters);
}

class CharactersLoading extends CharactersState {}
class CharactersError extends CharactersState {}