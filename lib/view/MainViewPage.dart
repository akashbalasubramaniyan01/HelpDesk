
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_animation/bottom_animation.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/LoginModel.dart';
import 'TicketList.dart';
import 'package:flutter_svg/svg.dart';
class MainPage extends StatefulWidget {
   List <LoginModel> LoginModels;
   MainPage(this.LoginModels);

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
  var cIndex;
  @override
void initState() {
    cIndex = 0;
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF21899C),
        //elevation: 1,
        leading: Icon(Icons.sort,color: Colors.white),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.circular(50)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.people,color: Colors.black),
              )),
          Container(width: 10,)
        ],
        title:  Text.rich(
          TextSpan(
            style:TextStyle(  fontSize: 23.12,
              color: Colors.white,
              letterSpacing: 1.999999953855673,),
            children: const [
              TextSpan(
                text: 'HELP',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(
                text: ' DESK',
                style: TextStyle(
                  color: Color(0xFFFE9879),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
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
      backgroundColor:   const Color(0xFF21899C),
    body: SingleChildScrollView(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15,top: 10),
            child: Text.rich(
              TextSpan(
                style:TextStyle(  fontSize: 23.12,
                  color: Colors.white,
                  letterSpacing: 1.999999953855673,),
                children:  [
                  TextSpan(
                    text: 'Hello\n',
                      style: GoogleFonts.quicksand(textStyle: Theme.of(context).textTheme.bodyLarge)
                  ),
                  TextSpan(
                    text: widget.LoginModels[0].name,
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          TicketPage()
        ],
      ),
    ),

    ));
  }
}
