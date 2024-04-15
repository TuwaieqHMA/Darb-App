import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/pages/attendance_list.dart';
import 'package:darb_app/pages/driver_home.dart';
import 'package:darb_app/pages/map_page.dart';
import 'package:darb_app/pages/map_student.dart';
import 'package:darb_app/pages/startup_page.dart';
import 'package:darb_app/pages/student_home.dart';
import 'package:darb_app/pages/student_location_page.dart';
import 'package:darb_app/pages/add_bus.dart';
import 'package:darb_app/pages/add_driver.dart';
import 'package:darb_app/pages/add_student.dart';
import 'package:darb_app/pages/add_trip.dart';
import 'package:darb_app/pages/bus_list_page.dart';
import 'package:darb_app/pages/driver_list_page.dart';
import 'package:darb_app/pages/edit_bus.dart';
import 'package:darb_app/pages/edit_driver.dart';
import 'package:darb_app/pages/edit_trip.dart';
import 'package:darb_app/pages/profile_page.dart';
import 'package:darb_app/pages/startup_page.dart';
import 'package:darb_app/pages/student_list_page.dart';
import 'package:darb_app/pages/supervisor_add_type_page.dart';
import 'package:darb_app/pages/supervisor_home_page.dart';
import 'package:darb_app/pages/supervisor_naivgation_page.dart';
import 'package:darb_app/pages/tracking_page.dart';
import 'package:darb_app/pages/verify_email_page.dart';
import 'package:darb_app/pages/welcome_page.dart';
import 'package:darb_app/utils/app_locale.dart';
import 'package:darb_app/widgets/wave_decoration.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:darb_app/utils/setup.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
    return MaterialApp(
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
      // const SupervisorNavigationPage(),
      const WelcomePage(),
      // StartupPage(),
    );
  }
}
