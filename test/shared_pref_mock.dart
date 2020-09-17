import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setSharedPrefMockData() {
  SharedPreferences.setMockInitialValues({'theme': Colors.blue.value});
}
