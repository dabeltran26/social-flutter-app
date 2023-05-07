import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_flutter_app/blocs/post/post_event.dart';
import 'package:social_flutter_app/blocs/post/post_state.dart';
import 'package:social_flutter_app/models/post_model.dart';
import 'package:social_flutter_app/repository/post_repository.dart';

class PostBloc extends Bloc<PostEvent,PostState> {

  final PostRepository _postRepository;

  PostBloc({@required PostRepository postRepository})
      :assert (postRepository != null),
        _postRepository = postRepository, super(null);

  @override
  PostState get initialState => InitState();


  @override
  Stream<PostState> mapEventToState(PostEvent event) async*{
    if(event is GetPost){
      yield* _mapGetPost();
    }

    if(event is CreatePost){
      yield* _mapCreatePost(event.post);
    }
  }
  
  Stream<PostState> _mapGetPost() async* {
    yield LoadingPosts();
    try {
      List<PostModel> posts = await _postRepository.getPost();
      yield GetPosts(posts);
    } catch (_) {
      yield LoadingPosts();
    }
  }

  Stream<PostState> _mapCreatePost(PostModel post) async* {
    yield LoadingPosts();
    try {
      bool created = await _postRepository.createPost(post);
      if(created){
        List<PostModel> posts = await _postRepository.getPost();
        yield GetPosts(posts);
      }
    } catch (_) {
      yield LoadingPosts();
    }
  }

}