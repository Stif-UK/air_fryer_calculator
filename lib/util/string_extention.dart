extension extString on String{
  bool get isAlphaNumericAndNotEmpty{
    final titleRegExp = RegExp(r"^[a-zA-Z0-9!£$&+()-.\s]+$");
    return titleRegExp.hasMatch(this);
  }

  bool get containsSale{
    final titleRegExp = RegExp(r'sale', caseSensitive: false);
    return titleRegExp.hasMatch(this);
  }

  bool get isValidTemp{
    bool result = false;
    //first check that the value is a number
    final titleRegExp = RegExp(r"^\d+$");
    bool isNumber =  titleRegExp.hasMatch(this);
    //then confirm the number is in the expected range
    if(isNumber){
      int number = int.parse(this);
      if(number >= 0 && number <= 450){
        result = true;
      }
    }
    return result;
  }

}