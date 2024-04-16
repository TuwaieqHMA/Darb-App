import 'package:darb_app/models/attendance_list_model.dart';
import 'package:darb_app/models/bus_model.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/driver_model.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/models/student_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DBService {
  final supabase = Supabase.instance.client;
  final List<DarbUser> students = [];
  final List<DarbUser> drivers = []; 
  final List<Driver> driverData = []; 
  final List<Bus> buses = []; 
  final List<Trip> trips = []; 
  final List<AttendanceList> attendanceList = [];

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

  // Get All basic user information
  Future getAllUser() async {
    final user = await supabase.from('User').select('*');
    for(var element in user){
      if(element['user_type'] == 'student'){
        students.add(DarbUser.fromJson(element));
        return students;
      }else if( element['user_type'] == 'driver'){
        drivers.add(DarbUser.fromJson(element));
        return drivers;
      }
    }
    print(students);
    print("student================================");
    print(drivers);
    print("drivers================================");
  }

   // Get Driver information
  Future getDriverData() async {
    final data = await supabase.from('Driver').select('*');
    for(var element in data){
      driverData.add(Driver.fromJson(element));
    }
    print(driverData);
    print("driver Data ================================");
    return driverData;
  }


  // Get Bus information
  Future getAllBuses() async {
    final bus = await supabase.from('Bus').select('*');
    for(var element in bus){
      buses.add(Bus.fromJson(element));
    }
    print(buses);
    print("users================================");
    return buses;
  }


  
  // Get trip information
  Future getAllTrip() async {
    final data = await supabase.from('Trip').select('*');
    for(var element in data){
      trips.add(Trip.fromJson(element));
    }
    print(trips);
    print("trips================================");
    return trips;
  }

  // Get Attendance information
  Future getAttendance() async {
    final data = await supabase.from('AttendanceList').select('*');
    for(var element in data){
      attendanceList.add(AttendanceList.fromJson(element));
    }
    print(attendanceList);
    print("AttendanceList================================");
    return attendanceList;
  }


  //  Add bus 
  Future addBus(Bus bus) async {
    final addBus = await supabase.from('Bus').insert({
      'seats_number' : bus.seatsNumber,
      'bus_plate' : bus.busPlate,
      'date_issue' : bus.dateIssue,
      'date_expire' : bus.dateExpire,
      'driver_id' : bus.driverId
    });
    print("Add Bus");
  }
  
  //  Add trip 
  Future addTrip(Trip trip) async {
    final addTrip = await supabase.from('Trip').insert({
      'isToSchool' : trip.isToSchool,
      'district' : trip.district,
      'date' : trip.date,
      'time_from' : trip.timeFrom,
      'time_to' : trip.timeTo
    });
    print("Add Trip");

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

  Future<void> sendOtp(String email) async{
    await supabase.auth.signInWithOtp(email: email);
  }

  Future<void> verifyOtp(String otp, String email) async{
    await supabase.auth.verifyOTP(type: OtpType.email, token: otp, email: email);
  }

  Future<void> changePassword(String password) async{
    await supabase.auth.updateUser(UserAttributes(password: password,),);
  }
  Future<void> resendOtp(String email) async {
    await sendOtp(email);
  }
}