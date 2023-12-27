import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project_c/database/drift_database.dart';
import 'package:project_c/screen/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();
  final database = LocalDatabase();
  GetIt.I.registerSingleton<LocalDatabase>(database);
  runApp(
    const MaterialApp(home: HomeScreen()),
  );
}
