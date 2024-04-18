import 'dart:async';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/models/attendance_list_model.dart';
import 'package:darb_app/models/bus_model.dart';
import 'package:darb_app/models/chat_model.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/driver_model.dart';
import 'package:darb_app/models/message_model.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/models/student_model.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DBService {
  final supabase = Supabase.instance.client;
  late Stream<List<Message>> listOfMessages; // Fetched Messages
  final List<Driver> driverData = [];
  final List<AttendanceList> attendanceList = [];
  
  final locator = GetIt.I.get<HomeData>();

  Future<AuthResponse> signUp(
      {required String email, required String password}) async {
    return await supabase.auth.signUp(email: email, password: password);
  }

  Future signIn({required String email, required String password}) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future signOut() async {
    await supabase.auth.signOut();
  }

  Future<Session?> getCurrentSession() async {
    return supabase.auth.currentSession;
  }

  Future<String> getCurrentUserId() async {
    return supabase.auth.currentUser!.id;
  }

  // Get All basic user information
  Future getAllDriver() async {
    final driver =
        await supabase.from("User").select('*').eq('user_type', 'Driver');
    locator.drivers.clear();
    for (var element in driver) {
      locator.drivers.add(DarbUser.fromJson(element));
    }
  }

  // Get All basic user information
  Future getAllUser() async {
    final user =
        await supabase.from('User').select('*').eq('user_type', 'Student');
    // print(user);
    locator.students.clear();
    for (var element in user) {
      locator.students.add(DarbUser.fromJson(element));
    }
  }

  // Get Driver information
  Future getDriverData() async {
    final data = await supabase.from('Driver').select('*');

    for (var element in data) {
      if (element['on-trips'] == 0) {
        if (locator.driverHasTrip.isEmpty) {
          locator.driverHasTrip.add(Driver.fromJson(element));
        }
        if (locator.driverHasTrip.any((driver) => driver.id == element['id'])) {
          locator.driverHasTrip.remove(Driver.fromJson(element));
        } else {
          locator.driverHasTrip.add(Driver.fromJson(element));
        }
      }
      if (element['has_bus'] == false) {
        if (locator.driverHasBus.isEmpty) {
          locator.driverHasBus.add(element['id']);
        }
        if (locator.driverHasBus.any((driver) => driver == element['id'])) {
          locator.driverHasBus.remove(element['id']);
        } else {
          locator.driverHasBus.add(element['id']);
        }
      }
    }
    await getDriversWithoutBus();
  }

  // Get driver does not has bus
  Future getDriversWithoutBus() async {
    final data = await supabase.from('Driver').select('*').eq('has_bus', false);

    for (var e in data) {
      final withoutBus = await supabase.from('User').select().eq('id', e['id']);
      for (var driver in withoutBus) {
        locator.driverHasBusList.add(DarbUser.fromJson(driver));
      }
    }
  }

  // Get driver has 2 trip
  Future getDriversWithoutTrip() async {
    final data = await supabase.from('Driver').select('*').neq('no_trip', 10);
    for (var e in data) {
      final withoutBus = await supabase.from('User').select().eq('id', e['id']);
      for (var driver in withoutBus) {
        locator.driverHasBusList.add(DarbUser.fromJson(driver));
      }
    }
  }

  // Get Bus information
  Future getAllBuses() async {
    final bus = await supabase.from('Bus').select('*');
    locator.buses.clear();
    for (var element in bus) {
      locator.buses.add(Bus.fromJson(element));
    }
  }

  // Delete bus function
  Future deleteBus(String busId, String driverId) async {
    await supabase.from("Bus").delete().eq('id', busId);
    final updateDriver = await supabase
        .from('Driver')
        .update({'has_bus': false}).eq('id', driverId);
    await getAllBuses();
  }

  // Delete student function
  Future deleteStudent(String studentIdd) async {
    await supabase.from("User").delete().eq('id', studentIdd);
    await supabase.from("Student").delete().eq('id', studentIdd);
    await getAllUser();
  }

  // Delete Driver function
  Future deleteDriver(String driverId) async {
    await supabase.from("User").delete().eq('id', driverId);
    await supabase.from("Driver").delete().eq('id', driverId);
    await getAllDriver();
  }

  Future deleteTrip(String tripId, Driver driver) async {
    await supabase.from("Trip").delete().eq('id', tripId);
    final int numTrip = driver.noTrips! + 1;
    await supabase
        .from("Driver")
        .update({"no_trips": numTrip}).eq('id', driver.id);
    // await supabase.from("AttendanceList").delete().eq('trip_id', tripId); //! when we have AttendanceList data
    await getAllTrip();
  }

  //Get trip Driver
  Future getOneDriver(String id) async {
    final driver = await supabase.from('User').select('name').eq('id', id);
    for (var element in driver) {
      if (locator.tripDriver.isEmpty) {
        locator.tripDriver.add(DarbUser.fromJson(element));
      }
      for (var e in locator.tripDriver) {
        if (e.id != element['id']) {
          locator.tripDriver.add(DarbUser.fromJson(element));
        }
      }
    }
  }

  // Get trip information
  Future getAllTrip() async {
    final data = await supabase.from('Trip').select('*');
    for (var element in data) {
      if (locator.trips.isEmpty) {
        locator.trips.add(Trip.fromJson(element));

        for (var oneDriver in locator.drivers) {
          if (oneDriver.id == element['driver_id']) {
            locator.tripDriver.add(oneDriver);
          }
        }
        for (var bus in locator.buses) {
          if (bus.driverId == element['driver_id']) {
            locator.seatNumber.add(bus);
          }
        }
      }
      for (var e in locator.trips) {
        if (e.id != element['id']) {
          locator.trips.add(Trip.fromJson(element));
          for (var oneDriver in locator.drivers) {
            if (oneDriver.id == element['id']) {
              locator.tripDriver.add(oneDriver);
            }
          }
        }
      }
    }
  }

  // Get Attendance information
  Future getAttendance() async {
    final data = await supabase.from('AttendanceList').select('*');
    for (var element in data) {
      attendanceList.add(AttendanceList.fromJson(element));
    }
    return attendanceList;
  }

  //  Add bus
  Future addBus(Bus bus, String id) async {
    final addBus = await supabase.from('Bus').insert(bus.toJson());
    final updateDriver =
        await supabase.from('Driver').update({'has_bus': true}).eq('id', id);
    await getDriverData();
  }

  //  Add trip
  Future addTrip(Trip trip, Driver driver) async {
    final addTrip = await supabase.from('Trip').insert(trip.toJson());
    final int numberOfTrip = driver.noTrips! + 1;
    // print("tooototot $numberOfTrip");
    // print("toeeeeeeeeeeeeee ${driver.noTrips}");

    // print(driver.id);
    // print(driver.id.runtimeType);
    final updateDriver = await supabase
        .from('Driver')
        .update({'no_trips': numberOfTrip}).eq('id', driver.id);
    // print("Add Trip");
    // print("update driver=========");
    await getDriverData();
    // print("update driver");
  }

  Future updateStudent(String studentId, String name, String phone) async {
    await supabase
        .from('User')
        .update({'name': name, 'phone': phone}).eq('id', studentId);
    await getAllUser();
  }

  Future<DarbUser> getCurrentUserInfo() async {
    return DarbUser.fromJson(await supabase
        .from("User")
        .select()
        .match({"id": await getCurrentUserId()}).single());
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
  Future<void> updateUserInfo(String name, String phone) async {
    await supabase.from("User").update({'name': name, 'phone': phone}).eq('id', await getCurrentUserId());
  }
  //---------------------------Student Actions---------------------------
  Future<Student> getStudentInfo() async {
    return Student.fromJson(await supabase.from("Student").select('latitude, longitude').eq('id', await getCurrentUserId()).single());
  }

  Future<void> updateUserLocation(LatLng coordinates) async {
    await supabase.from("Student").update({'latitude': coordinates.latitude, 'longitude': coordinates.longitude}).eq('id', await getCurrentUserId());
  }
}
