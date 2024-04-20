class UpdatePostParams{
  final String _title,_body;
  final int id;

  const UpdatePostParams({
    required String title,
    required String body,
    required this.id,
}) : _title = title,

  _body = body;

  Map<String, dynamic> toJson()=> {
    'title':_title,
    'body' : _body
  };
}