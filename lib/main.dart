import 'package:darb_app/pages/startup_page.dart';
import 'package:darb_app/pages/supervisor_home.dart';
import 'package:darb_app/pages/welcome_page.dart';

import 'package:darb_app/utils/setup.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await databaseSetup();
  await setup();
  
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MainApp() ),);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      
      home: const SupervisorHome(),
      // StartupPage()
    );
  }
}