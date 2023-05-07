import 'package:social_flutter_app/models/post_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class PostRepository{
  final String _url = 'https://social-app-23978.firebaseio.com';

  Future<bool> createPost( PostModel post ) async {
    final url = Uri(path: '$_url/post.json');
    final resp = await http.post( url, body: postModelToJson(post) );
    final decodedData = json.decode(resp.body);
    print( decodedData );
    return true;
  }

  Future<List<PostModel>> getPost() async {

    final url = Uri(path: '$_url/post.json');
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<PostModel> posts = new List();


    if ( decodedData == null ) return [];

    decodedData.forEach( ( id, prod ){

      final postTemp = PostModel.fromJson(prod);
      posts.add( postTemp );

    });
    print( posts[0].userName );
    return posts;

  }

}
