import 'package:flutter/material.dart';

class ThemeModel {
  final Color primarySwatch;
  ThemeModel(this.primarySwatch);
  ThemeModel.init() : this(Colors.amber);
}
