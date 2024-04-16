import 'package:darb_app/bloc/bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/pages/add_bus.dart';
import 'package:darb_app/pages/add_driver.dart';
import 'package:darb_app/utils/app_locale.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:darb_app/utils/setup.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await databaseSetup();
  await setup();

  runApp(
    const MainApp(),
  );
}

final FlutterLocalization localization = FlutterLocalization.instance;

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN),
        const MapLocale('ar', AppLocale.AR),
      ],
      initLanguageCode: 'ar',
    );
    localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

// the setState function here is a must to add
  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SupervisorActionsBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: localization.supportedLocales,
        localizationsDelegates: localization.localizationsDelegates,
        locale: localization.currentLocale,
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        // theme: ThemeData.light(),
        // darkTheme: ThemeData.dark(),
      home: 
      // const Super visorNavigationPage(),
      const AddBus(),
      // const WelcomePage(),
      // const StartupPage(),
    ));
  }
}
