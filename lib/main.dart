import 'package:darb_app/pages/startup_page.dart';
import 'package:darb_app/utils/setup.dart';
import 'package:flutter/material.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await databaseSetup();
  await setup();
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StartupPage()
    );
  }
}
