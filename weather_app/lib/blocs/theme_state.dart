import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeData themeData;
  final MaterialColor materialColor;

  const ThemeState({@required this.themeData, @required this.materialColor})
      : assert(themeData != null),
        assert(materialColor != null);

  @override
  List<Object> get props => [themeData, materialColor];
}
