import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:social_flutter_app/blocs/authentication/authentication_event.dart';
import 'package:social_flutter_app/blocs/post/post_bloc.dart';
import 'package:social_flutter_app/blocs/post/post_event.dart';
import 'package:social_flutter_app/blocs/post/post_state.dart';
import 'package:social_flutter_app/common/colors.dart';
import 'package:social_flutter_app/models/post_model.dart';
import 'package:social_flutter_app/repository/post_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PostRepository _postRepository = PostRepository();
  int currentPage = 0;
  PostBloc _bloc;
  File photo;

  PostModel post = PostModel(
    userName: "david",
    userPhoto: "https://s3.amazonaws.com/uifaces/faces/twitter/rpatey/128.jpg",
    caption: "Hoal mundo",
    postPhoto: "https://static.vix.com/es/sites/default/files/styles/1x1/public/imj/p/paisajes-espectaculares-del-mundo-1.jpg",
    date: "lunes 16",
  );

  @override
  void initState() {
    _bloc = PostBloc(postRepository: _postRepository);
    _bloc.add(GetPost());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GeneralColors.white,
      appBar: _appBar(),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is GetPosts) {
            return SingleChildScrollView(child: currentPageHome(state.posts));
          }

          return Container();
        },
      ),
      bottomNavigationBar: _tabBar(),
    );
  }

  Widget currentPageHome(List<PostModel> posts) {
    if (currentPage == 0) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _posts(posts),
          ],
        ),
      );
    }

    if (currentPage == 1) {
      return Center(
        child: Container(
          child: Text('Buscador'),
        ),
      );
    }

    if (currentPage == 2) {
      return Container(
        padding: EdgeInsets.all(15.0),
        child: Form(
          child: Column(
            children: [
              _mostrarFoto(),
              _createCaption(),
              _createDate(),
              _createButton(),
            ],
          ),
        ),
      );
    }

    if (currentPage == 3) {
      return Center(
        child: Container(
          child: Text('Mis likes'),
        ),
      );
    }

    if (currentPage == 4) {
      return Center(
        child: Container(
          child: Column(
            children: [
              Text('Perfil'),
              Text('Cerrar sesion'),
              IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: GeneralColors.black,
                  size: 28,
                ),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                },
              )
            ],
          ),
        ),
      );
    }

    return Container();
  }

  Widget _createCaption() {
    return TextFormField(
      initialValue: post.caption,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Post description'),
      onSaved: (value) => post.caption = value,
    );
  }

  Widget _createDate() {
    return TextFormField(
      initialValue: post.date,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Post date'),
      onSaved: (value) => post.date = value,
    );
  }

  Widget _createButton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: GeneralColors.blue,
      textColor: GeneralColors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: _submit,
    );
  }

  void _submit() async {
     _bloc.add(CreatePost(post: post));
  }

  Widget _mostrarFoto() {
    if (post.postPhoto != null) {
      return FadeInImage(
        image: NetworkImage(post.postPhoto),
        placeholder: AssetImage('assets/loading.gif'),
        height: 300.0,
        fit: BoxFit.contain,
      );
    } else {
      return Image(
        image: AssetImage(photo?.path ?? 'assets/heart.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  _selectPhoto() async {
    _buildImage(ImageSource.gallery);
  }

  _getPhoto() async {
    _buildImage(ImageSource.camera);
  }

  _buildImage(ImageSource origen) async {
    photo = await ImagePicker.pickImage(source: origen);

    if (photo != null) {
      post.postPhoto = null;
    }

    setState(() {});
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: GeneralColors.white,
      elevation: 0,
      centerTitle: true,
      title: Container(
        margin: EdgeInsets.only(top: 10),
        child: SizedBox(
            height: 40,
            child: Text(
              'Social App',
              style: TextStyle(color: GeneralColors.black, fontSize: 28),
            )),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon( Icons.photo_size_select_actual ),
          onPressed: _selectPhoto,
          color: GeneralColors.black,
          iconSize: 35,
        ),
        IconButton(
          icon: Icon( Icons.camera_alt ),
          onPressed: _getPhoto,
          color: GeneralColors.black,
          iconSize: 35,
        ),
      ],
    );
  }

  Widget _posts(List<PostModel> posts) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: posts.length,
          itemBuilder: (context, i) {
            return _buildPosts(posts[i]);
          }),
    );
  }

  Widget _buildPosts(PostModel post) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 12, left: 18, bottom: 12, right: 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(
                          image: NetworkImage(post.userPhoto),
                          height: 45,
                          width: 45,
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Text(
                  post.userName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Expanded(child: SizedBox()),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz),
                  iconSize: 30,
                )
              ],
            ),
          ),
          FadeInImage(
              placeholder: AssetImage('assets/img/loading.gif'),
              image: NetworkImage(post.postPhoto)),
          Container(
            padding: EdgeInsets.only(
              top: 5,
              left: 7,
              right: 7,
              bottom: 1,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Image(
                        image: AssetImage('assets/heart.png'),
                        width: 26,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image(
                        image: AssetImage('assets/comment.png'),
                        width: 26,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image(
                        image: AssetImage('assets/send.png'),
                        width: 26,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image(
                    image: AssetImage('assets/save_o.png'),
                    width: 26,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 17,
              right: 17,
              bottom: 10,
            ),
            child: Column(
              children: <Widget>[
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "${post.userName} ",
                        style: TextStyle(
                            color: GeneralColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    TextSpan(
                      text: "${post.caption} ",
                      style: TextStyle(
                        color: GeneralColors.black,
                      ),
                    ),
                    TextSpan(
                      text: "${post.date} ",
                      style: TextStyle(
                        color: GeneralColors.black,
                      ),
                    )
                  ]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _tabBar() {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: GeneralColors.black, width: 0.75))),
      child: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: currentPage,
        selectedItemColor: GeneralColors.blue,
        iconSize: 28,
        elevation: 0,
        onTap: (i) {
          setState(() {
            currentPage = i;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(AntDesign.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.search),
            title: Text("Buscar"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.plus_square),
            title: Text("Cargar"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.heart),
            title: Text("Likes"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.user),
            title: Text("Cuenta"),
          ),
        ],
      ),
    );
  }
}
