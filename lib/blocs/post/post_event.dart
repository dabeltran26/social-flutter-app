import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:social_flutter_app/models/post_model.dart';

abstract class PostEvent extends Equatable{
  const PostEvent();
  @override
  List<Object> get props => [];
}

class CreatePost extends PostEvent{
  final PostModel post;
  const CreatePost({@required this.post});

  @override
  List<Object> get props => [];
}


class GetPost extends PostEvent{
  @override
  List<Object> get props => [];
}