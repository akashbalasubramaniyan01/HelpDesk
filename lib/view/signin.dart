import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
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
import 'package:fluttertoast/fluttertoast.dart';
import '../model/LoginModel.dart';
import 'dart:io';


class SignInFive extends StatefulWidget {
  const SignInFive({Key? key}) : super(key: key);

  @override
  State<SignInFive> createState() => _SignInFiveState();
}

class _SignInFiveState extends State<SignInFive> {

 List <LoginModel>LoginModels=[];

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController ressetpassword = TextEditingController();
 late Timer _timer;
 GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
 LogiApiCall(Email, Password) async {

   final prefs = await SharedPreferences.getInstance();
   try {
     DigestAuthClient client = DigestAuthClient('ri2helpdeskuser', r'6i$qu@6e');
     var url = "${GlobalConfiguration().get("ApiURl")}apilogin";
     print(url);
     http.Response response = await client.post(
         Uri.parse(url),
         headers: {
             'x-api-key': 'bRuD5WYw5wd0rdHR9yLlM6wt2vteuiniQBqE70nA',
           'Content-Type': 'application/json',
           'Cookie': 'ci_session=691airnq2vc9vimljkp2j2fe6ml7bgfe'
         },
         body: json.encode({
           "userid": Email,
           "password": Password,
           "count": 0
         })
     );
     /*     muralimanoharan@ri-square.com
                      Test@123                                  */

     print(response.statusCode);

     if (response.statusCode == 200) {

       setState(() {
         prefs.setString('UserName', Email);
         prefs.setString('PassWord', Password);
         print(response.body);
         var jsonResponse = json.decode(response.body);

         LoginModels = [jsonResponse]
             .map((taskJson) => LoginModel.fromJson(taskJson))
             .toList();
         Navigator.pushReplacement(
           context,MaterialPageRoute(builder: (context) => MainPage(0,loginModels:LoginModels)),);

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
         elevation: 0,
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

       Future.delayed(const Duration(seconds: 2), () {
         setState(() {
           ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
         });
       });

     }

   } catch (e) {
     print(e);
   }
 }
bool _passwordVisible= false;
 @override
 void initState() {
   _passwordVisible = false;
    // TODO: implement initState
    super.initState();
  }
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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(

      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xFF21899C),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: size.height/1.1,
                  child: Stack(
                    children: <Widget>[

                      //left side background design. I use a svg image here
                      Positioned(
                        left: -34,
                        top: 181.0,
                        child: SvgPicture.string(
                          // Group 3178
                          '<svg viewBox="-34.0 181.0 99.0 99.0" ><path transform="translate(-34.0, 181.0)" d="M 74.25 0 L 99 49.5 L 74.25 99 L 24.74999618530273 99 L 0 49.49999618530273 L 24.7500057220459 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-26.57, 206.25)" d="M 0 0 L 42.07500076293945 16.82999992370605 L 84.15000152587891 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(15.5, 223.07)" d="M 0 56.42999649047852 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                          width: 99.0,
                          height: 99.0,
                        ),
                      ),

                      //right side background design. I use a svg image here
                      Positioned(
                        right: -52,
                        top: 45.0,
                        child: SvgPicture.string(
                          // Group 3177
                          '<svg viewBox="288.0 45.0 139.0 139.0" ><path transform="translate(288.0, 45.0)" d="M 104.25 0 L 139 69.5 L 104.25 139 L 34.74999618530273 139 L 0 69.5 L 34.75000762939453 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(298.42, 80.45)" d="M 0 0 L 59.07500076293945 23.63000106811523 L 118.1500015258789 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(357.5, 104.07)" d="M 0 79.22999572753906 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                          width: 139.0,
                          height: 139.0,
                        ),
                      ),

                      //content ui
                      Positioned(
                        top: 35.0,
                        child: SizedBox(
                          width: size.width,
                          height: size.height,
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.06),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //logo section
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      logo(size.height / 8, size.height / 8),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      richText(23.12),
                                    ],
                                  ),
                                ),

                                //continue with email for sign in app text
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                      'Please Sign in to Continue',
                                      style: GoogleFonts.poppins(fontSize:13,color:Colors.white,fontWeight: FontWeight.w400)
                                  ),
                                ),

                                //email and password TextField here
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      emailTextField(size),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      passwordTextField(size),

                                      //buildRemember(size),
                                    ],
                                  ),
                                ),

                                //sign in button & continue with text here
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    children: [
                                      signInButton(size,emailController.text,passController.text),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      buildContinueText(),


                                    ],
                                  ),
                                ),

                                //footer section. google, facebook button and sign up text here
                                /*     Expanded(
                                  flex: 4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      signInGoogleFacebookButton(size),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      buildFooter(size),
                                    ],
                                  ),
                                ),*/

                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                buildFooter(size)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logo(double height_, double width_) {
    return Image.asset('assets/logo.png',  height: height_,
      width: width_,)/*SvgPicture.asset(
      'assets/logo2.svg',
      height: height_,
      width: width_,
    )*/;
  }

  Widget richText(double fontSize) {
    return Text.rich(
      TextSpan(
        style:TextStyle(  fontSize: 23.12,
          color: Colors.white,
          letterSpacing: 1.999999953855673,),
        children:  [
          TextSpan(
            text: 'I2',
              style: GoogleFonts.poppins(color: Colors.white,
                fontSize:38,
                fontWeight: FontWeight.w800,)    ),
           TextSpan(
            text: ' HELP',
              style: GoogleFonts.poppins(color: Color(0xFFFE9879),
               fontSize:38,
                fontWeight: FontWeight.w800,)

             /* style: TextStyle(
              color: Color(0xFFFE9879),
              fontFamily: "OpenSansBold",
              fontWeight: FontWeight.w800,
            ),*/
          ),
        ],
      ),
    );
  }

  Widget emailTextField(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFF4DA1B0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //mail icon
            const Icon(
              Icons.phone,
              color: Colors.white70,
            ),
            const SizedBox(
              width: 16,
            ),

            //divider svg
            SvgPicture.string(
              '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              width: 1.0,
              height: 15.5,
            ),
            const SizedBox(
              width: 16,
            ),

            //email address textField
            Expanded(
              child: TextField(
                controller: emailController,
                maxLines: 1,
                cursorColor: Colors.white70,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(   fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,),
                decoration: InputDecoration(
                    hintText: 'Enter Your Mobile number',
                    hintStyle:TextStyle( fontSize: 14.0,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,),
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget passwordTextField(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFF4DA1B0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //lock logo here
            const Icon(
              Icons.lock,
              color: Colors.white70,
            ),
            const SizedBox(
              width: 16,
            ),

            //divider svg
            SvgPicture.string(
              '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              width: 1.0,
              height: 15.5,
            ),
            const SizedBox(
              width: 16,
            ),

            //password textField
            Expanded(
              child: TextField(
                controller: passController,
                maxLines: 1,
                obscureText: !_passwordVisible,//This will obscure text dynamically
                cursorColor: Colors.white70,
                keyboardType: TextInputType.visiblePassword,

                style: TextStyle(  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,),
                decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(    fontSize: 14.0,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,   color: Colors.white,

                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRemember(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: 17.0,
          height: 17.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            gradient: const LinearGradient(
              begin: Alignment(5.65, -1.0),
              end: Alignment(-1.0, 1.94),
              colors: [Color(0xFF00AD8F), Color(0xFF7BF4DF)],
            ),
          ),
          child: SvgPicture.string(
            // Vector 5
            '<svg viewBox="47.0 470.0 7.0 4.0" ><path transform="translate(47.0, 470.0)" d="M 0 1.5 L 2.692307710647583 4 L 7 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-linecap="round" stroke-linejoin="round" /></svg>',
            width: 7.0,
            height: 4.0,
          ),
        ),

        Text(
            'Remember me',
            style: TextStyle(   fontSize: 14.0,
              color: Colors.white,
              fontWeight: FontWeight.w600,)
        ),
        const SizedBox(
          width: 60,
        ),
        InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext
                context) =>_changepassword(context, size)
            );
          },
          child: Text(
              "Forgot Password",
              style: TextStyle(   fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,)
          ),
        ),
      ],
    );
  }

  Widget signInButton(Size size, email, password) {
    return InkWell(

        onTap: () {
          if(emailController.text==""){
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
          else if(passController.text==""){
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
            LogiApiCall(email,password);
          }

          /* Navigator.pushReplacement(
    context, CupertinoPageRoute(builder: (_) =>  MainPage()));*/

        },
      child: Container(
        alignment: Alignment.center,
        height: size.height / 13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xFFF56B3F),
        ),
        child: InkWell(

          child: Text(
              'Sign in',
              style: TextStyle( fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,)
          ),
        ),
      ),
    );
  }

  Widget buildContinueText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        /*   const Expanded(
            child: Divider(
              color: Colors.white,
            )),*/
        /*Expanded(
          child: Text(
            'Or Continue with',
            style: TextStyle(  fontSize: 16.0,
              color: Colors.white,),
            textAlign: TextAlign.center,
          ),
        ),
        const Expanded(
            child: Divider(
              color: Colors.white,
            )),*/
      ],
    );
  }

  Widget signInGoogleFacebookButton(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        //sign in google button
        Container(
          alignment: Alignment.center,
          width: size.width / 2.8,
          height: size.height / 13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //icon of google
              SvgPicture.string(
                '<svg viewBox="63.54 641.54 22.92 22.92" ><path transform="translate(63.54, 641.54)" d="M 22.6936149597168 9.214142799377441 L 21.77065277099609 9.214142799377441 L 21.77065277099609 9.166590690612793 L 11.45823860168457 9.166590690612793 L 11.45823860168457 13.74988651275635 L 17.93386268615723 13.74988651275635 C 16.98913192749023 16.41793632507324 14.45055770874023 18.33318138122559 11.45823860168457 18.33318138122559 C 7.661551475524902 18.33318138122559 4.583295345306396 15.25492572784424 4.583295345306396 11.45823860168457 C 4.583295345306396 7.661551475524902 7.661551475524902 4.583295345306396 11.45823860168457 4.583295345306396 C 13.21077632904053 4.583295345306396 14.80519008636475 5.244435787200928 16.01918983459473 6.324374675750732 L 19.26015281677246 3.083411931991577 C 17.21371269226074 1.176188230514526 14.47633838653564 0 11.45823860168457 0 C 5.130426406860352 0 0 5.130426406860352 0 11.45823860168457 C 0 17.78605079650879 5.130426406860352 22.91647720336914 11.45823860168457 22.91647720336914 C 17.78605079650879 22.91647720336914 22.91647720336914 17.78605079650879 22.91647720336914 11.45823860168457 C 22.91647720336914 10.68996334075928 22.83741569519043 9.940022468566895 22.6936149597168 9.214142799377441 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(64.86, 641.54)" d="M 0 6.125000953674316 L 3.764603137969971 8.885863304138184 C 4.78324031829834 6.363905429840088 7.250198841094971 4.583294868469238 10.13710117340088 4.583294868469238 C 11.88963890075684 4.583294868469238 13.48405265808105 5.244434833526611 14.69805240631104 6.324373722076416 L 17.93901443481445 3.083411693572998 C 15.89257335662842 1.176188111305237 13.15520095825195 0 10.13710117340088 0 C 5.735992908477783 0 1.919254422187805 2.484718799591064 0 6.125000953674316 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(64.8, 655.32)" d="M 10.20069408416748 9.135653495788574 C 13.16035556793213 9.135653495788574 15.8496036529541 8.003005981445312 17.88286781311035 6.161093711853027 L 14.33654403686523 3.160181760787964 C 13.14749050140381 4.064460277557373 11.69453620910645 4.553541660308838 10.20069408416748 4.55235767364502 C 7.220407009124756 4.55235767364502 4.689855575561523 2.6520094871521 3.736530303955078 0 L 0 2.878881216049194 C 1.896337866783142 6.589632034301758 5.747450828552246 9.135653495788574 10.20069408416748 9.135653495788574 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(75.0, 650.71)" d="M 11.23537635803223 0.04755179211497307 L 10.31241607666016 0.04755179211497307 L 10.31241607666016 0 L 0 0 L 0 4.583295345306396 L 6.475625038146973 4.583295345306396 C 6.023715496063232 5.853105068206787 5.209692478179932 6.962699413299561 4.134132385253906 7.774986743927002 L 4.135851383209229 7.773841857910156 L 7.682177066802979 10.77475357055664 C 7.431241512298584 11.00277233123779 11.45823955535889 8.020766258239746 11.45823955535889 2.291647672653198 C 11.45823955535889 1.523372769355774 11.37917804718018 0.773431122303009 11.23537635803223 0.04755179211497307 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                width: 22.92,
                height: 22.92,
              ),
              const SizedBox(
                width: 16,
              ),
              //google txt
              Text(
                'Google',
                style: TextStyle(  fontSize: 16.0,
                  color: Colors.white,),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 16,
        ),

        //sign in facebook button
        Container(
          alignment: Alignment.center,
          width: size.width / 2.8,
          height: size.height / 13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //facebook icon
              SvgPicture.string(
                '<svg viewBox="0.3 0.27 22.44 22.44" ><defs><linearGradient id="gradient" x1="0.500031" y1="0.970054" x2="0.500031" y2="0.0"><stop offset="0.0" stop-color="#ffffffff"  /><stop offset="1.0" stop-color="#ffffffff"  /></linearGradient></defs><path transform="translate(0.3, 0.27)" d="M 9.369577407836914 22.32988739013672 C 4.039577960968018 21.3760986328125 0 16.77546882629395 0 11.22104930877686 C 0 5.049472332000732 5.049472808837891 0 11.22105026245117 0 C 17.39262962341309 0 22.44210624694824 5.049472332000732 22.44210624694824 11.22104930877686 C 22.44210624694824 16.77546882629395 18.40252304077148 21.3760986328125 13.07252502441406 22.32988739013672 L 12.45536518096924 21.8249397277832 L 9.986735343933105 21.8249397277832 L 9.369577407836914 22.32988739013672 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(6.93, 4.65)" d="M 8.976840972900391 9.986734390258789 L 9.481786727905273 6.844839572906494 L 6.508208274841309 6.844839572906494 L 6.508208274841309 4.656734466552734 C 6.508208274841309 3.759051322937012 6.844841003417969 3.085787773132324 8.191367149353027 3.085787773132324 L 9.650103569030762 3.085787773132324 L 9.650103569030762 0.2244201600551605 C 8.864629745483398 0.1122027561068535 7.966946125030518 0 7.181471347808838 0 C 4.600629806518555 0 2.805262804031372 1.570946097373962 2.805262804031372 4.376209735870361 L 2.805262804031372 6.844839572906494 L 0 6.844839572906494 L 0 9.986734390258789 L 2.805262804031372 9.986734390258789 L 2.805262804031372 17.8975715637207 C 3.422420024871826 18.00978851318359 4.039577484130859 18.06587600708008 4.656735897064209 18.06587600708008 C 5.273893356323242 18.06587600708008 5.89105224609375 18.009765625 6.508208274841309 17.8975715637207 L 6.508208274841309 9.986734390258789 L 8.976840972900391 9.986734390258789 Z" fill="#21899c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                width: 22.44,
                height: 22.44,
              ),
              const SizedBox(
                width: 16,
              ),

              //facebook txt
              Text(
                  'Facebook',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.0,
                    color: Colors.white,)
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildFooter(Size size) {
    return  Align(
      alignment: Alignment.center,
      child: Center(
        child: Text.rich(
          TextSpan(
            style: TextStyle(  fontSize: 16.0,
              color: Colors.white,),
            children: [
              TextSpan(
                  text: 'Powered  by',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400,)
              ),
              TextSpan(
                  text: '  Ri-square',
                  style: GoogleFonts.poppins(    color: MyColors.btnBorderColor,

                    fontWeight: FontWeight.w700,)
              ),
            ],
          ),
        ),
      ),
    );
  }
 Widget _changepassword(BuildContext context,Size size) {
   return AlertDialog(
     contentPadding: EdgeInsets.zero,
     content: Stack(
         children: <Widget>[
           Form(
             child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisSize: MainAxisSize.min,
                 children: <Widget>[

                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Padding(
                           padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                           child: Text("Forgot Password",
                               style: GoogleFonts.poppins(
                                 color: MyColors.AppthemeColor,
                                 fontWeight:FontWeight.w700,
                                 fontSize: 16,

                               ))),
                       Padding(
                         padding: EdgeInsets.only(right: 20),
                         child: InkResponse(
                           onTap: () {
                             Navigator.of(context).pop();
                            // emailemptybool=false;
                            // emailbool=false;
                           },
                           child: CircleAvatar(
                             radius: 12,
                             child: Icon(
                               Icons.close,
                               size: 18,
                             ),
                           ),
                         ),
                       ),
                     ],
                   ),
                   Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                     Divider(
                       height: 10,
                       color: Colors.black26,
                       thickness: 1,
                     ),
                   ],
                   ),
                   Container(height: 20,),
                   Container(
                     alignment: Alignment.center,
                     height: size.height / 17,
                     margin: EdgeInsets.only(right: 15,left: 15),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10.0),
                       color: const Color(0xFF4DA1B0),
                     ),
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: <Widget>[
                           //mail icon
                           const Icon(
                             Icons.mail_lock_rounded,
                             color: Colors.white70,
                           ),
                           const SizedBox(
                             width: 16,
                           ),

                           //divider svg
                           SvgPicture.string(
                             '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                             width: 1.0,
                             height: 15.5,
                           ),
                           const SizedBox(
                             width: 16,
                           ),

                           //email address textField
                           Expanded(
                             child: TextField(
                               controller: ressetpassword,
                               maxLines: 1,
                               cursorColor: Colors.white70,
                               keyboardType: TextInputType.emailAddress,
                               style: TextStyle(   fontSize: 14.0,
                                 color: Colors.white,
                                 fontWeight: FontWeight.w500,),
                               decoration: InputDecoration(
                                   hintText: 'Forgot Password',
                                   hintStyle:TextStyle( fontSize: 14.0,
                                     color: Colors.white70,
                                     fontWeight: FontWeight.w500,),
                                   border: InputBorder.none),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),
                   Container(height: 20,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
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
                           child: Padding(
                             padding: const EdgeInsets.all(15),
                             child: Text(
                                 'Update Password',
                                 style: GoogleFonts.poppins( fontSize: 15.0,
                                   color: Colors.white,
                                   fontWeight: FontWeight.w600,)
                             ),
                           ),
                         ),
                       ),

                     ],
                   ),
                   Container(height: 20,),
                 ]),

           ),
         ]
     ),
   );
 }
 @override
 void dispose() {
   super.dispose();
   // Cancel the timer when the page is disposed
   _timer.cancel();
 }
}