import 'package:darb_app/bloc/attendance_list_bloc/attendance_list_bloc.dart';
import 'package:darb_app/bloc/driver_bloc/driver_bloc.dart';
import 'package:darb_app/bloc/student_bloc/student_bloc.dart';
import 'package:darb_app/bloc/trip_details_bloc/trip_details_bloc.dart';
import 'package:darb_app/bloc/chat_bloc/chat_bloc.dart';
import 'package:darb_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/utils/app_locale.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:darb_app/widgets/redirect_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:darb_app/utils/setup.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await databaseSetup();
  await setup();

  await checkConnectionSetup();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SupervisorActionsBloc()),
        BlocProvider(create: (context) => AuthBloc()),
         BlocProvider(
          create: (context) => ChatBloc(),
        ),
        BlocProvider(create: (context) => StudentBloc(),),
        BlocProvider(create: (context) => DriverBloc(),),
        BlocProvider(create: (context) => TripDetailsBloc(),),
        BlocProvider(create: (context) => AttendanceListBloc(),),
        ],
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
       const RedirectWidget(),
          ),
    );
  }
}
