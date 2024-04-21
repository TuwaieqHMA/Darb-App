import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'attendance_list_event.dart';
part 'attendance_list_state.dart';

class AttendanceListBloc extends Bloc<AttendanceListEvent, AttendanceListState> {
  AttendanceListBloc() : super(AttendanceListInitial()) {
    on<AttendanceListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
