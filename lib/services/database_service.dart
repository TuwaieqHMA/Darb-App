import 'package:supabase_flutter/supabase_flutter.dart';

class DBService {
  final supabase = Supabase.instance.client;

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
}