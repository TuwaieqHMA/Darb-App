import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/driver_model.dart';
import 'package:darb_app/models/student_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DBService {
  final supabase = Supabase.instance.client;

  Future<AuthResponse> signUp({required String email, required String password}) async{
    return await supabase.auth.signUp(
      email: email,
      password: password);
  }

  Future signIn({required String email, required String password}) async{
    await supabase.auth.signInWithPassword(
      email: email,
      password: password);
  }

  Future signOut() async{
    await supabase.auth.signOut();
  }

  Future<Session?> getCurrentSession() async {
    return supabase.auth.currentSession;
  }

  Future<String> getCurrentUserId() async {
    return supabase.auth.currentUser!.id;
  }

  Future<DarbUser> getCurrentUserInfo() async {
    return DarbUser.fromJson(await supabase.from("User").select().match({"id": await getCurrentUserId()}).single());
  }

  Future<void> addUser(DarbUser user) async {
    await supabase.from("User").insert(user.toJson());
  }

  Future<void> addStudent(Student student) async {
    await supabase.from("Student").insert(student.toJson());
  }

  Future<void> addDriver(Driver driver) async {
    await supabase.from("Driver").insert(driver.toJson());
  }
}