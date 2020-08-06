
import 'package:time_tracker_application/app/sign_in/validators.dart';

enum EmailSignInFormType {signIn,register}
class EmailSignInModel with EmailAndPasswordValidators{
  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool submitted;
  final bool isLoading;

  EmailSignInModel({this.email = 'abc@email.com', this.password = 'password', this.formType=EmailSignInFormType.signIn, this.submitted = false, this.isLoading = false});

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn ? 'Sign In':'Create an account';
  }

  bool get canSubmit {
   return emailvalidator.isValid(email) && !isLoading && emailvalidator.isValid(password);

  }

  String get passwordErrorText {
    bool passwordValid = submitted && !emailvalidator.isValid(password);
    return passwordValid ? invalidPasswordErrorText : null;
  }

  String get emailErrorText {
    bool emailValid = submitted && !emailvalidator.isValid(email);
    return emailValid ? invalidEmailErrorText : null;
  }
  String get secondaryButtonText {
  return  formType == EmailSignInFormType.signIn ? 'Need an account? Register' : 'Have an account? Register';}
  EmailSignInModel copyWith ({
    String email,
    String password,
    bool isLoading,
    bool submitted,
    EmailSignInFormType formType
}) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,




    );
  }


}