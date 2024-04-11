
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
import 'TicketList.dart';
import 'package:flutter_svg/svg.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
class MainPage extends StatefulWidget {
   /*List <LoginModel> LoginModels;*/
   MainPage(/*this.LoginModels*/);

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
  @override
void initState() {

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final CurvedNavigationBarState? navBarState =
          _bottomNavigationKey.currentState;
      navBarState?.setPage(0); // Navigating to the second page
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF21899C),
        //elevation: 1,
        leading: Icon(Icons.sort,color: Colors.white),
        actions: [
          InkWell(
            onTap: () {

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
                               onPressed: ()  {


                                 Navigator.of(context).pushReplacement(
                                   MaterialPageRoute(builder: (context) => SignInFive()),
                                 );
                               },
                             )
                         ),
                       ],)
                      ],
                    );
                  });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.circular(50)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.logout,color: Colors.black),
                )),
          ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          /* Padding(
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
            ),*/
          if(_page==0)
          Container(

              width: size.width/1,
              height: size.height/1.2,
              child: TicketPage(TotalTicketCount))
          else if(_page==1)
          /*  Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 185),
              child: Center(
                child: Text("Create Ticket Page\n    Cooming Soon"
                    ,style:GoogleFonts.quicksand( fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,),),
              ),
            )*/
            /*Container(
              width: 400,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white,borderRadius:  BorderRadius.circular(20)),
              child: ExpansionTile(

                title: Text('Select Status',style: GoogleFonts.poppins(fontWeight: FontWeight.w700),),

                children: [
                  ListTile(
                    title: Text('This is tile number '),
                  ),
                ],

              ),
            )*/
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ExpansionTileCard(

                leading: const CircleAvatar(
                     backgroundColor: Colors.green,
                    child: Icon(Icons.check,color: Colors.white,)),
                title: Text('Closed', style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold, )),

                children: <Widget>[
                  Divider(
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child:  Column(
                          children: [

                            Row(
                              children: <Widget>[
                                Radio(
                                  value: 'Open',
                                  groupValue: _radioValue,
                                  onChanged: radioButtonChanges,
                                ),
                                Text(
                                  "Open",
                                    style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600, )
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Radio(
                                  value: 'Closed',
                                  groupValue: _radioValue,
                                  onChanged: radioButtonChanges,
                                ),
                                Text(
                                  "Closed",
                                    style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600, )
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Radio(
                                  value: 'Resolved',
                                  groupValue: _radioValue,
                                  onChanged: radioButtonChanges,
                                ),
                                Text(
                                  "Resolved",
                                    style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600, )
                                ),
                              ],
                            ),
                            Container(height: 10,),
                            Container(
                              alignment: Alignment.center,
                              height: size.height / 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color:  Colors.white,
                                boxShadow: [ BoxShadow(color: Colors.black12,blurRadius: 2)]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    //mail icon
                                    const Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),

                                    //divider svg
                                    SvgPicture.string(
                                      '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                      width: 1.0,
                                      height: 15.5,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),

                                    //email address textField
                                    Expanded(
                                      child: TextField(

                                        maxLines: 1,
                                        cursorColor: Colors.white70,
                                        keyboardType: TextInputType.emailAddress,
                                        style: TextStyle(   fontSize: 14.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,),
                                        decoration: InputDecoration(
                                            hintText: 'Enter your Name',

                                            hintStyle:TextStyle( fontSize: 14.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(height: 20,),
                            Container(
                              alignment: Alignment.center,
                              height: size.height / 13,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color(0xFFF56B3F),
                              ),
                              child: InkWell(
                                onTap: () {


                                  /* Navigator.pushReplacement(
    context, CupertinoPageRoute(builder: (_) =>  MainPage()));*/

                                },
                                child: Text(
                                    'Submit',
                                    style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold, fontSize:20)
                                ),
                              ),
                            )

                          ],
                        ),
                    ),
                  ),
                ],
              ),
            )
          else if(_page==2)
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 185),
                child: Center(
                  child: Text("     Profile Page\n    Cooming Soon"
                    ,style:GoogleFonts.quicksand( fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,),),
                ),
              ),

        ],
      ),
    ),

    ));
  }
  TotalTicketCount(var TicketData){
    setState(() {

      ToatalCount = TicketData.length;
    });
  }
}
