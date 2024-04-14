

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:helpdesk/view/MainViewPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert' as convert;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:helpdesk/view/login.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';
import 'package:http_auth/http_auth.dart';

import '../model/LoginModel.dart';
import 'dart:io';
class TicketDeatils extends StatefulWidget {

  var AllTickets;
  int i;
  final VoidCallback onBack;
  final List<LoginModel> loginModels;
   TicketDeatils(this.AllTickets,this.i,this.loginModels,{required this.onBack});

  @override
  State<TicketDeatils> createState() => _TicketDeatilsState();
}

class _TicketDeatilsState extends State<TicketDeatils> {
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

  TextEditingController  Name  = TextEditingController();
  String AllertName ="";
  bool ActiveButton = false;
  late Timer _timer;
  @override
  void initState() {
    if(widget.AllTickets[widget.i]['Status']=="O") {
      _radioValue = "Open";
    }
    else  if(widget.AllTickets[widget.i]['Status']=="C"){
      _radioValue = "Closed";
    }
    else  if(widget.AllTickets[widget.i]['Status']=="R"){
      _radioValue = "Resolved";
    }
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF21899C),
        //elevation: 1,
        leading: InkWell(onTap: () {


          Navigator.of(context).pop();
        },child: Icon(Icons.arrow_back_ios,color: Colors.white)),

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
      body: Scaffold(
        backgroundColor: const Color(0xFF21899C),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,

                decoration: const BoxDecoration(color: Colors.white,boxShadow: [BoxShadow(blurRadius: 3,color: Colors.black12)]),
             child:  Padding(
               padding: const EdgeInsets.all(16),
               child: Center(
                 child: Text(
                   'Ticket Details ${widget.AllTickets[widget.i]['TicketNo']}',
                   style:  GoogleFonts.poppins(fontWeight: FontWeight.bold,color:Colors.cyan,fontSize:20),

                 ),
               ),
             ),
              ),
               Container(height: 5,),
                Container(
                  margin: EdgeInsets.all(10),
                 decoration:BoxDecoration(        borderRadius: BorderRadius.circular(10.0),
                     color:  Colors.white,
                     boxShadow: [ BoxShadow(color: Colors.black12,blurRadius: 2)]) ,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          mainAxisAlignment:
                          MainAxisAlignment
                              .start,
                          children: [
                            Padding(
                              padding: const EdgeInsets
                                  .only(
                                  top:
                                  10.0,
                                  left:
                                  10,right: 10,bottom: 10),
                              child: Row(
                                  children: [
                                    Icon(CupertinoIcons.tickets_fill,color:  Color(0xFF21899C),),
                                    Container(width: 10,),
                                    Container(
                                      width:
                                      100,
                                      child:
                                      Text(
                                        'Ticket No',
                                        style:  GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                      ),
                                    ),
                                    Container(

                                      child:
                                      Text.rich(
                                        TextSpan(
                                            children: [
                                              TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                              TextSpan(text: widget.AllTickets[widget.i]['TicketNo'], style: GoogleFonts.poppins(color: Colors.black,fontWeight:FontWeight.bold))
                                            ]),
                                      ),
                                    )
                                  ]),
                            ),



                          ],
                        ),
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          mainAxisAlignment:
                          MainAxisAlignment
                              .start,
                          children: [
                            Padding(
                              padding: const EdgeInsets
                                  .only(
                                  top:
                                  10.0,
                                  left:
                                  10,right: 10,bottom: 10),
                              child: Row(
                                  children: [
                                    Icon(CupertinoIcons.text_append,color:  Color(0xFF21899C),),
                                    Container(width: 10,),
                                    Container(
                                      width:
                                      100,
                                      child:
                                      Text(
                                        'Description',
                                        style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                      ),
                                    ),
                                    Container(

                                      child:
                                      Text.rich(
                                        TextSpan(
                                            children: [
                                              TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                              TextSpan(text: widget.AllTickets[widget.i]['ShortText'], style: GoogleFonts.poppins(color: Colors.black,fontWeight:FontWeight.bold))
                                            ]),
                                      ),
                                    )
                                  ]),
                            ),



                          ],
                        ),
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          mainAxisAlignment:
                          MainAxisAlignment
                              .start,
                          children: [
                            Padding(
                              padding: const EdgeInsets
                                  .only(
                                  top:
                                  10.0,
                                  left:
                                  10,right: 10,bottom: 10),
                              child: Row(
                                  children: [
                                    Icon(CupertinoIcons.today,color:  Color(0xFF21899C),),
                                    Container(width: 10,),
                                    Container(
                                      width:
                                      100,
                                      child:
                                      Text(
                                        'Create Date',
                                        style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                      ),
                                    ),
                                    Container(

                                      child:
                                      Text.rich(
                                        TextSpan(
                                            children: [
                                              TextSpan(text: ": ", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.black)),
                                              TextSpan(text: widget.AllTickets[widget.i]['DocDate'], style:GoogleFonts.poppins(color: Colors.black,fontWeight:FontWeight.bold))
                                            ]),
                                      ),
                                    )
                                  ]),
                            ),



                          ],
                        ),
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          mainAxisAlignment:
                          MainAxisAlignment
                              .start,
                          children: [
                            Padding(
                              padding: const EdgeInsets
                                  .only(
                                  top:
                                  10.0,
                                  left:
                                  10,right: 10,bottom: 10),
                              child: Row(
                                  children: [
                                    Icon(CupertinoIcons.create_solid,color:  Color(0xFF21899C),),
                                    Container(width: 10,),
                                    Container(
                                      width:
                                      100,
                                      child:
                                      Text(
                                        'Created By',
                                        style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                      ),
                                    ),
                                    Container(

                                      child:
                                      Text.rich(
                                        TextSpan(
                                            children: [
                                              TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                              TextSpan(text: widget.AllTickets[widget.i]['RaisedBy'], style: GoogleFonts.poppins(color: Colors.black,fontWeight:FontWeight.bold))
                                            ]),
                                      ),
                                    )
                                  ]),
                            ),



                          ],
                        ),

                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          mainAxisAlignment:
                          MainAxisAlignment
                              .start,
                          children: [
                            Padding(
                              padding: const EdgeInsets
                                  .only(
                                  top:
                                  10.0,
                                  left:
                                  10,right: 10,bottom: 10),
                              child: Row(
                                  children: [
                                    Icon(CupertinoIcons.music_albums,color:  Color(0xFF21899C),),
                                    Container(width: 10,),
                                    Container(
                                      width:
                                      100,
                                      child:
                                      Text(
                                        'Priority',
                                        style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                      ),
                                    ),
                                    Container(

                                      child:
                                      Text.rich(
                                        TextSpan(
                                            children: [
                                              TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                              TextSpan(text: widget.AllTickets[widget.i]['Priority'], style: GoogleFonts.poppins(color: Colors.black,fontWeight:FontWeight.bold))
                                            ]),
                                      ),
                                    )
                                  ]),
                            ),



                          ],
                        ),
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          mainAxisAlignment:
                          MainAxisAlignment
                              .start,
                          children: [
                            Padding(
                              padding: const EdgeInsets
                                  .only(
                                  top:
                                  10.0,
                                  left:
                                  10,right: 10,bottom: 10),
                              child: Row(
                                  children: [
                                    Icon(CupertinoIcons.checkmark_alt,color:  Color(0xFF21899C),),
                                    Container(width: 10,),
                                    Container(
                                      width:
                                      100,
                                      child:
                                      Text(
                                        'Status',
                                        style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                      ),
                                    ),
                                    Container(

                                      child:
                                      Text.rich(
                                        TextSpan(
                                            children: [
                                              TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                              TextSpan(text: widget.AllTickets[widget.i]['Status']=="O"?"Open":widget.AllTickets[widget.i]['Status']=="C"?"Closed":"Resolved", style:GoogleFonts.poppins(color: Colors.black,fontWeight:FontWeight.bold))
                                            ]),
                                      ),
                                    )
                                  ]),
                            ),



                          ],
                        ),
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          mainAxisAlignment:
                          MainAxisAlignment
                              .start,
                          children: [
                            Padding(
                              padding: const EdgeInsets
                                  .only(
                                  top:
                                  10.0,
                                  left:
                                  10,right: 10,bottom: 10),
                              child: Row(
                                  children: [
                                    Icon(CupertinoIcons.wand_rays,color:  Color(0xFF21899C),),
                                    Container(width: 10,),
                                    Container(
                                      width:
                                      100,
                                      child:
                                      Text(
                                        'Assigned To',
                                        style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                      ),
                                    ),
                                    Container(
                                      child:
                                      Text.rich(
                                        TextSpan(
                                            children: [
                                              TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                              TextSpan(text: widget.AllTickets[widget.i]['AssignedTo'], style: GoogleFonts.poppins(color: Colors.black,fontWeight:FontWeight.bold))
                                            ]),
                                      ),
                                    )
                                  ]),
                            ),



                          ],
                        ),
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          mainAxisAlignment:
                          MainAxisAlignment
                              .start,
                          children: [
                            Padding(
                              padding: const EdgeInsets
                                  .only(
                                  top:
                                  10.0,
                                  left:
                                  10,right: 10,bottom: 10),
                              child: Row(
                                  children: [
                                    Icon(CupertinoIcons.person,color:  Color(0xFF21899C),),
                                    Container(width: 10,),
                                    Container(
                                      width:
                                      100,
                                      child:
                                      Text(
                                        'Closed By',
                                        style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                      ),
                                    ),
                                    Container(

                                      child:
                                      Text.rich(
                                        TextSpan(
                                            children: [
                                              TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                              TextSpan(text: widget.AllTickets[widget.i]['ClosedBy'], style: GoogleFonts.poppins(color: Colors.black,fontWeight:FontWeight.bold))
                                            ]),
                                      ),
                                    )
                                  ]),
                            ),



                          ],
                        ),
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          mainAxisAlignment:
                          MainAxisAlignment
                              .start,
                          children: [
                            Padding(
                              padding: const EdgeInsets
                                  .only(
                                  top:
                                  10.0,
                                  left:
                                  10,right: 10,bottom: 10),
                              child: Row(
                                  children: [
                                    Icon(CupertinoIcons.map_pin_ellipse,color:  Color(0xFF21899C),),
                                    Container(width: 10,),
                                    Container(
                                      width:
                                      100,
                                      child:
                                      Text(
                                        'Closed On',
                                        style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                      ),
                                    ),
                                    Container(

                                      child:
                                      Text.rich(
                                        TextSpan(
                                            children: [
                                              TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                              TextSpan(text: widget.AllTickets[widget.i]['ClosedOn'], style:GoogleFonts.poppins(color: Colors.black,fontWeight:FontWeight.bold))
                                            ]),
                                      ),
                                    )
                                  ]),
                            ),



                          ],
                        ),
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          mainAxisAlignment:
                          MainAxisAlignment
                              .start,
                          children: [
                            Padding(
                              padding: const EdgeInsets
                                  .only(
                                  top:
                                  10.0,
                                  left:
                                  10,right: 10,bottom: 10),
                              child: Row(
                                  children: [
                                    Icon(CupertinoIcons.slash_circle_fill,color:  Color(0xFF21899C),),
                                    Container(width: 10,),
                                    Container(
                                      width:
                                      100,
                                      child:
                                      Text(
                                        'Department',
                                        style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                      ),
                                    ),
                                    Container(

                                      child:
                                      Text.rich(
                                        TextSpan(
                                            children: [
                                              TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                              TextSpan(text: widget.AllTickets[widget.i]['Department'], style: GoogleFonts.poppins(color: Colors.black,fontWeight:FontWeight.bold))
                                            ]),
                                      ),
                                    )
                                  ]),
                            ),



                          ],
                        ),

                      ],
                    )),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ExpansionTileCard(

                  leading:  CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(widget.AllTickets[widget.i]['Status']=="C"?Icons.check:widget.AllTickets[widget.i]['Status']=="O"?Icons.open_in_new_outlined:Icons.pending_actions_rounded,color: Colors.white,)),
                  title: Text(widget.AllTickets[widget.i]['Status']=="O"?'Open':widget.AllTickets[widget.i]['Status']=="C"?"Closed":"Resolved", style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold, )),

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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                        controller: Name,
                                        maxLines: 1,
                                        cursorColor: Colors.white70,
                                        keyboardType: TextInputType.emailAddress,
                                        style: TextStyle(   fontSize: 14.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,),
                                        onChanged: (value) {
                                          if(value.isNotEmpty){
                                            setState(() {
                                              AllertName ="";
                                            });
                                          }
                                        },
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
                            Container(height: 6,),
                            Text(
                                AllertName,
                                style: GoogleFonts.poppins(color: Colors.red,fontWeight: FontWeight.w600, )
                            ),
                            Container(height: 15,),
                            Container(
                              alignment: Alignment.center,
                              height: size.height / 13,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color(0xFFF56B3F),
                              ),
                              child: InkWell(
                                onTap: () {

                                   if(Name.text==""){
                                     setState(() {
                                       AllertName = "Enter the Your name";
                                     });
                                   }else {
                                     setState(() {
                                       ActiveButton = true;
                                     });

                                     StatusChangeApi(widget.AllTickets[widget
                                         .i]['TicketNo'], _radioValue,
                                         Name.text);

                                   }
                                  /* Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (_) =>  MainPage()));*/

                                },
                                child:ActiveButton==true?Center(child: new SpinKitFadingCircle(
                                  color: Colors.cyan,
                                  size: 30,
                                )): Text(
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
            ],
          ),
        ),
      ),
    );
  }
  StatusChangeApi(TicketNo, Status, Name) async {


    try {
      DigestAuthClient client = DigestAuthClient('ri2helpdeskuser', r'6i$qu@6e');
      var url = "${GlobalConfiguration().get("ApiURl")}apichangestatus";
      print(url);
      http.Response response = await client.put(
          Uri.parse(url),
          headers: {
            'x-api-key': 'bRuD5WYw5wd0rdHR9yLlM6wt2vteuiniQBqE70nA',
            'Content-Type': 'application/json',
            'Cookie': 'ci_session=691airnq2vc9vimljkp2j2fe6ml7bgfe'
          },
          body: json.encode({
            "ticketno": TicketNo,
            "status": Status,
            "name": Name
          })
      );


      print(response.statusCode);

      if (response.statusCode == 200) {
        final materialBanner = MaterialBanner(
          elevation: 2,
          backgroundColor: Colors.transparent,
          forceActionsBelow: false,
          content: AwesomeSnackbarContent(
            title: 'Success',
            message: 'Ticket Status has been Updated',
            contentType: ContentType.success,
            inMaterialBanner: true,
          ),
          actions: const [SizedBox.shrink()],
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showMaterialBanner(materialBanner);
        setState(() {
          print(response.body);
          var jsonResponse = json.decode(response.body);
           print(jsonResponse);

          widget.onBack();
          _timer = Timer.periodic(Duration(seconds: 2), (timer) {
            Navigator.pushReplacement(
                context, CupertinoPageRoute(builder: (_) => MainPage(0,loginModels: widget.loginModels,)));
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          });

        });
      } else if (response.statusCode == 302) {
        // Handle redirection
        var redirectUrl = response.headers['location'];
        print(redirectUrl);
        // You can choose to follow the redirect here by making another request to the new URL
        // For example:
        // http.Response redirectedResponse = await client.get(Uri.parse(redirectUrl));
        // Handle the redirected response as needed
      } else {
        // Handle other error cases
        final materialBanner = MaterialBanner(
          elevation: 2,
          backgroundColor: Colors.transparent,
          forceActionsBelow: false,
          content: AwesomeSnackbarContent(
            title: 'Failure',
            message: 'Username and Password invalid!!!',
            contentType: ContentType.failure,
            inMaterialBanner: true,
          ),
          actions: const [SizedBox.shrink()],
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showMaterialBanner(materialBanner);
      }

    } catch (e) {
      print(e);
    }
  }
  @override
  void dispose() {
    super.dispose();
    // Cancel the timer when the page is disposed
    _timer.cancel();
  }
}
