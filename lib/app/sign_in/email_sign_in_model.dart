
enum EmailSignInFormType {signIn,register}
class EmailSignInModel {
  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool submitted;
  final bool isLoading;

  EmailSignInModel({this.email = 'abc@email.com', this.password = 'password', this.formType=EmailSignInFormType.signIn, this.submitted = false, this.isLoading = false});


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