import 'package:darb_app/models/attendance_list_model.dart';
import 'package:darb_app/models/bus_model.dart';
import 'package:darb_app/models/chat_model.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/driver_model.dart';
import 'package:darb_app/models/message_model.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/models/student_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DBService {
  final supabase = Supabase.instance.client;
   late Stream<List<Message>> listOfMessages; // Fetched Messages

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
 
  //------------------------------------------------------------
  // --------- Fetching user and session info Operations ------

  // Getting session data for routing
  Future getSessionData() async {
    final session = supabase.auth.currentSession;
    print("-------------------------------");
    print("Session Data $session");
    print("-------------------------------");
    return session;
  }

  // Getting current user ID
  Future getCurrentUserID() async {
    final currentUserId = supabase.auth.currentUser?.id;
    return currentUserId;
  }

  // Get messages stream
  Future getMessagesStream() async {
    final userID = await getCurrentUserID();
    final Stream<List<Message>> msgStream = supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map((messages) => messages
            .map((message) => Message.fromJson(json: message, myUserID: userID))
            .toList());
    listOfMessages = msgStream;
  }

  // Get chat stream (assuming 'chats' is the table name)
  Future getChatData(String chatID) async {
    final Stream<List<Chat>> chatStream = supabase
        .from('chats')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map((chats) => chats
            .map((chat) => Chat.fromJson(chat))
            .toList());
    return chatStream;
  }

  // Submit message
  Future submitMessage(String msgContent) async {
    final currentUserId = await getCurrentUserID();
    await supabase.from("messages").insert({
      'user_id': currentUserId,
      'message': msgContent,
    });
  }
}

//  Future getSessionData() async {
//     /**
//      This line pauses the execution of the function for a very 
//      short amount of time (zero seconds) before continuing.
//      it ensures that the widget tree is fully built before 
//      attempting to access the current user session.
//     */
//     // await Future.delayed(Duration.zero);
//     final session = supabase.auth.currentSession;
//     print("-------------------------------");
//     print("Session Data $session");
//     print("-------------------------------");
//     return session;
//   }

//   // -- Getting current user ID --
//   Future getCurrentUserID() async {
//     final currentUserId = supabase.auth.currentUser?.id;
//     return currentUserId;
//   }

//   // -- Get messages stream --
//   Future getMessagesStream() async {
//     final userID = await getCurrentUserID();
//     final Stream<List<Message>> msgStream = supabase
//         .from('messages')
//         .stream(primaryKey: ['id'])
//         .order('created_at')
//         .map((massages) => massages
//             .map((message) => Message.fromJson(json: message, myUserID: userID))
//             .toList());
//     listOfMessages = msgStream;
//   }


//   // --- Get Profile data by profile ID of a specific message ---
//   Future getProfileData(String profileID) async {
//     final data =
//         await supabase.from('profiles').select().eq('id', profileID).single();
//     final profile = Driver.fromJson(data);
//     return profile;
//   }

//   // -- Submit message --
//   Future submitMessage(String msgContent) async {
//     final currentUserId = await getCurrentUserID();
//     await supabase.from("messages").insert({
//       'profile_id': currentUserId,
//       'content': msgContent,
//     });
//   }
// }