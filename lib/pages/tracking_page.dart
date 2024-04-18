import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/profile_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/appbar_home.dart';
import 'package:darb_app/widgets/bottom_button.dart';
import 'package:darb_app/widgets/circle_back_button.dart';
import 'package:darb_app/widgets/icon_text_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
          preferredSize: Size(context.getWidth(), context.getHeight() * .10),
          child: AppBarHome(
              tital: 'مرحباً، الاء', icon: const CircleBackButton())),
      body:  Center(
        child: Container(
        
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "صباح الخير !",
                style: TextStyle(
                  color: signatureBlueColor,
                  fontFamily: inukFont,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              height32,
              Container(
              height: context.getWidth() * 0.360,
               width:420,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: whiteColor,
                boxShadow: [
            BoxShadow(
              color: blackColor.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 4,
           
            ),
          ],),
          child: TextButton(onPressed: (){}, child:const Text('التحدث مع السائق',style: TextStyle(
                      color: Color(0xff928785),
                      decoration: TextDecoration.underline,
                    ),),)
          ),
           height32,
              SizedBox(
                
                child: Row(
                  children: [
                   Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/1BUS.png',
              height: 40,
            ),
            Image.asset('assets/images/Line 7.png'),
            Row(
              children:[Image.asset(
                'assets/images/Map_Pin.png',
                height: 20,
              ),Image.asset(
                'assets/images/2BUS.png',
                height: 35,
              ),], 
            ),
            Image.asset('assets/images/Line 7.png'),
            Image.asset(
              'assets/images/3BUS.png',
              height: 40,
            ),
                       ],
                    ),
                    width8,
                    const Column(children: [
                       ContainerTracking(text: "11:40 ص", color: signatureYellowColor, height: 40,),
                       height120,
                        ContainerTracking(text: "20 دقيقة", color:signatureTealColor, height: 80,),
                        height80,
                         ContainerTracking(text: "12:00 م", color: signatureYellowColor, height: 40,),                          
                            
                    ],)
                  ],
                ),
              ),
              height70,
             Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
        child: BottomButton(
          text: "  تتبع الباص ",
          onPressed: () {},
          textColor: whiteColor,
          fontSize: 24,
        
        ),
      ),
            ],
            
          ),
        ),
      ), 
      
      
    );
    
  }

}

class ContainerTracking extends StatelessWidget {
  const ContainerTracking({
    super.key, required this.text, required this.color, required this.height,
  });
final String text;
final Color color;
final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: context.getWidth() * 0.800,
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color:offWhiteColor,
        border:  Border(right: BorderSide(
          color: color,width: 6)) ),
          child:  Text(
                  "    $text",
                  style: const TextStyle(
                    color: signatureBlueColor,
                    fontFamily: inukFont,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),);
  }
}
