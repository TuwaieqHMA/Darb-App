import 'package:darb_app/bloc/student_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/location_select_page.dart';
import 'package:darb_app/pages/student_home.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RedirectLocationWidget extends StatelessWidget {
  const RedirectLocationWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentBloc(),
      child: Builder(
        builder: (context) {
          final studentBloc = context.read<StudentBloc>();
          studentBloc.add(CheckStudentLocationAvailabilityEvent());
          return Scaffold(
            body: BlocConsumer<StudentBloc, StudentState>(
              listener: (context, state) {
                if(state is UserSelectedLocationState){
                  context.push(const StudentHome(), false);
                }else if (state is UserNotSelectedLocationState){
                  context.showTopSnackBar(state.msg);
                  context.push(const LocationSelectPage(), false);
                }
              },
              builder: (context, state) {
                if(state is StudentLoadingState){
                  return Container(
                    width: context.getWidth(),
                    height: context.getHeight(),
                    color: offWhiteColor,
                    child: const Center(
                      child: CircularProgressIndicator(color: signatureYellowColor,),
                    ),
                  );
                }else {
                  return Container(
                    width: context.getWidth(),
                    height: context.getHeight(),
                    color: offWhiteColor,
                  );
                }
              },
            ),
          );
        }
      ),
    );
  }
}
