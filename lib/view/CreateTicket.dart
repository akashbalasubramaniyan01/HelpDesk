
import 'package:flutter/services.dart';
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
import 'package:http_auth/http_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../model/LoginModel.dart';
import 'MainViewPage.dart';

class CreateTicket extends StatefulWidget {
  final List<LoginModel> loginModels;
  var AllCompanyList;
   CreateTicket(this.loginModels,this.AllCompanyList);

  @override
  State<CreateTicket> createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController Description = TextEditingController();
  TextEditingController issuecode = TextEditingController();
  TextEditingController issuedetails = TextEditingController();
  TextEditingController SearchText = TextEditingController();
  TextEditingController DatetimeController = TextEditingController();
  String IssueAllert = "";
  bool CreateTicketbool = false;
  String DescAllert = "";
  String UserNameAllert = "";
  String CodeAllert = "";
  String dropdownvalue = 'Moderate';
  String CompanyCode = '4P';
  String pvalue = 'Hardware Failure';
  var items =  ['Moderate','Critical','High','Low'];
  var CompanyCodeValues =  [];
  var itemsissue =  ['Hardware Failure','Network/ WiFi Issue','Printer Problem','E-Mail Issue','Office 365','CCTV','Software Issue','Other'];
  void _getDateAndTime() {
    DateTime now = DateTime.now();
    String formattedDate = '${now.day}-${(now.month)}-${(now.year)}';
    String formattedTime = '${(now.hour)}:${(now.minute)}';
    DatetimeController.text = formattedDate+" "+ formattedTime;
    issuecode.text = widget.loginModels[0].company;

 /*   var companies = widget.AllCompanyList.map((ticket) => ticket['Company']).toList();
      print(companies);
    CompanyCodeValues = widget.AllCompanyList.map((ticket) => ticket['Company']).toSet().toList();
*/

  }
int CountTicketBadge =0;
  Map<String, dynamic> JsonDatas = {

  };
  ComapnyListData() async {


    var client = DigestAuthClient('ri2helpdeskuser', r'6i$qu@6e');
    var Url;

      Url = '${GlobalConfiguration().get("ApiURl")}apilistofcompany';


    var response = await client.get(Uri.parse(Url),headers: {
      'x-api-key': 'bRuD5WYw5wd0rdHR9yLlM6wt2vteuiniQBqE70nA',
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=3gnid18nsvll4u99839vfroba1ihd58t; csrfcookiei2help=4912ec8965916cc488eeb6aa70918fa7'
    },

    );

    if (response.statusCode == 200) {
      setState(() {
        var jsonResponse = json.decode(response.body);
        var JsonData = jsonResponse['data'];
        print(JsonData);
        JsonDatas =JsonData;

      });


    } else {
      print(response.reasonPhrase);
    }
    setState(() {
      // ActiveScreen=false;
    });
  }




  NewTickets(String Username, String Desc, String issuecode, String issuedetails, String issuevalsue, String issuetype,String dateInput,String CompanyCode) async {
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
          "ccode": CompanyCode
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
         int value =  CountTicketBadge++;

          final materialBanner = MaterialBanner(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            backgroundColor: Colors.transparent,
            forceActionsBelow: false,
            content: AwesomeSnackbarContent(
              title: 'Success',
              message:
              'Ticket has been Created',

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.success,
              // to configure for material banner
              inMaterialBanner: true,
            ),
            actions: const [SizedBox.shrink()],
          );

          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showMaterialBanner(materialBanner);


          Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (_) => MainPage(0, loginModels:widget.loginModels,)));

          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();


        }); }
      else {

      }
    }catch (e){
      print(e);
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    _getDateAndTime();
    ComapnyListData();
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  SingleChildScrollView(
      child: Container(

        //height: MediaQuery.of(context).size.height * 0.77,
        child: SingleChildScrollView(
          child: Column(

            children:[
            Container(height: 20,),
              Container(
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [new BoxShadow(
                       color: Colors.black12,
                      blurRadius: 22,
                    ),]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child:  Text("Create Ticket",style: GoogleFonts.poppins( fontSize: 25.0,
                    color: MyColors.btnBorderColor,
                    fontWeight: FontWeight.bold,),)),
                ),
              ),
              SingleChildScrollView(
                child: Container(

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(height: 15,),
                        Container(

                          alignment: Alignment.center,
                          height: size.height / 12,

                          //margin: const EdgeInsets.only(left: 5,right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color:  Colors.white,

                              boxShadow: [new BoxShadow(
                                color: Colors.black26,
                                blurRadius: 7,
                              ),]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0,),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              //mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                //mail icon
                                Icon(CupertinoIcons.time_solid),
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
                                    controller: DatetimeController,
                                    maxLines: 1,
                                    enabled: false,
                                    cursorColor: Colors.black87,

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
                    /*    Container(
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
                                ))),*/
                        Container(height: 15,),

                        Container(
                          alignment: Alignment.center,
                          height: size.height / 12,

                          //margin: const EdgeInsets.only(left: 5,right: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color:  Colors.white,

                              boxShadow: [new BoxShadow(
                                color: Colors.black26,
                                blurRadius: 7,
                              ),]
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

                              boxShadow: [new BoxShadow(
                                color: Colors.black26,
                                blurRadius: 7,
                              ),]
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
                              borderRadius: BorderRadius.circular(10.0),
                              color:  Colors.white,

                              boxShadow: [new BoxShadow(
                                color: Colors.black26,
                                blurRadius: 7,
                              ),]    ),
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
                                  pvalue = newValue!;
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
                              borderRadius: BorderRadius.circular(10.0),
                              color:  Colors.white,

                              boxShadow: [new BoxShadow(
                                color: Colors.black26,
                                blurRadius: 7,
                              ),]   ),
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

                              boxShadow: [new BoxShadow(
                                color: Colors.black26,
                                blurRadius: 7,
                              ),]
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

                        Text("  Select Company Name",style:GoogleFonts.poppins( fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,),),
                        Container(height: 5,),
                        if(JsonDatas.isNotEmpty)
                        Container(
                          width: size.width,
                          height: 50,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color:  Colors.white,

                              boxShadow: [new BoxShadow(
                                color: Colors.black26,
                                blurRadius: 7,
                              ),]   ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              elevation: 0,
                              value: CompanyCode,

                              icon: Icon(Icons.keyboard_arrow_down),

                              items:JsonDatas.entries.map((MapEntry<String, dynamic> entry) {
                                return DropdownMenuItem<String>(
                                  value: entry.key,
                                  child: Text(entry.value),
                                );
                              }).toList(),

                              onChanged:  (value) {

                                setState(() {
                                  CompanyCode = value.toString();
                                });
                              },

                            ),
                          ),
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
                              if(issuecode.text==""||issuedetails.text==""||username.text==""||Description==""){
                               // Navigator.of(context).pop();


                                setState(() {
                                  IssueAllert = "Enter the Issue Detail";
                                  CodeAllert = "Enter the Issue Code";
                                  UserNameAllert = "Enter the UserName";
                                  DescAllert = "Enter the Description";
                                });
                              }
                              else{

                                NewTickets(username.text,Description.text,issuecode.text,issuedetails.text,dropdownvalue,pvalue,DatetimeController.text,CompanyCode);

                              }

                              /* Navigator.pushReplacement(
                                    context, CupertinoPageRoute(builder: (_) =>  MainPage()));*/

                            },
                            child: CreateTicketbool? Center(child: SpinKitRotatingCircle(
                              color: Colors.white,
                              size: 50.0,
                            )
                            ) :Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(CupertinoIcons.add,color: Colors.white,),
                                  Container(width: 8,),
                                  Text(
                                      'Create Ticket',
                                      style: GoogleFonts.poppins( fontSize: 25.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,)
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(height: 27,),
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
  }


}
