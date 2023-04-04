
import 'dart:io';
import 'package:ehisaab_2/ViewModel/user_credentials_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  var _image;
  final picker = ImagePicker();

  Future getImage()async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if(pickedFile != null){
        _image  = File(pickedFile.path);
        widget.viewModel.selectPhoto(_image);

      }
      else{
        print('no image Selected');
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children:  [

             GestureDetector(
               onTap:getImage,
               child: Container(
                 decoration: BoxDecoration(
                   borderRadius: const BorderRadius.all(Radius.circular(180)),
                   border:Border.all(
                     color:Colors.black,
                   )

                 ),
                 child: _image != null ? ClipOval(child: Image.file(_image,fit: BoxFit.cover,)): CircleAvatar(
                   backgroundColor: Colors.white,
                   backgroundImage:  const AssetImage('Assets/profile_photo_icon.png'),
                   radius: _image != null? 180: 60,


                    ),
               ),
             ),
            const SizedBox(height: 10,),
            
             PrimaryText(text: _image == null? 'Click Above to add Profile Photo':'Great now click next')


          ],
      ),
    );
  }
}


