class RegisterParams{
  final String _email, _name,_password;

  const RegisterParams({
    required String email,
    required String name,
    required String password,
}): _email = email,
  _name= name,
  _password = password;

  Map<String, dynamic> toJson()=>{
    'email' : _email,
    'password':_password,
    'name' : _name
  };
}