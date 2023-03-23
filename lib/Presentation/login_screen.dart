
import 'package:ehisaab_2/Config/size_config.dart';
import 'package:flutter/material.dart';

import '../Config/text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color(0xFFf2f7f9),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height:100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                PrimaryText(text: 'ToDo',color: Color(0xFF35499a),size: 30,fontWeight: FontWeight.w700,),
                PrimaryText(text: 'KliKKers',color:Color(0xFFea8136),size:30,fontWeight: FontWeight.w700,)

              ],
            ),
            const SizedBox(
              height: 150,
            ),
            const PrimaryText(text: 'Loreem Ipsum \n dolor sit amet',color: Color(0xFF696a6a),size:40,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 10),
            const PrimaryText(text: 'Share your story connect to Hive!',color:Color(0xFF95a4b0)),
             
             const SizedBox(
               height: 50,
             ),

             Card(
               elevation: 5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white
                    ),
                    onPressed: (){},
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:   const [
                            Icon(Icons.g_mobiledata_rounded,color: Colors.greenAccent,size: 32,),
                            PrimaryText(text: 'register through google',color: Color(0xFF949494),),
                          ],
                        ),
                      ),

                ),
                  )),
            SizedBox(height: 10,),
            Card(
                elevation: 5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black
                  ),
                  onPressed: (){},
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:   [
                          Icon(Icons.g_mobiledata_rounded,color: Colors.greenAccent,size: 32,),
                          PrimaryText(text: 'Register with Apple',color: Colors.white,),
                        ],
                      ),
                    ),

                  ),
                )),
            SizedBox(height: 10,),
            Card(
                elevation: 5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white
                  ),
                  onPressed: (){},
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:   const [
                          Icon(Icons.g_mobiledata_rounded,color: Colors.greenAccent,size: 32,),
                          PrimaryText(text: 'Register through Mobile ',color: Color(0xFF949494),),
                        ],
                      ),
                    ),

                  ),
                )),
            SizedBox(height: SizeConfig.screenHeight! * 0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryText(text: 'Alraedy a user? ',color: Color(0xFF9dacb7),),
                PrimaryText(text: 'Log In.',color:Color(0xFF4baada),fontWeight: FontWeight.w600,)
              ],
            )

          ],
        ),
      )
    );
  }
}
