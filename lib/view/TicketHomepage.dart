

import 'dart:convert';
import 'dart:ui';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http_auth/http_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../model/LoginModel.dart';
import 'TicketDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/model/LoginModel.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:countup/countup.dart';
import 'TicketList.dart';
class TicketHomePage extends StatefulWidget {
var TicketCompanyCodeGet;
  final List<LoginModel> loginModels;
   TicketHomePage(this.TicketCompanyCodeGet,this.loginModels);

  @override
  State<TicketHomePage> createState() => _TicketHomePageState();
}

class _TicketHomePageState extends State<TicketHomePage> {
var AllTickets=[];
int ToatalCount = 0;
int OpenCount = 0;
int PendingCount = 0;
int ClosedCount = 0;
  RaedAllTickets( UserRoll) async {
    setState(() {
      //ActiveScreen=true;
    });
    var client = DigestAuthClient('ri2helpdeskuser', r'6i$qu@6e');

    var response = await client.put(Uri.parse('${GlobalConfiguration().get("ApiURl")}apihelpdesk'),headers: {
      'x-api-key': 'bRuD5WYw5wd0rdHR9yLlM6wt2vteuiniQBqE70nA',
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=3gnid18nsvll4u99839vfroba1ihd58t; csrfcookiei2help=4912ec8965916cc488eeb6aa70918fa7'
    },

        body: json.encode({
          "Company": UserRoll!="ADMIN"?widget.loginModels[0].company:null,

        })
    );


    if (response.statusCode == 200) {
      setState(() {
        AllTickets.clear();
        print( response.body);
        var jsonResponse = json.decode(response.body);
        var JsonData = jsonResponse['data'];
        AllTickets.addAll(JsonData);
        ToatalCount = AllTickets.length;
        OpenCount =  AllTickets.where((element) => element['Status']=="O").length;
        ClosedCount =  AllTickets.where((element) => element['Status']=="C").length;
        PendingCount =  AllTickets.where((element) => element['Status']=="R").length;

      });
      widget.TicketCompanyCodeGet(AllTickets);

    } else {
      print(response.reasonPhrase);
    }
    setState(() {
     // ActiveScreen=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState

    RaedAllTickets(widget.loginModels[0].userRoll);
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return   Scaffold(
      backgroundColor: const Color(0xFF21899C),
      body: SingleChildScrollView(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 15,bottom: 7),
              child: Text('Hello',style: GoogleFonts.poppins(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w400),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(widget.loginModels[0].name, style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
            ),

            Container(height: 20,),
            Container(
            width: size.width/1,
            height: size.height/1.3,

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60,),topRight: Radius.circular(60))),
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context, CupertinoPageRoute(builder: (_) => TicketPage(widget.loginModels,"All")));

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(

                              width: size.width/2.5,height: 200,

                              decoration:  const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 22,
                                ),],
                                borderRadius:

                                BorderRadius.all(Radius.circular(20.0),),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  ClipOval(
                                      child: Container(height: 70, width: 70, color:Color(0xFFF56B3F)

                                      ,child:  Center(
                                        child: Countup(
                                            begin: 0,
                                            end: double.parse(ToatalCount.toString()),

                                            separator: ',',
                                            style: GoogleFonts.poppins(
                                              color:Colors.white,
                                              fontWeight:FontWeight.bold,
                                              fontSize: 15,

                                            ),
                                          ),
                                      ),
                                      )

                                  ),
Container(height: 20,),
                                  Center(child: Text("Total Tickets",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color:MyColors.AppthemeColor),)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context, CupertinoPageRoute(builder: (_) => TicketPage(widget.loginModels,"Open")));

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: size.width/2.5,height: 200,

                              decoration:  const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 22,
                                ),],
                                borderRadius:

                                BorderRadius.all(Radius.circular(20.0),),
                              ),
                              child:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  ClipOval(
                                      child: Container(height: 70, width: 70, color:Color(0xFFF56B3F)

                                        ,child:  Center(
                                          child: Countup(
                                            begin: 0,
                                            end: double.parse(OpenCount.toString()),

                                            separator: ',',
                                            style: GoogleFonts.poppins(
                                              color:Colors.white,
                                              fontWeight:FontWeight.bold,
                                              fontSize: 15,

                                            ),
                                          ),
                                        ),
                                      )

                                  ),
                                  Container(height: 20,),
                                  Center(child: Text("Open Tickets",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color:MyColors.AppthemeColor),)),
                                ],
                              ),

                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context, CupertinoPageRoute(builder: (_) => TicketPage(widget.loginModels,"Pending")));

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(

                              width: size.width/2.5,height: 200,

                              decoration:  const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 22,
                                ),],
                                borderRadius:

                                BorderRadius.all(Radius.circular(20.0),),
                              ),
                              child:   Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  ClipOval(
                                      child: Container(height: 70, width: 70, color: Color(0xFFF56B3F)

                                        ,child:  Center(
                                          child: Countup(
                                            begin: 0,
                                            end: double.parse(PendingCount.toString()),

                                            separator: ',',
                                            style: GoogleFonts.poppins(
                                              color:Colors.white,
                                              fontWeight:FontWeight.bold,
                                              fontSize: 15,

                                            ),
                                          ),
                                        ),
                                      )

                                  ),
                                  Container(height: 20,),
                                  Center(child: Text("Pending Tickets",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color:MyColors.AppthemeColor),)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context, CupertinoPageRoute(builder: (_) => TicketPage(widget.loginModels,"Closed")));

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: size.width/2.5,height: 200,

                              decoration:  const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 22,
                                ),],
                                borderRadius:

                                BorderRadius.all(Radius.circular(20.0),),
                              ),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  ClipOval(
                                      child: Container(height: 70, width: 70, color: Color(0xFFF56B3F)

                                        ,child:  Center(
                                          child: Countup(
                                            begin: 0,
                                            end: double.parse(ClosedCount.toString()),

                                            separator: ',',
                                            style: GoogleFonts.poppins(
                                              color:Colors.white,
                                              fontWeight:FontWeight.bold,
                                              fontSize: 15,

                                            ),
                                          ),
                                        ),
                                      )

                                  ),
                                  Container(height: 20,),
                                  Center(child: Text("Closed Tickets",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color:MyColors.AppthemeColor),)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
