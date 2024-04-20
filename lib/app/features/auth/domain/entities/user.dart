abstract class User{
  final int id;
  final String name,email,token;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.token
});

  Map<String, dynamic> toJson();
}