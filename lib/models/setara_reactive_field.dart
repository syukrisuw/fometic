enum SetaraReactiveFieldType {
  stringType,
  numericType,
  dateType,
  timeType,
  dateTimeType,
  customType,
  emailType,
  urlType,
  buttonType,
  spacerType //To make sure button separation
}

typedef ButtonPressedCallback = void Function();
typedef ValueChangedCallback = void Function(String);
typedef ValidationCallback = String? Function(String);

class SetaraReactiveField {
  //Can be maximum 8 field in single row
  final int columnFactor; //valid value will be 1, 2, 3 ,4 , ... 8
  final String labelText;
  final String? hintText;
  final String? errorMessage;
  final dynamic? controller;
  final SetaraReactiveFieldType type;
  final ButtonPressedCallback? onPressed;
  final ValueChangedCallback? onValueChanged;
  final ValidationCallback? validation;
  String stringValue = "";
  int _intValue = 0;
  double _doubleValue = 0.0;

  SetaraReactiveField(
      { //Reactive Field to be used in Setara Form Card
      this.columnFactor = 8, //default fill all width or 8 section
      required this.labelText,
      this.hintText = "",
      this.errorMessage = "",
      this.controller,
      this.onPressed,
      this.onValueChanged,
      this.validation,
      this.type = SetaraReactiveFieldType.stringType //default type string input
      });

  int get intValue => _intValue;

  set intValue(int value) {
    _intValue = value;
    stringValue = value.toString();
  }

  double get doubleValue => _doubleValue;

  set doubleValue(double value) {
    _doubleValue = value;
    stringValue = value.toString();
  }

  String toJsonString() {
    return '"labelText":"$stringValue"';
  }
}
