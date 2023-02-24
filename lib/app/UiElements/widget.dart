import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ColorSet.dart';
import 'constColor.dart';

AppBar appBarMain(BuildContext context,String headingText,bool navflag,Icon iconimage,bool iconFlag,String unitType) {
  return AppBar(
elevation: 0,
    actions: [
      Visibility(child:  IconButton(

        icon:  iconimage,

        onPressed: () {
          // Navigator.push( context,MaterialPageRoute(builder: (context) => AddMember()),
          // );

        },
      ),
      visible: iconFlag,)

    ],

    backgroundColor: HexColor(blue_color),
    centerTitle: navflag,
    automaticallyImplyLeading: navflag, // <-- Step 2. SEE HERE

    title:Center(child: Text(
      headingText,
        style:
        GoogleFonts.montserrat(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w500)

    )

    // Image.asset(
    //   "assets/images/logo.png",
    //   height: 50,
    //
    // ),

    ) ,

  );
}
InputDecoration textFieldInputDecoration(String hintText,Icon itemIcon) {
  //Icon(Icons.email)
  return InputDecoration(
    prefixIcon:itemIcon,
    iconColor: Colors.white,
    hintText: hintText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
    filled: true,
    contentPadding: EdgeInsets.all(16),
    fillColor: Colors.white,
  );
}

InputDecoration filePathInputDecoration(String hintText,Icon itemIcon) {
  //Icon(Icons.email)
  return InputDecoration(

    prefixIcon:itemIcon,
    iconColor: Colors.white,
    hintText: hintText,

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
    filled: true,
    contentPadding: EdgeInsets.all(16),
    fillColor: Colors.white,
  );
}
BoxDecoration  containerBoxDecoration(){
  return BoxDecoration(
      border: Border.all(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20)
      )

  );

}

InputDecoration textFieldWithOutIconInputDecoration(String hintText) {
  //Icon(Icons.email)
  return InputDecoration(

    iconColor: Colors.white,
    hintText: hintText,
    hintStyle: forumTopicStyle(),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
    filled: true,
    contentPadding: EdgeInsets.all(16),
    fillColor: Colors.white,
  );
}

TextStyle biggerTextStyle() {
  return GoogleFonts.montserrat(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w400);
}
TextStyle buttonTextStyle() {
  return GoogleFonts.montserrat(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w400);
}
TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.grey, fontSize: 15);
}

TextStyle ChatListHeadingStyle() {
  return TextStyle(color: Colors.black, fontSize: 20);
}
TextStyle heading(){
  return GoogleFonts.nunitoSans(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w700);
}
TextStyle unitHeading(){
  return GoogleFonts.montserrat(fontSize: 17,color: Colors.black,fontWeight: FontWeight.w500);
}
TextStyle unitTextStyle(){
  return GoogleFonts.montserrat(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w400);
}
TextStyle profileTextStyle(){
  return GoogleFonts.pontanoSans(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w400);
}
TextStyle profilegreyTextStyle(){
  return GoogleFonts.pontanoSans(fontSize: 16,color: Colors.grey[250],fontWeight: FontWeight.w300);
}
TextStyle formTypeStyle(){
  return GoogleFonts.montserrat(fontSize: 12,color: Colors.grey[250],fontWeight: FontWeight.w300);
}
TextStyle forumTopicStyle(){
  return GoogleFonts.montserrat(fontSize: 14,color: Colors.black87,fontWeight: FontWeight.w400,);
}

Widget textWidget(String title, double fontsize, FontWeight fontweight,
    String fontfamily, var color, String align, bool underline) {
  return Text(
    title,
    textAlign: align == 'c' ? TextAlign.center : TextAlign.start,
    style: TextStyle(
      fontSize: fontsize,
      fontFamily: fontfamily,
      fontWeight: fontweight,
      decoration: underline ? TextDecoration.underline : TextDecoration.none,
      color: Color(color),
    ),
    overflow: TextOverflow.ellipsis,
    maxLines: 4,
  );
}
extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}
//
// logoutFun(context){
//   HelperFunctions.logout();
//   HelperFunctions.saveUserLoggedInSharedPreference(false);
//   Navigator.pushReplacement<void,void>(
//     context,
//     MaterialPageRoute<void>(
//       builder: (BuildContext context) =>  LoginScreen(),
//     ),
//   );
// }

