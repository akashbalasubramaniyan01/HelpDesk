
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_animation/bottom_animation.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk/view/login.dart';
import 'package:helpdesk/view/signin.dart';
import '../model/LoginModel.dart';
import 'ChatScreen.dart';
import 'CreateTicket.dart';
import 'TicketHomepage.dart';
import 'TicketList.dart';
import 'package:flutter_svg/svg.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:aligned_dialog/aligned_dialog.dart';

import 'TicketSearchDetails.dart';
class MainPage extends StatefulWidget {
  int screenValue;
  final List<LoginModel> loginModels;
   MainPage(this.screenValue,{required this.loginModels});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _page = 0;

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  var items = <BottomNavItem>[
    BottomNavItem(

        title: 'Home',
        widget: SvgPicture.asset(
        "assets/movie-ticket-icon.svg",
        width: 24,
        height: 24,
        )),
    BottomNavItem(
        title: 'Ticket',
        widget: Image.asset('assets/movie-ticket-icon.svg',  width: 24,
          height: 24,)),
    BottomNavItem(
        title: 'Enquiry',
        widget: Image.asset('assets/how-to-icon.svg', width: 24,
          height: 24,)),
  ];

  int ToatalCount =0;
  DateTime currentBackPressTime = DateTime.now();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: 'Tap Again to Exit');
      return Future.value(false);
    }

    exit(0);
    return Future.value(true);
  }
  WidgetBuilder get _localDialogBuilder {
    return (BuildContext context) {
      return Stack(
        children: [
          Positioned(
            right: 20,
            top: 60,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(

                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 33)],
                    borderRadius: BorderRadius.all(Radius.circular(10),)),
                child: DefaultTextStyle(
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            GestureDetector(
                                onTap: () {

                                },
                                child: Text("Profile",style:GoogleFonts.poppins( fontSize: 15.0,
                                  color: MyColors.AppthemeColor,
                                  fontWeight: FontWeight.w800,))),

                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },child: Icon(CupertinoIcons.clear,size: 16,))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 4,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("hello2");
                            //Navigator.of(context).pop();
                          },
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(blurRadius: 33,color: Colors.black12)],
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.person,color: Colors.orange),
                                  )),
                              Container(width: 10,),
                              Text(widget.loginModels[0].name,style:GoogleFonts.poppins( fontSize: 14.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,),),
                            ],
                          ),),
                        SizedBox(
                          height: 3,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("hello2");
                            //Navigator.of(context).pop();
                          },
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(blurRadius: 33,color: Colors.black12)],
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.admin_panel_settings_outlined,color: Colors.orange),
                                  )),
                              Container(width: 10,),
                              Text(widget.loginModels[0].userRoll,style:GoogleFonts.poppins( fontSize: 14.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,),),
                            ],
                          ),),
                        SizedBox(
                          height: 3,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("hello2");
                            //Navigator.of(context).pop();
                          },
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(blurRadius: 33,color: Colors.black12)],
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.co_present_sharp,color: Colors.orange),
                                  )),
                              Container(width: 10,),
                              Text(widget.loginModels[0].company,style:GoogleFonts.poppins( fontSize: 14.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,),),
                            ],
                          ),),
                        SizedBox(
                          height: 6,
                        ),
                        GestureDetector(
                          onTap: () {

                            Navigator.of(context).pop();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                    contentPadding: EdgeInsets.all(0),
                                    elevation: 0,
                                    scrollable: true,
                                    backgroundColor: Colors.white,
                                    content: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Column(

                                          children: [
                                            Container(
                                              decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(32),topLeft: Radius.circular(32)), color: Colors.cyan,),

                                              width: 500,height: 180,
                                              child: Padding(
                                                padding: const EdgeInsets.all(20.0),
                                                child: Center(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all( color: Colors.white,width: 2),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(Icons.person,color: Colors.white,size: 65,),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 15,bottom: 15),
                                              child: Center(
                                                child: Text('Are you sure you want to logout',style: GoogleFonts.poppins(

                                                  color:
                                                  Colors.black,
                                                  fontSize:
                                                  14,
                                                  fontWeight: FontWeight.bold,
                                                ),),
                                              ),
                                            ),

                                          ],
                                        )
                                    ),
                                    actions: [

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width:80,
                                            margin: EdgeInsets.all(15),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(false);
                                              },
                                              child: Text('No',style: TextStyle(
                                                color:
                                                Colors.white,
                                                fontSize:
                                                14,
                                                fontFamily:
                                                'Proxima_Nova_Font',
                                                fontWeight: FontWeight.bold,
                                              ),),
                                              style:ButtonStyle(
                                                foregroundColor: MaterialStateProperty.all<Color>(Color(0xFFF56B3F)),
                                                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF56B3F)),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(

                                              alignment: Alignment.center,
                                              width:80,
                                              margin: EdgeInsets.all(15),
                                              child:   ElevatedButton(
                                                child: Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'Proxima_Nova_Font',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                style: ButtonStyle(
                                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                                    ),
                                                  ),
                                                ),
                                                onPressed: ()  async {

                                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                                  setState(() {
                                                    prefs.remove('UserName');
                                                    prefs.remove('PassWord');
                                                  });
                                                  Navigator.pushReplacement(
                                                    context,MaterialPageRoute(builder: (context) => SignInFive()),);


                                                },
                                              )
                                          ),
                                        ],)
                                    ],
                                  );
                                });
                          },
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(blurRadius: 33,color: Colors.black12)],
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.logout,color: Colors.orange),
                                  )),
                              Container(width: 10,),
                              Text("Sign Out",style:GoogleFonts.poppins( fontSize: 14.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,),),
                            ],
                          ),),
                        SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    };
  }
  var AllCompanyList ;
  @override
void initState() {

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final CurvedNavigationBarState? navBarState =
          _bottomNavigationKey.currentState;
      navBarState?.setPage(widget.screenValue); // Navigating to the second page
    });
    // TODO: implement initState
    super.initState();
  }

  late String _radioValue ="Open"; //Initial definition of radio button value
  late String choice;
   radioButtonChanges(String? value) {
    setState(() {
      _radioValue = value!;
      switch (value) {
        case 'Open':
          choice = value!;
          break;
        case 'Closed':
          choice = value!;
          break;
        case 'Resolved':
          choice = value!;
          break;
        default:
          choice = "";
      }
      debugPrint(choice); //Debug the choice in console
    });
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF21899C),
          //elevation: 1,
          leading: Icon(Icons.sort,color: Colors.white,size: 30,),
          actions: [
            InkWell(
              onTap: () {
                print("ggg");
      showAlignedDialog(
      context: context,
      builder: _localDialogBuilder,
      followerAnchor: Alignment.topRight,
      targetAnchor: Alignment.topRight,
      barrierColor: Colors.transparent);


              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.person,color: Colors.orange),
                  )),
            ),
            Container(width: 10,)
          ],
          title:  Center(
            child: Text.rich(
              TextSpan(
                style:TextStyle(  fontSize: 23.12,
                  color: Colors.white,
                  letterSpacing: 1.999999953855673,),
                children: const [
                  TextSpan(
                    text: 'I2',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextSpan(
                    text: '  HELP',
                    style: TextStyle(
                      color: Color(0xFFFE9879),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: const Color(0xFF21899C),
        bottomNavigationBar:  CurvedNavigationBar(
      key: _bottomNavigationKey,

      backgroundColor: Colors.white,
      buttonBackgroundColor: Color(0xFF21899C),
      color: Color(0xFF21899C),
      index: 0,
      height: 70,
      items: [
        SvgPicture.asset(
          "assets/home-icon.svg",
          width: 25,
          height: 25,
          color: Colors.white,
        ),
        SvgPicture.asset(
        "assets/movie-ticket-icon.svg",
        width: 25,
        height: 25,
          color: Colors.white,
        ),
        SvgPicture.asset(
          "assets/how-to-icon.svg",
          width: 25,
          height: 25,
          color: Colors.white,
        ),
      ],

      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      onTap: (index) {
      setState(() {
      _page = index;
      });
      },

      ),
      body:  Scaffold(
       // backgroundColor:   const Color(0xFF21899C),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          if(_page==0)
            Expanded(
              flex: 60,
              child: Container(

                  width: size.width/1,
                  height: size.height,
                  child: TicketHomePage(TicketCompanyCodeGet,widget.loginModels)),
            )
          else if(_page==1)
            Expanded(
              flex: 60,
              child: Container(
                  color: HexColor('FFFCFB'),

                  width: size.width/1,
                  height: size.height/1,
                  child: CreateTicket(widget.loginModels,AllCompanyList)),
            )
          else if(_page==2)
              Expanded(
                flex: 60,
                child: Container(
                    color: HexColor('FFFCFB'),
                    width: size.width/1,
                    height: size.height/1,
                    child: TicketSearch(TotalTicketCount,widget.loginModels)),
              )

        ],
      ),

      )),
    );
  }
  TicketCompanyCodeGet(var CompanyCodeDetails){
     setState(() {
       AllCompanyList = CompanyCodeDetails;
       print("AllCompanyList$AllCompanyList");
     });
  }

  TotalTicketCount(var TicketData){
    setState(() {

      ToatalCount = TicketData.length;
    });
  }
}
