

import 'dart:convert';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:helpdesk/view/MainViewPage.dart';
import 'package:http_auth/http_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../model/LoginModel.dart';
import 'TicketDetails.dart';
class TicketPage extends StatefulWidget {

  final List<LoginModel> loginModels;
  String TicketName;
   TicketPage(this.loginModels,this.TicketName);

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  TextEditingController username = TextEditingController();
  TextEditingController Description = TextEditingController();
  TextEditingController issuecode = TextEditingController();
  TextEditingController issuedetails = TextEditingController();
  TextEditingController SearchText = TextEditingController();
  String IssueAllert = "";
  bool CreateTicketbool = false;
  String DescAllert = "";
  String UserNameAllert = "";
  String CodeAllert = "";
  String dropdownvalue = 'Moderate';
  String pvalue = 'Select Issue';
  var items =  ['Moderate','Critical','High','Low'];
  var itemsissue =  ['Select Issue','Hardware Failure','Network/ WiFi Issue','Printer Problem','E-Mail Issue','Office 365','CCTV','Software Issue','Other'];


  CreateTicket(String Username, String Desc, String issuecode, String issuedetails, String issuevalsue, String issuetype,String dateInput) async {
     DigestAuthClient client = DigestAuthClient('ri2helpdeskuser', r'6i$qu@6e');

    try{
      var url = "${GlobalConfiguration().get("ApiURl")}apinewticket";
      print(url);
      final response = await client.put(Uri.parse(url),
        body: json.encode({
          "docdate": dateInput,
          "stext": Desc,
          "ptype": issuetype,
          "priority":issuevalsue,
          "details": issuedetails,
          "usrname": Username,
          "ccode": issuecode
        }),

        headers:   {
          'x-api-key': 'bRuD5WYw5wd0rdHR9yLlM6wt2vteuiniQBqE70nA',
          'Content-Type': 'application/json',
          'Cookie': 'ci_session=691airnq2vc9vimljkp2j2fe6ml7bgfe'
        },


      );
      print(response.statusCode);
      print(json.encode({
        "docdate": dateInput,
        "stext": Desc,
        "ptype": issuetype,
        "priority":issuevalsue,
        "details": issuedetails,
        "usrname": Username,
        "ccode": issuecode


      }));
      if (response.statusCode == 200) {
        setState(() {
          CreateTicketbool = false;
          var jsonResponse = json.decode(response.body);
          print(jsonResponse);
          RaedAllTickets(widget.loginModels[0].userRoll);
          Navigator.of(context).pop();

        }); }
      else {
        final materialBanner = MaterialBanner(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 2,
          backgroundColor: Colors.transparent,
          forceActionsBelow: false,
          content: AwesomeSnackbarContent(
            title: 'Failure',
            message:
            'Username And Password invalid!!!',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.failure,
            // to configure for material banner
            inMaterialBanner: true,
          ),
          actions: const [SizedBox.shrink()],
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showMaterialBanner(materialBanner);
      }
    }catch (e){
      print(e);
    }

  }
  void TicketCreate(size){
    TextEditingController dateInput = TextEditingController();
     IssueAllert = "";
     DescAllert = "";
     UserNameAllert = "";
     CodeAllert = "";
     dateInput.text = ""; //set the initial value of text field
    showModalBottomSheet(

      context: context,
      isScrollControlled: true,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        // UDE : SizedBox instead of Container for whitespaces
        return  SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.77,
            child: SingleChildScrollView(
              child: Column(

                children: [
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                        color: MyColors.AppthemeColor,
                        boxShadow: [new BoxShadow(
                   // color: Colors.black,
                    //blurRadius: 1.0,
                  ),]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child:  Text("Create Ticket",style: GoogleFonts.quicksand( fontSize: 25.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,),)),
                  ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: size.height/0.7,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(

                          children: <Widget>[
                            Container(height: 15,),
                          Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color:  Colors.white,
                              ),
                             // height: MediaQuery.of(context).size.width / 3,
                              child: Center(
                                  child: TextField(
                                    controller: dateInput,

                                    //editing controller of this TextField
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.calendar_today), //icon of text field
                                        labelText: "Enter Date" //label text of field
                                    ),
                                    readOnly: true,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2100));

                                      if (pickedDate != null) {
                                        print(
                                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate =
                                        DateFormat('yyyy-MM-dd').format(pickedDate);
                                        print(
                                            formattedDate); //formatted date output using intl package =>  2021-03-16
                                        setState(() {
                                          dateInput.text =
                                              formattedDate; //set output date to TextField value.
                                        });
                                      } else {}
                                    },
                                  ))),
                            Container(height: 15,),

                           Container(
                        alignment: Alignment.center,
                          height: size.height / 12,

                          //margin: const EdgeInsets.only(left: 5,right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color:  Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0,),
                            child: Row(
                             // crossAxisAlignment: CrossAxisAlignment.center,
                               //mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                //mail icon
                                Icon(CupertinoIcons.person),
                                const SizedBox(
                                  width: 16,
                                ),

                                //divider svg
                                SvgPicture.string(
                                  '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                  width: 1.0,
                                  height: 15.5,
                                  color: Colors.black87,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),

                                //email address textField
                                Expanded(
                                  flex: 1,
                                  child: TextField(
                                    controller: username,
                                    maxLines: 1,
                                    cursorColor: Colors.black87,
                                    onChanged: (value) {
                                      if(value.isNotEmpty){
                                      setState(() {
                                        UserNameAllert ="";
                                      });
                                      }
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(   fontSize: 14.0,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,),
                                    decoration: InputDecoration(
                                        hintText: "Enter Your Name",

                                        hintStyle:GoogleFonts.quicksand( fontSize: 14.0,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w800,),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),


                              Text(UserNameAllert,style:GoogleFonts.quicksand( fontSize: 14.0,
                                color: Colors.red,
                                fontWeight: FontWeight.w800,),),

                            Container(
                              alignment: Alignment.center,
                              height: size.height / 12,

                              //margin: const EdgeInsets.only(left: 5,right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color:  Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0,),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    //mail icon


                                    //email address textField
                                    Expanded(
                                      flex: 1,
                                      child: TextField(
                                        controller: Description,
                                        maxLines: 95,
                                        cursorColor: Colors.black87,
                                        onChanged: (value) {
                                          if(value.isNotEmpty){
                                            setState(() {
                                              DescAllert ="";
                                            });
                                          }
                                        },
                                        keyboardType: TextInputType.emailAddress,
                                        style: TextStyle(   fontSize: 14.0,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,),
                                        decoration: InputDecoration(
                                            hintText: "Enter Description",

                                            hintStyle:GoogleFonts.quicksand( fontSize: 14.0,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w800,),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                              Text(DescAllert,style:GoogleFonts.quicksand( fontSize: 14.0,
                                color: Colors.red,
                                fontWeight: FontWeight.w800,),),

                            Container(
                              width: size.width,
                              height: 50,

                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: Colors.white, style: BorderStyle.solid, width: 0.80),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  elevation: 0,
                                  value: pvalue,

                                  icon: Icon(Icons.keyboard_arrow_down),

                                  items:itemsissue.map((String items) {
                                    return DropdownMenuItem(
                                        value: items,
                                        child: Text(items)
                                    );
                                  }
                                  ).toList(),

                                  onChanged: (String? newValue){
                                    setState(() {
                                      dropdownvalue = newValue!;
                                    });
                                  },

                                ),
                              ),
                            ),
                            Container(height: 20,),
                            Container(
                              width: size.width,
                              height: 50,

                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: Colors.white, style: BorderStyle.solid, width: 0.80),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  elevation: 0,
                                  value: dropdownvalue,

                                  icon: Icon(Icons.keyboard_arrow_down),

                                  items:items.map((String items) {
                                    return DropdownMenuItem(
                                        value: items,
                                        child: Text(items)
                                    );
                                  }
                                  ).toList(),

                                  onChanged: (String? newValue){
                                    setState(() {
                                      dropdownvalue = newValue!;
                                    });
                                  },

                                ),
                              ),
                            ),
                            Container(height: 15,),
                            Container(
                              alignment: Alignment.center,
                              height: size.height / 12,

                              //margin: const EdgeInsets.only(left: 5,right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color:  Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0,),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    //mail icon
                                    Icon(CupertinoIcons.device_desktop),
                                    const SizedBox(
                                      width: 16,
                                    ),

                                    //divider svg
                                    SvgPicture.string(
                                      '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                      width: 1.0,
                                      height: 15.5,
                                      color: Colors.black87,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),

                                    //email address textField
                                    Expanded(
                                      flex: 1,
                                      child: TextField(
                                        controller: issuedetails,
                                        maxLines: 1,
                                        cursorColor: Colors.black87,
                                        keyboardType: TextInputType.emailAddress,
                                        style: TextStyle(   fontSize: 14.0,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,),
                                        decoration: InputDecoration(
                                            hintText: "Enter Issue Details",

                                            hintStyle:GoogleFonts.quicksand( fontSize: 14.0,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w800,),
                                            border: InputBorder.none),
                                        onChanged: (value) {
                                          if(value.isNotEmpty){
                                            setState(() {
                                              IssueAllert = "";
                                            });
                                          }
                                        },
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),


                            Text(IssueAllert,style:GoogleFonts.quicksand( fontSize: 14.0,
                              color: Colors.red,
                              fontWeight: FontWeight.w800,),),

                            Container(
                              alignment: Alignment.center,
                              height: size.height / 12,

                              //margin: const EdgeInsets.only(left: 5,right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color:  Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0,),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    //mail icon
                                    Icon(CupertinoIcons.decrease_indent),
                                    const SizedBox(
                                      width: 16,
                                    ),

                                    //divider svg
                                    SvgPicture.string(
                                      '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                      width: 1.0,
                                      height: 15.5,
                                      color: Colors.black87,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),

                                    //email address textField
                                    Expanded(
                                      flex: 1,
                                      child: TextField(
                                        controller: issuecode,
                                        maxLines: 1,
                                        onChanged: (value) {
                                          if(value.isNotEmpty){
                                            setState(() {
                                              CodeAllert = "";
                                            });
                                          }
                                        },
                                        cursorColor: Colors.black87,
                                        keyboardType: TextInputType.emailAddress,
                                        style: TextStyle(   fontSize: 14.0,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,),
                                        decoration: InputDecoration(
                                            hintText: "Enter Issue code",

                                            hintStyle:GoogleFonts.quicksand( fontSize: 14.0,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w800,),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),


                              Text(CodeAllert,style:GoogleFonts.quicksand( fontSize: 14.0,
                                color: Colors.red,
                                fontWeight: FontWeight.w800,),),
                            Container(height: 30,),

                            Container(
                              alignment: Alignment.center,
                              height: size.height / 13,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color(0xFFF56B3F),
                              ),
                              child: InkWell(
                                onTap: () {
                                  if(issuecode.text==""||issuedetails.text==""||username.text==""||Description==""){
                                    Navigator.of(context).pop();
                                    TicketCreate(size);

                                    setState(() {
                                      IssueAllert = "Enter the Issue Detail";
                                      CodeAllert = "Enter the Issue Code";
                                      UserNameAllert = "Enter the UserName";
                                      DescAllert = "Enter the Description";
                                    });
                                  }
                                  else{
                                    setState(() {
                                      CreateTicketbool = true;
                                    });
                                    CreateTicket(username.text,Description.text,issuecode.text,issuedetails.text,dropdownvalue,pvalue,dateInput.text);
                                  }

                                  /* Navigator.pushReplacement(
                                    context, CupertinoPageRoute(builder: (_) =>  MainPage()));*/

                                },
                                child: CreateTicketbool? Center(child: SpinKitRotatingCircle(
                                  color: Colors.white,
                                  size: 50.0,
                                )
                                ) :Text(
                                    'Create Ticket',
                                    style: TextStyle( fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,)
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        );
      },
    );

  }
  var AllTickets =[];
  var ReadTickets =[];
  var OpenTickets =[];
  var searchFilterResult =[];
  var ticket_data_api_list =[];
  var ticket_data_filtered =[];
  int ToatalCount = 0;
  int OpenCount = 0;
  int PendingCount = 0;
  int ClosedCount = 0;
  int TotalTickesCount = 0;
  List searchResult = [];

  Future<void>_refresh() async {
    RaedAllTickets(widget.loginModels[0].userRoll);
    await Future.delayed(Duration(seconds: 2));


  }


   RaedAllTickets( UserRoll) async {
    setState(() {
      ActiveScreen=true;
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

       ReadTickets.addAll(JsonData);

         if(widget.TicketName=="All") {

          ReadTickets.forEach((element) {
            ticket_data_filtered.add(element);
            ticket_data_api_list.add(element);
          });
          print("ddddddddsssssssssssd");
          AllTickets = ReadTickets;
        }
         else if(widget.TicketName=="Open") {
          print("ddddddddsssssssssssd");
         AllTickets = ReadTickets.where((element) => element['Status']=='O').toList();
         ReadTickets.forEach((element) {
           ticket_data_filtered.add(element);
           ticket_data_api_list.add(element);
         });
       }
         else if(widget.TicketName=="Pending") {
          print("ddddddddsssssssssssd");
         AllTickets = ReadTickets.where((element) => element['Status']=="R").toList();
         ReadTickets.forEach((element) {
           ticket_data_filtered.add(element);
           ticket_data_api_list.add(element);
         });
       }
         else if(widget.TicketName=="Closed") {
          print("ddddddddsssssssssssd");
         AllTickets = ReadTickets.where((element) => element['Status']=="C").toList();
         ReadTickets.forEach((element) {
           ticket_data_filtered.add(element);
           ticket_data_api_list.add(element);
         });
       }
     });

    } else {
      print(response.reasonPhrase);
    }
    setState(() {
      ActiveScreen=false;
    });
  }
  bool ActiveScreen = true;
   int tabBarValue  =0;
  @override
  void initState() {
    // TODO: implement initState
    RaedAllTickets(widget.loginModels[0].userRoll);
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return   Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF21899C),
        //elevation: 1,
        leading: InkWell(onTap: () {

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(0,loginModels: widget.loginModels,),));
          //Navigator.of(context).pop();
        },child: Icon(Icons.arrow_back_ios,color: Colors.white)),

        title:  Center(
          child: Text.rich(
            TextSpan(
              style:TextStyle(  fontSize: 23.12,
                color: Colors.white,
                letterSpacing: 1.999999953855673,),
              children:  [
                TextSpan(
                  text: 'I2',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' HELP         ',
                  style: GoogleFonts.poppins(
                    color: Color(0xFFFE9879),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body:   ActiveScreen==true? Center(child: SpinKitCircle(

        color: Colors.orange,
        size: 45.0,
      )): Container(
            margin: const EdgeInsets.only(top: 0),
            decoration:  BoxDecoration(

             // borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50) ),

            ),
        child: Container(
          width: size.width,
          height: size.height/1,
          child: Column(
            children: [

              Container(
                width: MediaQuery.of(context).size.width/1,
                decoration:  const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                    color: Colors.black12,
                    blurRadius: 22,
                  ),],

                ),
                child: Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${widget.TicketName} Ticket",style: GoogleFonts.poppins(fontSize: 18, color: MyColors.btnBorderColor, fontWeight: FontWeight.bold),),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 3, bottom: 8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                     flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(38.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  offset: const Offset(0, 2),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 4, bottom: 4),
                            child: TextField(
                              onChanged: (String txt) {
                                onSearchTextChanged('');

                              },
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              controller: SearchText,
                              cursorColor: MyColors.AppthemeColor,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search Ticket No',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(38.0),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              offset: const Offset(0, 2),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                          onTap: () {

                            onSearchTextChanged( SearchText.text);
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(CupertinoIcons.search,
                                size: 20,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                Expanded(
                  flex: 2,
                  child:    RefreshIndicator(
                    onRefresh: _refresh,
                    child: Container(
                      width: size.width/1,
                      height: size.height/1,

                      child: ListView.builder(
                        itemCount: AllTickets.length,
                        itemBuilder: (context, i) {
                          return Container(

                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => TicketDeatils(AllTickets, i,widget.TicketName,widget.loginModels,  onBack: () async {
                                  await RaedAllTickets(widget.loginModels[0].userRoll);
                                },),));
                              },
                              child: Card(
                                color: MyColors.AppthemeColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text("Ticket No: " + AllTickets[i]['TicketNo'], style: GoogleFonts.quicksand(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0),
                                            child: Container(
                                                padding: const EdgeInsets.only(left: 5),
                                                width: MediaQuery.of(context).size.width/2.6,
                                                child: Text(AllTickets[i]['ShortText'].toString(), style: GoogleFonts.quicksand(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),)),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            width: 120,
                                            height: 30,
                                            decoration: BoxDecoration(color: AllTickets[i]['Status'] == "C" ? Colors.green.withOpacity(0.2) : AllTickets[i]['Status'] == "O" ? Colors.black.withOpacity(0.2) : Colors.white, borderRadius: const BorderRadiusDirectional.all(Radius.circular(8))),
                                            child: Center(child: Text(AllTickets[i]['Status'] == "O" ? "Open" : AllTickets[i]['Status'] == "C" ? "Closed" : "Resolved", style: GoogleFonts.poppins(fontSize: 15, color: AllTickets[i]['Status'] == "C" ? Colors.lightGreenAccent : AllTickets[i]['Status'] == "O" ? Colors.yellow : Colors.blue, fontWeight: FontWeight.bold),)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

              ]),
        )
          ),
    );
  }
  onSearchTextChanged(String text) async {

  setState(() {
    AllTickets.clear();
    searchResult.clear();
  });
    setState(() {
      print("text$text");
      if (text.isEmpty) {
        setState(() {
          AllTickets.clear();
          ticket_data_filtered.forEach((element) {
            AllTickets.add(element);
          });
        });
        return;
      }

      print("ticket_data_filtered00$ticket_data_filtered");
      ticket_data_filtered.forEach((Detail) {
        if (Detail['TicketNo'].toString().toLowerCase().contains(text.toLowerCase()))
          searchResult.add(Detail);
        print("searchResult$searchResult");

      });
    });

    setState(() {
      searchResult.forEach((searchData) {
        AllTickets.add(searchData);
      });
    });
  }


}
