

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  TextEditingController username = TextEditingController();
  TextEditingController issuecode = TextEditingController();
  TextEditingController issuedetails = TextEditingController();
  String dropdownvalue = 'Select Priority';
  String pvalue = 'Select Issue';
  var items =  ['Select Priority','Moderate','Critical','High','Low'];
  var itemsissue =  ['Select Issue','Hardware Failure','Network/ WiFi Issue','Printer Problem','E-Mail Issue','Office 365','CCTV','Software Issue','Other'];

  void TicketCreate(size){
    showModalBottomSheet(
      context: context,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        // UDE : SizedBox instead of Container for whitespaces
        return  SizedBox(
          height: 500,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

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
                            child: TextField(
                              controller: username,
                              maxLines: 1,
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
                      Container(height: 10,),
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
                                child: TextField(
                                  controller: username,
                                  maxLines: 95,
                                  cursorColor: Colors.black87,
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
                      Container(height: 10,),
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
                      Container(height: 10,),
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
                      Container(height: 10,),
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(height: 10,),
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
                                child: TextField(
                                  controller: issuecode,
                                  maxLines: 1,
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
                      Container(height: 10,),
                      Container(
                        alignment: Alignment.center,
                        height: size.height / 13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xFFF56B3F),
                        ),
                        child: InkWell(
                          onTap: () {
                            if(issuecode.text==""){
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return  AlertDialog(
                                    elevation: 14,
                                    backgroundColor: MyColors.AppthemeColor,
                                    title: Center(child: Text('Please Enter the Email', style: GoogleFonts.quicksand(textStyle: Theme.of(context).textTheme.headline4))),

                                  );
                                },
                              );
                            }
                            else if(issuedetails.text==""){
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return  AlertDialog(
                                    elevation: 14,
                                    backgroundColor: MyColors.AppthemeColor,
                                    title: Text('Please Enter the Password',style: GoogleFonts.quicksand(textStyle: Theme.of(context).textTheme.headline4)),

                                  );
                                },
                              );
                            }
                            else{

                            }

                            /* Navigator.pushReplacement(
    context, CupertinoPageRoute(builder: (_) =>  MainPage()));*/

                          },
                          child: Text(
                              'Sign in',
                              style: TextStyle( fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,)
                          ),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return   Stack(
      children: [

        Container(
          height: size.height/1.4,
         // width: size.width/2,
          margin: const EdgeInsets.only(top: 40),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50) ),
          ),
        ),
        Positioned(
          bottom: 50,right: 15,
            child: FloatingActionButton(onPressed: () { TicketCreate(size); },child: const Icon(CupertinoIcons.create_solid,color: MyColors.AppthemeColor,),)),
      ],
    );
  }
}
