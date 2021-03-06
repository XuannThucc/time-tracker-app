abstract class StringValidator {
  bool isValid(String value);
}
class NonEmptyStringValidator implements StringValidator{
  @override
  bool isValid(String value){
    return value.isNotEmpty;
  }
}
class EmmailAndPasswordValidators{
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
}