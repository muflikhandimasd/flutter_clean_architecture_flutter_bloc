class LoginParams{
  final String _email,_password;

  const LoginParams({
    required String email,
    required String password,
}): _email = email,
  _password = password;

  Map<String, dynamic> toJson()=>{
    'email' : _email,
    'password':_password
  };
}