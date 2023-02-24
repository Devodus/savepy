import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import 'package:savepy/app/UiElements/widget.dart';
import 'package:savepy/app/modules/auth/views/login_view.dart';
import 'package:savepy/app/modules/auth/views/registration_view.dart';


class SplashTwo extends StatefulWidget {
  @override
  State<SplashTwo> createState() => _SplashTwoState();
}

class _SplashTwoState extends State<SplashTwo> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child:


                ClipOval(
                  child:Image.asset("assets/images/undrawsavings.png",
                    height: 150,
                    width: 150,
                    fit:BoxFit.fitWidth,),
                ),



              ),
              SizedBox(height: 15,),
              Text("Easy To Access",style: heading(),),
              SizedBox(height: 5,),
              Padding(padding: EdgeInsets.all(17),child: Text("SavePy an innovative solution that connects users to savings and investment opportunities. ",style: profileTextStyle(),textAlign: TextAlign.justify,),),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150.0,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(

                          backgroundColor: MaterialStateProperty.all<Color>(HexColor(blue_color)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(color: HexColor(blue_color))
                              )
                          )
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => RegistrationView()));


                      },
                      child: Text(
                        "New User",
                        style: TextStyle(color: Colors.white),
                      ),

                    ),
                  ),
                  SizedBox(
                    width: 10.0,),

                  SizedBox(
                    width: 150.0,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(

                          backgroundColor: MaterialStateProperty.all<Color>(HexColor(blue_color)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(color: HexColor(blue_color))
                              )
                          )
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => LoginView()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),

                    ),
                  ),
                ],
              )
            ],
          ),
        )
    )
    ;
  }
}
