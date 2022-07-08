import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:task_planner/infrastructure/database/db.dart';
import 'package:task_planner/infrastructure/database/open_db_connection.dart';
import 'package:task_planner/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Database.initialize(openConnection());

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme,
      routerDelegate: RoutemasterDelegate(routesBuilder: (_) => routes),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
