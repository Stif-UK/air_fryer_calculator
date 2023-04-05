extension extString on String{
  bool get isAlphaNumericAndNotEmpty{
    final titleRegExp = RegExp(r"^[a-zA-Z0-9!£$&+()-.\s]+$");
    return titleRegExp.hasMatch(this);
  }

}