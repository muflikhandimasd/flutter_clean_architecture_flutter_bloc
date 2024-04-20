class CreatePostParams{
  final String _title,_body;

  const CreatePostParams({
    required String title,
    required String body,
}) : _title = title,
  _body = body;

  Map<String, dynamic> toJson()=> {
    'title':_title,
    'body' : _body
  };
}