
import 'package:equatable/equatable.dart';
import 'package:social_flutter_app/models/post_model.dart';

class PostState  extends Equatable{
  @override
  List<Object> get props => [];
}

class InitState extends PostState{}

class GetPosts extends PostState{
  final List<PostModel> posts;
  GetPosts(this.posts);
  @override
  List<Object> get props => [];
}

class LoadingPosts extends PostState{}