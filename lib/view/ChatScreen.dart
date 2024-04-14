

import 'dart:convert';
import 'dart:ui';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'package:intl/intl.dart';
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
import 'package:scroll_to_index/scroll_to_index.dart';
import '../model/LoginModel.dart';
import 'ChatScreen.dart';
import 'CreateTicket.dart';
import 'TicketList.dart';
import 'package:flutter_svg/svg.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

import 'package:aligned_dialog/aligned_dialog.dart';

import 'TicketSearchDetails.dart';
import '../model/LoginModel.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk/utils/colors.dart';

import '../model/LoginModel.dart';
class ChatPage extends StatefulWidget {
  final List<LoginModel> loginModels;
  var TicketNo;
  var Desc;

   ChatPage(this.loginModels,this.TicketNo,this.Desc);

  @override
  State<ChatPage> createState() => _ChatPageState();
}
bool _isLoading = false;
bool loading = false;

class _ChatPageState extends State<ChatPage> {
  TextEditingController Message = TextEditingController();
  ScrollController controller = ScrollController();
  late AutoScrollController controllers;
  @override
  var dataList=[];
  late FocusNode _focusNode;
  bool AutoFocus = false;
  void initState() {
    controllers = AutoScrollController();
    _focusNode = FocusNode();
    readAllConvarsation();
    super.initState();

  }
  Widget build(BuildContext context) {
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
                text: '     HELP',
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
      body:     Column(
        children: [
        Container(
          width: MediaQuery.of(
            context)
            .size
            .width/1,
        decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 22)]),
       child: Padding(
         padding: const EdgeInsets.all(14),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
           children: [

             Container(

               child:
               Text.rich(
                 TextSpan(
                     children: [
                       TextSpan(text: "Ticket No : ", style:  GoogleFonts.quicksand(fontWeight: FontWeight.bold),),
                       TextSpan(text: widget.TicketNo, style: GoogleFonts.poppins(color: Colors.black,fontWeight:FontWeight.bold))
                     ]),
               ),
             ),
             Container(
width: MediaQuery.of(
    context)
    .size
    .width,
               alignment: Alignment.center,
               child:
               Text.rich(
                 TextSpan(
                     children: [
                       TextSpan(text: "Descripition: ", style:  GoogleFonts.quicksand(fontWeight: FontWeight.bold),),
                       TextSpan(text: widget.Desc, style: GoogleFonts.poppins(color: Colors.black,fontWeight:FontWeight.bold))
                     ]),
               ),
             )
           ],
         ),
       ),

        ),
          SingleChildScrollView(

            child: Container(

                height: MediaQuery.of(
                    context)
                    .size
                    .height/1.4,

                child: AutoScrollTag(
                  key: ValueKey(dataList
                      .length),
                  controller: controllers,
                  index: dataList
                      .length,
                  child: ListView.builder(
                            controller: controllers,
                      reverse: false,
                      shrinkWrap: true,
                      scrollDirection:
                      Axis.vertical,

                      padding:
                      EdgeInsets.all(
                          20),
                      itemCount:
                      dataList
                          .length,
                      itemBuilder: (context, i) {

                        return Container(
                            alignment: i % 2 == 0 ? Alignment.centerRight : Alignment.centerLeft,

                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                decoration:  BoxDecoration(
                                  boxShadow: [BoxShadow(blurRadius: 22, color: Colors.black12)],
                                  color: i % 2 == 0 ?MyColors.AppthemeColor:Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(i % 2 == 0 ? 0 : 23), // Set topLeft radius to 0 when index is even
                                    topRight: Radius.circular(i % 2 == 0 ? 23 : 0), // Set topRight radius to 0 when index is odd
                                    bottomLeft: const Radius.circular(23),
                                    bottomRight: const Radius.circular(23),
                                  ),
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context).size.width /1.8,
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(dataList[i][0], style: GoogleFonts.poppins(fontSize: 15, color: i % 2 == 0 ?Colors.white: Colors.black, fontWeight: FontWeight.w600)),
                                                  const SizedBox(height: 12),
                                                  //Text(dataList[i][2], style: GoogleFonts.poppins(color: Colors.white)),
                                                  // const SizedBox(height: 8),
                                                  //  Text(dataList[i][1], style: GoogleFonts.poppins(color: Colors.white)),

                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 15),
                                              child: Text(
                                                DateFormat('dd/MM/yyyy').format(DateTime.parse(dataList[i][1]),),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  color: i % 2 == 0 ?Colors.white: Colors.black,
                                                ),
                                              ),
                                            ),

                                          ],
                                          )),
                                    ]))
                        );
                      }),
                )
            ),
          ),
        ],
      ),

      bottomSheet:   Container(
        width:
        MediaQuery.of(context)
            .size
            .width/1,
        color: Colors.white,
        //margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment
              .center,
          children: [
            Container(
              width: MediaQuery.of(
                  context)
                  .size
                  .width /1.3,
              child:  Scrollbar(

                child:
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(60),color: Colors.white,boxShadow: [BoxShadow(blurRadius: 11,color: Colors.black12 )]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17),
                    child: TextFormField(
                      focusNode: _focusNode,
                      controller: Message,
                      cursorColor:
                      Colors.red,

                      keyboardType:
                      TextInputType
                          .multiline,
                      maxLines: 1,

                      decoration:
                      InputDecoration(
                        border: InputBorder.none,
                        hintText:
                        "Type your message",
                        hintStyle: GoogleFonts.poppins()

                      ),
                    ),
                  ),
                ),
              ),
            ),
            loading
                ? CupertinoActivityIndicator()
                : Padding(
              padding: const EdgeInsets.only(left: 8),
              child: CircleAvatar(
                backgroundColor: MyColors.AppthemeColor,
                child: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors
                        .white,
                  ),
                  onPressed:() {


                    CreateMessage(Message.text);
                  },),
              ),
            ),
          ],
        ),
      ),
    );
  }

  CreateMessage(String messge) async {


    try {
      DigestAuthClient client = DigestAuthClient('ri2helpdeskuser', r'6i$qu@6e');
      var url = "${GlobalConfiguration().get("ApiURl")}apiNewcomments";
      print(url);
      http.Response response = await client.put(
          Uri.parse(url),
          headers: {
            'x-api-key': 'bRuD5WYw5wd0rdHR9yLlM6wt2vteuiniQBqE70nA',
            'Content-Type': 'application/json',
            'Cookie': 'ci_session=691airnq2vc9vimljkp2j2fe6ml7bgfe'
          },
          body: json.encode({

              "ticketno": widget.TicketNo,
              "details": messge,
              "Name": widget.loginModels[0].name


          })
      );
      _focusNode.unfocus();
      print(response.statusCode);

      if (response.statusCode == 200) {

        setState(() {


          var jsonResponse = json.decode(response.body);
          DateTime now = DateTime.now();
          String formattedDate = now.toString();
          print(jsonResponse);
          List<String> a =[
            messge,
            formattedDate
          ];
          dataList.add(a);
          setState(() {
            Message.text ="";
          });
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controllers.jumpTo(controllers.position.maxScrollExtent);
          });

          print("conversation data part3");

        });

      } else {
        // Handle other error cases
        print("e");

      }

    } catch (e) {
      print(e);
    }
  }
  readAllConvarsation() async {
    DigestAuthClient client = DigestAuthClient('ri2helpdeskuser', r'6i$qu@6e');
    var url = "${GlobalConfiguration().get("ApiURl")}apiticketdetails/${widget.TicketNo}";
    print(url);
    http.Response response = await client.get(
      Uri.parse(url),
      headers: {
        'x-api-key': 'bRuD5WYw5wd0rdHR9yLlM6wt2vteuiniQBqE70nA',
        'Content-Type': 'application/json',
        'Cookie': 'ci_session=691airnq2vc9vimljkp2j2fe6ml7bgfe'
      },

    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      // Message sent successfully, update UI
      final responseData = jsonDecode(response.body);

      List<dynamic> rawData = responseData['data'];

      setState(() {
        dataList = rawData.map<List<String>>((item) => List<String>.from(item)).toList();
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controllers.jumpTo(controllers.position.maxScrollExtent);
      });
    } else {
      // Handle error
      print('Failed to send message: ${response.statusCode}');
    }
  }
  @override
  void dispose() {
    Message.dispose();
    _focusNode.dispose();
    super.dispose();
  }

}
