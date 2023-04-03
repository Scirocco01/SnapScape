



String? validateName(String? value){
  if(value!.isEmpty){
    return '*Required Field';
  } else if(value.length < 3){
    return 'Name is too short';
  } else {
    return null;
  }

}

String? validateNum(String? value){
  String pattern = r'(^[1-9-0 ]*$)';
  RegExp regExp = RegExp(
      pattern

  );
  if(value!.isEmpty){
    return '*Required Field';
  } else if(!regExp.hasMatch(value)) {
    return 'should be numeric';
  } else {
    return null;
  }
}

String? validateContact(String? value){
  String pattern = r'(^[1-9-0 ]*$)';
  RegExp regExp = RegExp(
      pattern

  );
  if(value!.isEmpty){
    return '*Required Field';
  } else if(!regExp.hasMatch(value)) {
    return 'should be numeric';
  } else if(value.length>11){
    return 'should be less then 11 digits';
  }else {
    return null;
  }
}