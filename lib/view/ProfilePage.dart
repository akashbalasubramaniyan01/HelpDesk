import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk/view/signin.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../model/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class Profilepage extends StatefulWidget {

  final List<LoginModel> loginModels;
  Profilepage(this.loginModels) ;


  @override
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                AvatarImage(),
                SizedBox(
                  height: 15,
                ),


                Text(
                  widget.loginModels[0].name,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Poppins"),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.loginModels[0].userRoll,
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 15),

                ProfileListItems(widget.loginModels),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AppBarButton extends StatelessWidget {
  final IconData icon;

  const AppBarButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kAppPrimaryColor,
          boxShadow: [
            BoxShadow(
              color: kLightBlack,
              offset: Offset(1, 1),
              blurRadius: 10,
            ),
            BoxShadow(
              color: kWhite,
              offset: Offset(-1, -1),
              blurRadius: 10,
            ),
          ]),
      child: Icon(
        icon,
        color: fCL,
      ),
    );
  }
}

class AvatarImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      padding: EdgeInsets.all(8),
      decoration: avatarDecoration,
      child: Container(
        decoration: avatarDecoration,
        padding: EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/mens.png'),
            ),
          ),
        ),
      ),
    );
  }
}

class SocialIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocialIcon(
          color: Color(0xFF102397),
          iconData: facebook,
          onPressed: () {},
        ),
        SocialIcon(
          color: Color(0xFFff4f38),
          iconData: googlePlus,
          onPressed: () {},
        ),
        SocialIcon(
          color: Color(0xFF38A1F3),
          iconData: twitter,
          onPressed: () {},
        ),
        SocialIcon(
          color: Color(0xFF2867B2),
          iconData: linkedin,
          onPressed: () {},
        )
      ],
    );
  }
}

class SocialIcon extends StatelessWidget {
  final Color color;
  final IconData iconData;
  final Function onPressed;

  SocialIcon({required this.color, required this.iconData, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Container(
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: RawMaterialButton(
          shape: CircleBorder(),
          onPressed: () {

          },
          child: Icon(iconData, color: Colors.white),
        ),
      ),
    );
  }
}

class ProfileListItems extends StatelessWidget {
  var loginModels;
  ProfileListItems(this.loginModels);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          ProfileListItem(
            icon: Icons.email,
            text: loginModels[0].userId,
            name : ""


          ),
          ProfileListItem(
            icon: Icons.co_present_sharp,
            text: loginModels[0].company,
              name : ''
          ),

          ProfileListItem(
            icon: LineAwesomeIcons.alternate_sign_out,
            text: 'Logout',
            hasNavigation: false,
              name : loginModels[0].name
          ),
        ],
      ),
    );
  }
}

Color kAppPrimaryColor = Colors.grey.shade200;
Color kWhite = Colors.white;
Color kLightBlack = Colors.black.withOpacity(0.075);
Color mCC = Colors.green.withOpacity(0.65);
Color fCL = Colors.grey.shade600;


IconData twitter = IconData(0xe900, fontFamily: "CustomIcons");
IconData facebook = IconData(0xe901, fontFamily: "CustomIcons");
IconData googlePlus =
IconData(0xe902, fontFamily: "CustomIcons");
IconData linkedin = IconData(0xe903, fontFamily: "CustomIcons");

const kSpacingUnit = 10;

final kTitleTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

BoxDecoration avatarDecoration = BoxDecoration(
    shape: BoxShape.circle,
    color: kAppPrimaryColor,
    boxShadow: [
      BoxShadow(
        color: kWhite,
        offset: Offset(10, 10),
        blurRadius: 10,
      ),
      BoxShadow(
        color: kWhite,
        offset: Offset(-10, -10),
        blurRadius: 10,
      ),
    ]
);

class ProfileListItem extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final String name;
  const ProfileListItem({

    required this.icon,
    required this.text,
    this.hasNavigation = true,
    required this.name,
  }) ;

  @override
  State<ProfileListItem> createState() => _ProfileListItemState();
}

class _ProfileListItemState extends State<ProfileListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (this.widget.hasNavigation==false)
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

                          width: 450,height: 160,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all( color: Colors.white,width: 2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: /*Icon(Icons.person,color: Colors.white,size: 56,)*/ Image.asset("assets/mens.png",width: 70,),
                                  ),
                                ),
                              ),
                              Text(widget.name,style: GoogleFonts.poppins(
                              color:
                              Colors.white,
                              fontSize:
                              14,
                              fontWeight: FontWeight.bold,
                            ),)
                            ],
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
      child: Container(
        height: 55,
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ).copyWith(
          bottom: 20,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey.shade300,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              this.widget.icon,
              size: 25,
            ),
            SizedBox(width: 15),
            Text(
              this.widget.text,
              style: kTitleTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                fontSize: 14
              ),
            ),
            Spacer(),
            /*if (this.hasNavigation)
              Icon(
                LineAwesomeIcons.angle_right,
                size: 25,
              ),*/
          ],
        ),
      ),
    );
  }
}