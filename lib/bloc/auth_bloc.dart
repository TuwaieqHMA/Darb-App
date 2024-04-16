import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/driver_model.dart';
import 'package:darb_app/models/student_model.dart';
import 'package:darb_app/pages/driver_home.dart';
import 'package:darb_app/pages/student_home.dart';
import 'package:darb_app/pages/supervisor_home_page.dart';
import 'package:darb_app/pages/supervisor_naivgation_page.dart';
import 'package:darb_app/pages/welcome_page.dart';
import 'package:darb_app/services/database_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final dbService = DBService();
  final locator = GetIt.I.get<HomeData>();
  AuthBloc() : super(AuthInitial()) {
    on<SignUpEvent>(signup);
    on<LoginEvent>(login);
    on<SignOutEvent>(signout);
    on<RedirectEvent>(redirect);
  }

  FutureOr<void> signup(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    if (event.name.trim().isNotEmpty &&
        event.email.trim().isNotEmpty &&
        event.phone.trim().isNotEmpty &&
        event.password.trim().isNotEmpty &&
        event.rePassword.trim().isNotEmpty) {
      if (validator.email(event.email)) {
        if (RegExp(r'^05[0-9]{8}$').hasMatch(event.phone)) {
          if (event.password.length >= 6 && event.rePassword.length >= 6) {
            if (event.password == event.rePassword) {
              try{
              AuthResponse res = await dbService.signUp(
                  email: event.email, password: event.password);
              await dbService.addUser(DarbUser(id: res.user!.id ,name: event.name, email: event.email, phone: event.phone, userType: event.userType));
              if(event.userType == "Student"){
                await dbService.addStudent(Student(id: res.user!.id));
              }else if (event.userType == "Driver"){
                await dbService.addDriver(Driver(id: res.user!.id, supervisorId: locator.currentUser.id!));
              }
              emit(SignedUpState(msg: "تم إنشاء الحساب بنجاح الرجاء تأكيد حسابك عن طريق البريد المرسل لبريدك الإلكتروني"));
              } catch (e) {
                emit(AuthErrorState(msg: "هناك مشكلة في الإتصال بخدمتنا"));
                print(e);
              }
            }else {
              emit(AuthErrorState(msg: "كلمتا السر غير متطابقتين"));
            }
          } else {
            emit(AuthErrorState(msg: "كلمة السر يجب أن تكون من 6 فأكثر"));
          }
        } else {
          emit(AuthErrorState(msg: "الرجاء إدخال رقم هاتف صحيح"));
        }
      } else {
        emit(AuthErrorState(msg: "الرجاء إدخال بريد إلكتروني صحيح"));
      }
    } else {
      emit(AuthErrorState(msg: "الرجاء تعبئة جميع الحقول"));
    }
  }

  FutureOr<void> login(LoginEvent event, Emitter<AuthState> emit) async{
    emit(AuthLoadingState());

    if(event.email.trim().isNotEmpty && event.password.trim().isNotEmpty){
      if (validator.email(event.email)){
        try {
          await dbService.signIn(email: event.email, password: event.password);
        locator.currentUser = await dbService.getCurrentUserInfo();
        emit(LoggedInState(msg: "تم تسجيل الدخول بنجاح"));
        } catch (e) {
          emit(AuthErrorState(msg: "هناك خطأفي عملية تسجيل الدخول، الرجاء التحقق من تأكيد بريدك"));
          print(e);
        }
      } else {
        emit(AuthErrorState(msg: "الرجاء إدخال بريد إلكتروني صحيح"));
      }
    } else {
      emit(AuthErrorState(msg: "الرجاء تعبئة جميع الحقول"));
    }
  }

  FutureOr<void> signout(SignOutEvent event, Emitter<AuthState> emit) async{
    emit(AuthLoadingState());

    await dbService.signOut();
    emit(SignedOutState(msg: "تم تسجيل خروجك بنجاح"));
  }

  FutureOr<void> redirect(RedirectEvent event, Emitter<AuthState> emit) async{
    emit(AuthLoadingState());

    if(dbService.supabase.auth.currentSession != null) {
      locator.currentUser = await dbService.getCurrentUserInfo();
      Widget widget = const Placeholder(); 
      switch (locator.currentUser.userType) {
        case "Supervisor":
          widget = const SupervisorNavigationPage();
        case "Student":
          widget = const StudentHome();
        case "Driver":
          widget = const DriverHome();
        default:
          widget = const WelcomePage();
      }
      emit(RedirectedState(page: widget));
    }else {
      emit(RedirectedState(page: const WelcomePage()));
    }
  }
}
