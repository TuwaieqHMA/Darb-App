import 'dart:async';
import 'dart:io';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/models/attendance_list_model.dart';
import 'package:darb_app/models/bus_model.dart';
import 'package:darb_app/models/chat_model.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/driver_model.dart';
import 'package:darb_app/models/location_model.dart';
import 'package:darb_app/models/message_model.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/models/student_model.dart';
import 'package:darb_app/utils/enums.dart';
import 'package:darb_app/widgets/trip_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:geolocator/geolocator.dart';

class DBService {
  final supabase = Supabase.instance.client; // Fetched Messages
  final List<Driver> driverData = [];
  // final List<AttendanceList> attendanceList = [];

  final locator = GetIt.I.get<HomeData>();

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
    List<DarbUser> studentList = [];
    final std = await supabase.rpc('get_student_with_supervisor',);

    for (var element in std) {
      studentList.add(DarbUser.fromJson(element));
    }
    locator.students = studentList;
   
    // return studentList;

    ////////////////////////////////

    // final user =
    //     await supabase.from('User').select('*').eq('user_type', 'Student');
    // // print(user);
    // // locator.students.clear();
    // for (var element in user) {
    //   final stu = await supabase
    //       .from("Student")
    //       .select()
    //       .match({'supervisor_id': null});
    //   print(stu);
    //   print("stu===============================");
    //   //      //neq('supervisor_id', null ).match({'id': element['id'], });
    //   //      for(var e in stu){
    //   //       if(e['id'] == element['id']){

    //   locator.students.add(DarbUser.fromJson(element));
    //   //   }
    //   //  }
    // }
  }

  // Get Driver information
  Future<Driver> getDriverData(String driverId) async {
    print("pppppppppppppp");
    final data = await supabase.rpc('get_diver_info' , params: {'driverid': driverId}).single();
    Driver driverInfo = Driver.fromJson(data);
    locator.driverData = driverInfo;
    print(locator.driverData);
    print(locator.driverData.id);
    print('locator.driverData');
    return driverInfo;

    // final data = await supabase.from('Driver').select('*');

    // for (var element in data) {
    //   if (element['on-trips'] == 0) {
    //     if (locator.driverHasTrip.isEmpty) {
    //       locator.driverHasTrip.add(Driver.fromJson(element));
    //     }
    //     if (locator.driverHasTrip.any((driver) => driver.id == element['id'])) {
    //       locator.driverHasTrip.remove(Driver.fromJson(element));
    //     } else {
    //       locator.driverHasTrip.add(Driver.fromJson(element));
    //     }
    //   }
    //   if (element['has_bus'] == false) {
    //     if (locator.driverHasBus.isEmpty) {
    //       locator.driverHasBus.add(element['id']);
    //     }
    //     if (locator.driverHasBus.any((driver) => driver == element['id'])) {
    //       locator.driverHasBus.remove(element['id']);
    //     } else {
    //       locator.driverHasBus.add(element['id']);
    //     }
    //   }
    // }
    // await getDriversWithoutBus();
  }

  // Get driver does not has bus
  Future<List<DarbUser>> getDriversWithoutBus() async {
    List<DarbUser> busDriver = [];
    final driver = await supabase.rpc('fetch_driver_without_bus');
    for (var element in driver) {
      busDriver.add(DarbUser.fromJson(element));      
    }
    locator.driverHasBusList = busDriver;
    return busDriver;
  }
  
 
  Future getDriverBusName(String driverId) async {
    final data = await supabase.from("User").select().eq('id', driverId).single();

    locator.busDriverName = DarbUser.fromJson(data);
    print("locator.busDriverName  == database_service");
  }
  
   
  // Get driver has max trip
  Future getDriversWithoutTrip() async {
    List<DarbUser> tripDriver = [];
    final data = await supabase.rpc('fetch_available_driver_for_trip');
    for (var e in data) {
      tripDriver.add(DarbUser.fromJson(e));
    }
    locator.tripDrivers = tripDriver ;
  }

  // Search for driver
  Future<List<DarbUser>> searchForDriver(String driverName) async {
    List<DarbUser> searchDriver = [];
    final data = await supabase.from("User").select().match({'name' : driverName, 'user_type': "Driver" });
      for (var user in data) {
        searchDriver.add(DarbUser.fromJson(user));
      }
    return searchDriver;
  }

  // Search for student
  Future<List<DarbUser>> searchForStudent(String studentName) async {
    List<DarbUser> searchStudent = [];
    final data = await supabase.from("User").select().match({'name' : studentName, 'user_type': "Student" });
      for (var user in data) {
        searchStudent.add(DarbUser.fromJson(user));
      }
    return searchStudent;
  }

  // Search for bus
  Future<List<Bus>> searchForBus(int busNumber) async {
    List<Bus> searchBus = [];
    final data = await supabase.from("Bus").select().match({'id' : busNumber, });
      for (var user in data) {
        searchBus.add(Bus.fromJson(user));
      }
    return searchBus;
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
    await supabase.from("Student").update({'supervisor_id': null}).eq('id', studentIdd);
    await getAllUser();
  }

  // Delete Driver function
  Future deleteDriver(String driverId) async {
    await supabase.from("User").delete().eq('id', driverId);
    await supabase.from("Driver").delete().eq('id', driverId);
    await getAllDriver();
  }

  Future deleteTrip(String tripId, Driver driver,) async {
    await supabase.from("Trip").delete().eq('id', tripId);
    final int numTrip = driver.noTrips! - 1;
    await supabase.from("Driver").update({"no_trips": numTrip}).eq('id', driver.id);
    await getAllCurrentTrip();
    await getAllFutureTrip();
  }

  // Get Driver Data
  Future getOneDriverData(DarbUser user) async {
    // locator.driverData = null;//!
    final data = await supabase.from("Driver").select().eq('id', user.id!);
    for (var element in data) {
      locator.driverData = Driver.fromJson(element);      
    }
  }

  //Get trip Driver
  // Future getOneDriver(String id) async {
  //   final driver = await supabase.from('User').select('name').eq('id', id);
  //   for (var element in driver) {
  //     if (locator.tripDrivers.isEmpty) {
  //       locator.tripDrivers.add(DarbUser.fromJson(element));
  //     }
  //     for (var e in locator.tripDrivers) {
  //       if (e.id != element['id']) {
  //         locator.tripDrivers.add(DarbUser.fromJson(element));
  //       }
  //     }
  //   }
  // }

  // Get trip information
  Future getAllCurrentTrip() async {
    
    List<Trip> tripList = [];
    List<TripCard> tripCardList = [];
    List<Map<String, dynamic>> mapTriplist = await supabase.rpc('get_current_supervisor_trips', params: {'supervisor_id' : locator.currentUser.id!});
    // from("Trip").select().eq('supervisor_id', locator.currentUser.id!);
    if (mapTriplist.isNotEmpty) {
      for (Map<String, dynamic> tripMap in mapTriplist) {
        tripList.add(Trip.fromJson(tripMap));
      }
      for (Trip trip in tripList) {
        Driver driver;
        DarbUser driverData;
        int noOfPassengers = await supabase
            .rpc('get_trip_student_count', params: {'tripid': trip.id});
        final drivers = await supabase.from("User").select().eq('id', trip.driverId).single();
        final driverName = await supabase.from("Driver").select().eq('id', trip.driverId).single();
        driver = Driver.fromJson(driverName); //drivers['name'];
        driverData = DarbUser.fromJson(drivers);
        tripCardList.add(TripCard(
          trip: trip,
          driverName: driverData.name,
          driver: driver,
          noOfPassengers: noOfPassengers,
        ));
      }
    }
    locator.supervisorCurrentTrips = tripCardList;
    return tripCardList;
  



    // final data = await supabase.from('Trip').select('*');
    // locator.trips.clear();
    // locator.tripDriver.clear();
    // locator.numberOfSeat.clear();
    // for (var element in data) {
    //   // if (locator.trips.isEmpty) {
    //   locator.trips.add(Trip.fromJson(element));
    //   print(locator.trips.length);
    //   print("locator.trips.length ${locator.trips.length}");
    //   // for(var trip in locator.trips){
    //   final tripDrivers =
    //       await supabase.from("User").select().eq('id', element['driver_id']);
    //   print(locator.tripDriver);
    //   for (var e in tripDrivers) {
    //     if (locator.tripDriver.isEmpty) {
    //       locator.tripDriver.add(DarbUser.fromJson(e));
    //     }
    //     // for(int i = 0 ; i <= locator.numberOfSeat.length ; i++) {
    //     // for(var ee in locator.tripDriver) {
    //     //   if(e['driver_id'] != ee.id) {
    //     //     locator.tripDriver.add(DarbUser.fromJson(e));
    //     //   }
    //     // }
    //     // locator.tripDriver.add(DarbUser.fromJson(e));
    //     print(locator.tripDriver.length);
    //     print(locator.tripDriver);
    //   }
    //   final seat = await supabase.from("Bus").select().eq('driver_id',
    //       element['driver_id']); //'e5e8213b-fe05-4e7e-a19f-3ff4e2739776');
    //   for (var st in seat) {
    //     if (locator.numberOfSeat.isEmpty) {
    //       locator.numberOfSeat.add(Bus.fromJson(st));
    //     }
    //     // for(int i = 0 ; i <= locator.numberOfSeat.length ; i++) {
    //     for (var element in locator.numberOfSeat) {
    //       if (st['driver_id'] != element.driverId) {
    //         locator.numberOfSeat.add(Bus.fromJson(st));
    //       }
    //     }
    //     print(locator.numberOfSeat.length);
    //     print('locator.numberOfSeat.length');
    //     print(locator.numberOfSeat);
    //     // }
    //   }
    //   // }

    //   // for (var oneDriver in locator.drivers) {
    //   //   if (oneDriver.id == element['driver_id']) {
    //   //     locator.tripDriver.add(oneDriver);
    //   //   }
    //   // }
    //   // for (var bus in locator.buses) {
    //   //   if (bus.driverId == element['driver_id']) {
    //   //     locator.seatNumber.add(bus);
    //   //   }
    //   // }
    //   // }
    //   // for (var e in locator.trips) {
    //   //   if (e.id != element['id']) {
    //   //     locator.trips.add(Trip.fromJson(element));
    //   //     // for (var oneDriver in locator.drivers) {
    //   //     //   if (oneDriver.id == element['id']) {
    //   //     //     locator.tripDriver.add(oneDriver);
    //   //     //   }
    //   //     // }
    //   //   }
    //   // }
    // }
  }


   Future getAllFutureTrip() async {
    
    List<Trip> tripList = [];
    List<TripCard> tripCardList = [];
    List<Map<String, dynamic>> mapTriplist = await supabase.rpc('get_future_supervisor_trips', params: {'supervisor_id' : locator.currentUser.id!});
    // from("Trip").select().eq('supervisor_id', locator.currentUser.id!);
    if (mapTriplist.isNotEmpty) {
      for (Map<String, dynamic> tripMap in mapTriplist) {
        tripList.add(Trip.fromJson(tripMap));
      }
      for (Trip trip in tripList) {
        Driver driver;
        DarbUser driverData;
        int noOfPassengers = await supabase
            .rpc('get_trip_student_count', params: {'tripid': trip.id});
        final drivers = await supabase.from("User").select().eq('id', trip.driverId).single();
        final driverName = await supabase.from("Driver").select().eq('id', trip.driverId).single();
        driver = Driver.fromJson(driverName);
        driverData = DarbUser.fromJson(drivers);
        tripCardList.add(TripCard(
          trip: trip,
          driverName: driverData.name,
          driver: driver,
          noOfPassengers: noOfPassengers,
        ));
      }
    }
    locator.supervisorFutureTrips = tripCardList;
    return tripCardList;
  }



  //  Add bus
  Future addBus(Bus bus, String id) async {
    final addBus = await supabase.from('Bus').insert(bus.toJson());
    final updateDriver =
        await supabase.from('Driver').update({'has_bus': true}).eq('id', id);
    // await getDriverData(); //////!
  }

  //  Add trip
  Future addTrip(Trip trip, ) async {
    // final data = await getDriverData(trip.driverId);
    final addTrip = await supabase.from('Trip').insert(trip.toJson());
    
    await GetOneTrip(trip);
    // final int numberOfTrip = driver.noTrips! + 1;
    // final int numberOfTrip = data.noTrips! + 1;
    print('numberOfTrip');
    // final updateDriver = await supabase
    //     .from('Driver')
    //     .update({'no_trips': numberOfTrip}).eq('id', data.id);
  }
  
  Future updateTrip(Trip trip, ) async {
    await supabase.from("Trip").update({
      'isToSchool': trip.isToSchool, 
      'district': trip.district, 
      'date' : trip.date.toIso8601String(), 
      'time_from' : '${trip.timeFrom.hour}:${trip.timeFrom.minute}', 
      'time_to' : '${trip.timeTo.hour}:${trip.timeTo.minute}', 
      'driver_id': trip.driverId}).eq('id', trip.id!);
    await getAllCurrentTrip();
    await getAllFutureTrip();
  }

  Future GetOneTrip(Trip trip) async {
    Trip tripData ; 
    final data = await supabase.from("Trip").select('id').match({
      'isToSchool': trip.isToSchool, 
      'district': trip.district, 
      'date' : trip.date.toIso8601String(), 
      'time_from' : '${trip.timeFrom.hour}:${trip.timeFrom.minute}', 
      'time_to' : '${trip.timeTo.hour}:${trip.timeTo.minute}', 
      'driver_id': trip.driverId,
    }).single();
    trip = Trip.fromJson(data);

    for (var element in locator.students) {      
      await supabase.from("AttendanceList").insert({
        "trip_id" : trip.id!,
        "student_id": element.id!, 
        "status" : "حضور مؤكد",
      });
    }

  }




  // ------ Add Student -- Connect Student By Supervisor -------------
  // Search for student to connect specific supervisor
  Future SearchForStudentById(String studentId) async {
    List<DarbUser> students = [];
    List<dynamic> std = await supabase.rpc('get_student_without_supervisor',);
    List<Student> studentList = [];
    for (var element in std) {
      studentList.add(Student.fromJson(element));
    }
    for (var element in studentList) {
      if ((element.id!.substring(30, 36)) == studentId) {
        final dataStudent =
            await supabase.from("User").select().eq('id', element.id!).single();

        students.add(DarbUser.fromJson(dataStudent));
      }
    }
    return students;
  }


  // Connect Student to Supervisor
  Future AddStudentToSupervisor(DarbUser student) async {
    if (student.id!.isNotEmpty) {
      return await supabase.rpc('add_student_to_supervisor_by_id', params: {
        'studentid': student.id,
        'supervisorid': locator.currentUser.id
      });
    }
  }

  Future updateStudent(String studentId, String name, String phone) async {
    await supabase
        .from('User')
        .update({'name': name, 'phone': phone}).eq('id', studentId);
    await getAllUser();
  }

  Future updateDriver(String driverId, String name, String phone) async {
    await supabase
        .from('User')
        .update({'name': name, 'phone': phone}).eq('id', driverId);
    await getAllDriver();
  }
 
  Future updateBus(Bus bus,) async {
    await supabase
        .from('Bus')
        .update({'seats_number': bus.seatsNumber, 'bus_plate': bus.busPlate, 'date_issue' : bus.dateIssue.toIso8601String(), 'date_expire' : bus.dateExpire.toIso8601String(), 'driver_id': bus.driverId}).eq('id', bus.id!);
    final updateDriver =
        await supabase.from('Driver').update({'has_bus': true}).eq('id', bus.driverId);
    await getAllBuses();
  }



  //---------------Auth Actions---------------

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

  Future<void> sendOtp(String email) async {
    await supabase.auth.signInWithOtp(email: email);
  }

  Future<void> verifyOtp(String otp, String email) async {
    await supabase.auth
        .verifyOTP(type: OtpType.email, token: otp, email: email);
  }

  Future<void> changePassword(String password) async {
    await supabase.auth.updateUser(
      UserAttributes(
        password: password,
      ),
    );
  }

  Future<void> resendOtp(String email) async {
    await sendOtp(email);
  }

  Future<void> updateUserInfo(String name, String phone) async {
    await supabase.from("User").update({'name': name, 'phone': phone}).eq(
        'id', await getCurrentUserId());
  }

  Future<void> uploadImage(File file) async {
    await supabase.storage
        .from("user_images")
        .upload(locator.currentUser.id!, file);
  }

  Future<void> updateImage(File file) async {
    await supabase.storage
        .from("user_images")
        .update(locator.currentUser.id!, file);
  }

  void getCurrentUserImage() {
    locator.currentUserImage = supabase.storage
        .from("user_images")
        .getPublicUrl(locator.currentUser.id!);
  }

  //------------------------------------------------------------
  // --------- Fetching user and session info Operations ------
 //final SupabaseClient _client;

 

  // Future<void> createChat(Chat chat) async {
  //   final response = await supabase.from('chats').upsert(chat.toJson()).();
  //   if (response.error != null) {
  //     throw Exception('Failed to create chat: ${response.error!.message}');
  //   }
  // }

  // Future<void> sendMessage(Message message) async {
  //   final response = await supabase.from('messages').upsert(message.toJson()).execute();
  //   if (response.error != null) {
  //     throw Exception('Failed to send message: ${response.error!.message}');
  //   }
  // }

  // Future<List<Message>> getMessagesForChat(int chatId) async {
  //   final response = await supabase
  //       .from('messages')
  //       .select()
  //       .eq('chat_id', chatId)
  //       .order('created_at', ascending: true)
  //       .select();

  //   if (response.error != null) {
  //     throw Exception('Failed to fetch messages: ${response.error!.message}');
  //   }

  //   return (response.data as List<dynamic>)
  //       .map((e) => Message.fromJson(e as Map<String, dynamic>, json: {}, myUserID: ''))
  //       .toList();
  // }
 // Getting session data for routing
  // Future getSessionData() async {
  //   final session = supabase.auth.currentSession;
  //   print("-------------------------------");
  //   print("Session Data $session");
  //   print("-------------------------------");
  //   return session;
  // }

 // Getting current user ID
  Future getCurrentUserID() async {
    final currentUserId = supabase.auth.currentUser?.id;
    return currentUserId;
  }

  // Get messages stream
  Stream<List<Message>> getMessagesStream(int chatId) {
    final Stream<List<Message>> msgStream = supabase
        .from('Message')
        .stream(primaryKey: ["id"])
        .eq('chat_id', chatId)
        .order('created_at')
        .map((messages) => messages
            .map((message) => Message.fromJson(json: message,myUserID: locator.currentUser.id!))
            // Message.fromJson(json: message, myUserID: userID))
            
            .toList());
    return msgStream;
  }

  // Get chat stream 
 Future<Chat> getChatData(int chatId)async {
    final Chat chat = Chat.fromJson(await supabase
        .from('Chat')
        .select()
        .eq("id", chatId)
        .single());
    return chat;
  }

  // Submit message
  Future submitMessage(String msgContent, int chatId) async {
    await supabase.from("Message").insert({
      'user_id': locator.currentUser.id,
      'message': msgContent,
      'chat_id': chatId,
    });
  }

    Future<List<Map<String, dynamic>>> checkChat(String driverId ,String studentId) async{
    List<Map<String, dynamic>> chatIdList = await supabase.from("Chat")
    .select('id')
    .match({
      'driver_id': driverId,
      'student_id': studentId,
    });
    return chatIdList;
  }

  Future createChat(String driverId ,String studentId) async{
    await supabase.from('Chat')
    .insert(Chat(driverId: driverId, studentId: studentId).toJson());
  }


  //---------------------------Student Actions---------------------------
  Future<Student> getStudentInfo() async {
    return Student.fromJson(await supabase
        .from("Student")
        .select()
        .eq('id', await getCurrentUserId())
        .single());
  }

  Future<void> updateUserLocation(LatLng coordinates) async {
    await supabase.from("Student").update({
      'latitude': coordinates.latitude,
      'longitude': coordinates.longitude
    }).eq('id', await getCurrentUserId());
  }

  Future<List<TripCard>> getAllStudentTrips() async {
    List<Trip> tripList = [];
    List<TripCard> tripCardList = [];
    List<Map<String, dynamic>> mapTriplist = await supabase.rpc(
        'get_student_trips',
        params: {'studentid': locator.currentUser.id});
    if (mapTriplist.isNotEmpty) {
      for (Map<String, dynamic> tripMap in mapTriplist) {
        tripList.add(Trip.fromJson(tripMap));
      }
      for (Trip trip in tripList) {
        String driverName = "";
        int noOfPassengers = await supabase
            .rpc('get_trip_student_count', params: {'tripid': trip.id});
        Map<String, dynamic> driverNameMap = await supabase
            .from("User")
            .select('name')
            .eq('id', trip.driverId)
            .single();
        driverName = driverNameMap['name'];
        tripCardList.add(TripCard(
          trip: trip,
          driverName: driverName,
          noOfPassengers: noOfPassengers,
        ));
      }
    }
    return tripCardList;
  }
  //---------------------------Driver Actions---------------------------
  Future<List<TripCard>> getAllDriverTrips() async {
    List<Trip> tripList = [];
    List<TripCard> tripCardList = [];
    List<Map<String, dynamic>> mapTriplist = await supabase.from("Trip").select().eq('driver_id', locator.currentUser.id!).order('date',);
    if(mapTriplist.isNotEmpty){
      for (Map<String, dynamic> tripMap in mapTriplist){
        tripList.add(Trip.fromJson(tripMap));
      }
      for(Trip trip in tripList){
        int noOfPassengers = await supabase.rpc('get_trip_student_count', params: {'tripid': trip.id});
        tripCardList.add(TripCard(trip: trip, driverName: locator.currentUser.name, noOfPassengers: noOfPassengers,));
      }
    }
    return tripCardList;
  }
  //---------------------------Trip Actions---------------------------
  Future<DarbUser> getDriverUserInfo(String driverId) async{
    return DarbUser.fromJson(await supabase
        .from("User")
        .select()
        .match({"id": driverId}).single());

  }

  Future<AttendanceList> getStudentAttendanceStatus(int tripId) async {
    return AttendanceList.fromJson(await supabase.from("AttendanceList").select().match({
      'trip_id': tripId,
      'student_id': locator.currentUser.id
    }).single());
  }

  Future<AttendanceStatus> changeAttendanceStatus(int tripId, AttendanceStatus currentStatus, String? studentId) async {
    if(currentStatus == AttendanceStatus.absent && studentId == null){
      await supabase.from("AttendanceList").update({'status': "حضور مؤكد"}).match({
      'trip_id': tripId,
      'student_id': locator.currentUser.id
    });
      return AttendanceStatus.assueredPrecense;
    }else if (currentStatus == AttendanceStatus.assueredPrecense && studentId != null){
      await supabase.from("AttendanceList").update({'status': "حاضر"}).match({
      'trip_id': tripId,
      'student_id': studentId
    });
      return AttendanceStatus.absent;
    }else {
      await supabase.from("AttendanceList").update({'status': "غائب"}).match({
      'trip_id': tripId,
      'student_id': studentId
    });
    return AttendanceStatus.absent;
    }
  }

  //---------------------------AttendanceList Actions---------------------------

  Stream<List<AttendanceList>> getAttendanceList(int tripId) {
    final Stream<List<AttendanceList>> attendanceListStream = supabase
    .from("AttendanceList")
    .stream(primaryKey: ['trip_id'])
    .eq('trip_id', tripId)
    .order('student_id')
    .map((records) => records
    .map((record) => AttendanceList.fromJson(record)).toList());
    return attendanceListStream;
  }

  Future<List<DarbUser>> getTripStudentList(int tripId) async{
    List<DarbUser> studentList = [];
    final List<dynamic> studentListMap = await supabase.rpc('get_trip_student_list', params: {'tripid': tripId}).order('id');

    for (Map<String, dynamic> student in studentListMap){
      studentList.add(DarbUser.fromJson(student));
    }
    return studentList;
  }

  // Future<Location?> checkDriverLocationExist() async{
  //   Map<String, dynamic> locationMap = await supabase.from("Location").select().eq('user_id', locator.currentUser.id!).single();
  //   if(locationMap.isNotEmpty){
  //     return Location.fromJson(locationMap);
  //   }else {
  //     await StreamSubscription<Position> positionStream = Geolocator.getPositionStream();
  //     await supabase.from("Location").insert(Location(userId: locator.currentUser.id!, latitude: latitude, longitude: longitude).toJson());
  //   }
  // }

}
