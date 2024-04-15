import 'dart:math';

import 'package:darb_app/models/bus_model.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/driver_model.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DBService {
  final supabase = Supabase.instance.client;
  final List<DarbUser> users = []; 
  final List<Driver> driver = []; 
  final List<Bus> buses = []; 
  final List<Trip> trips = []; 

  Future signUp({required String email, required String password}) async{
    await supabase.auth.signUp(
      email: email,
      password: password);
  }

  Future signIn({required String email, required String password}) async{
    await supabase.auth.signInWithPassword(
      email: email,
      password: password);
  }

  Future signOut({required String email, required String password}) async{
    await supabase.auth.signOut();
  }

  Future<Session?> getCurrentSession() async {
    return supabase.auth.currentSession;
  }

  Future<String> getCurrentUserId() async {
    return supabase.auth.currentUser!.id;
  }

  Future getAllUser() async{
    final user = await supabase.from('User').select('*');
    for(var element in user){
      users.add(DarbUser.fromJson(element));
    }
    print(users);
    print("users================================");
    return users;
  }

  Future getAllBuses() async{
    final bus = await supabase.from('Bus').select('*');
    for(var element in bus){
      buses.add(Bus.fromJson(element));
    }
    print(buses);
    print("users================================");
    return buses;
  }
  
}