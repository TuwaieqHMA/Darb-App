import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/bus_card.dart';
import 'package:darb_app/widgets/custom_search_bar.dart';
import 'package:darb_app/widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

// ignore: must_be_immutable
class BusListPage extends StatelessWidget {
  BusListPage({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SupervisorActionsBloc>();
    bloc.add(GetAllBus());

    final locator = GetIt.I.get<HomeData>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.getWidth(), context.getHeight() * .19),
        child: PageAppBar(
          backgroundColor: signatureBlueColor,
          textColor: whiteColor,
          title: "قائمة الباصات",
          bottom: PreferredSize(
            preferredSize: Size(context.getWidth(), 72),
            child: Container(
              width: context.getWidth(),
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: offWhiteColor,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(color: shadowColor, blurRadius: 4, offset: const Offset(0, 4))
                ]
              ),
              child: CustomSearchBar(controller: searchController, hintText: "ابحث عن باص...",),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32,),
        children: [
            BlocBuilder<SupervisorActionsBloc, SupervisorActionsState>(
              builder: (context, state) {
            if (state is LoadingState) {
              return SizedBox(
                width: context.getWidth(),
                height: context.getHeight(),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: signatureYellowColor,
                  ),
                ),
              );
            }
            if (state is GetAllBusState) {
              print(locator.buses.length);
              print('DBService().drivers.length');
              if (locator.buses.isNotEmpty) {
                return ListView.builder(
                    // scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: locator.buses.length,
                    itemBuilder: (context, index) {
                      return           
                      BusCard(
                        bus: locator.buses[index],
                        busId: locator.buses[index].id! , 
                        busPlate: locator.buses[index].busPlate, 
                        startDate: locator.buses[index].dateIssue, 
                        endDate: locator.buses[index].dateExpire,);

                    });
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  height32,
                  Image.asset("assets/images/bus_vector.png"),
                  height24,
                  const Text(
                    "لا توجد باصات مضافة حالياً",
                    style: TextStyle(fontSize: 16, color: signatureBlueColor),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          }),
        
          // BusCard(busId: 1, busPlate: "ك م م - 1221", startDate: DateTime.now(), endDate: DateTime.now().add(const Duration(days: 365)),),
         // BusCard(busId: 4, busPlate: "ك م م - 1221", startDate: DateTime.now(), endDate: DateTime.now().add(const Duration(days: 365)),),
        ],
      ),
    );
  }
}

