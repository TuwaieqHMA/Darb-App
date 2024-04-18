import 'dart:io';

import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/services/database_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future databaseSetup() async {
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
      url: dotenv.env["supabaseUrl"]!,
      anonKey: dotenv.env["supabaseAnonKey"]!,
      );
}

Future setup() async {
  await GetStorage.init();
  
  GetIt.I.registerSingleton<HomeData>(HomeData());
  GetIt.I.registerSingleton<DBService>(DBService());

  if(Platform.isAndroid) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }

}