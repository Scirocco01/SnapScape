

import 'package:ehisaab_2/ViewModel/user_credentials_view_model.dart';
import 'package:flutter/material.dart';

import '../../../Config/size_config.dart';
import '../../../Config/text.dart';

class UserCredentialPageTwo extends StatefulWidget {
  final UserCredentialsViewModel viewModel;
  const UserCredentialPageTwo({
    Key? key, required this.viewModel,
  }) : super(key: key);

  @override
  State<UserCredentialPageTwo> createState() => _UserCredentialPageTwoState();
}

class _UserCredentialPageTwoState extends State<UserCredentialPageTwo> {
  @override

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PrimaryText(text: 'What do you to see in TodoKlikkers?',size:32, color:Colors.black,fontWeight: FontWeight.w500,),
        const SizedBox(height: 10,),
        SizedBox(
          width: double.infinity,
          height:SizeConfig.screenHeight! * 0.50,
          child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 1.5,
              shrinkWrap: true,
              children:List.generate(widget.viewModel.userEntertainment.length, (index) {
                return Center(
                  child: SelectCard(text: widget.viewModel.userEntertainment[index],
                    callback: (val ) {
                    print('this is the value of void callback $val');

                    }, ),
                );
              }
              ) ,
          ),
        )




      ],
    );
  }
}


class SelectCard extends StatefulWidget {
   SelectCard({ Key? key, required this.text,  required this.callback}) : super(key: key);
  final String text;
  final Function(String val) callback;

  @override
  State<SelectCard> createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  var list = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        String data = widget.text;
        setState((){
          if(list.contains(data)){
            list.remove(data);
          }
          else {
            list.add(data);
          }
        });
        widget.callback(data);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side:const BorderSide(
            color: Color(0xffdce7f0),
            width: 1.5,
          )
        ),
        elevation: 0,
          color: list.contains(widget.text)?const Color(0xffe65b0c):Colors.white,
          child:  Padding(
            padding: const EdgeInsets.only(left: 5.0,bottom: 8.0),
            child: Column(

                children: <Widget>[
                  if(list.contains(widget.text))
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(Icons.check_circle,color: Colors.white,)
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PrimaryText(text: widget.text,
                      color: list.contains(widget.text)?Colors.white:Colors.black,
                      ),
                    ],
                  )
                ]
            ),
          ),

      ),
    );
  }
}