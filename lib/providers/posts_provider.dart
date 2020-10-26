

import 'package:social_flutter_app/models/post_model.dart';

class PostProvider {
  List<PostModel> posts = new List();

  List<PostModel> getPosts() {
    posts = [
      new PostModel(
        userName: "Hermina",
        userPhoto: "https://s3.amazonaws.com/uifaces/faces/twitter/frankiefreesbie/128.jpg",
        caption: "Maiores cupiditate aliquid. Neque sint est. Quasi quam architecto officiis quas sequi reiciendis.",
        postPhoto: "https://static.vix.com/es/sites/default/files/styles/1x1/public/imj/p/paisajes-espectaculares-del-mundo-1.jpg",
        date: "Julio 26",
      ),
      new PostModel(
        userName: "Blake",
        userPhoto:
            "https://s3.amazonaws.com/uifaces/faces/twitter/frankiefreesbie/128.jpg",
        caption:
            "Maiores cupiditate aliquid. Neque sint est. Quasi quam architecto officiis quas sequi reiciendis.",
        postPhoto: "https://static.vix.com/es/sites/default/files/styles/1x1/public/imj/p/paisajes-espectaculares-del-mundo-1.jpg",
        date: "Julio 15",
      ),
      new PostModel(
        userName: "Caitlyn",
        userPhoto:
            "https://s3.amazonaws.com/uifaces/faces/twitter/imammuht/128.jpg",
        caption:
            "Maiores cupiditate aliquid. Neque sint est. Quasi quam architecto officiis quas sequi reiciendis.",
        postPhoto: "https://static.vix.com/es/sites/default/files/styles/1x1/public/imj/p/paisajes-espectaculares-del-mundo-1.jpg",
        date: "Julio 20",
      ),
      new PostModel(
        userName: "Kyleigh",
        userPhoto:
            "https://s3.amazonaws.com/uifaces/faces/twitter/peachananr/128.jpg",
        caption:
            "Maiores cupiditate aliquid. Neque sint est. Quasi quam architecto officiis quas sequi reiciendis.",
        postPhoto: "https://static.vix.com/es/sites/default/files/styles/1x1/public/imj/p/paisajes-espectaculares-del-mundo-1.jpg",
        date: "Julio 30",
      ),
      new PostModel(
        userName: "Kayley",
        userPhoto:
            "https://s3.amazonaws.com/uifaces/faces/twitter/rpatey/128.jpg",
        caption:
            "Maiores cupiditate aliquid. Neque sint est. Quasi quam architecto officiis quas sequi reiciendis.",
        postPhoto: "https://static.vix.com/es/sites/default/files/styles/1x1/public/imj/p/paisajes-espectaculares-del-mundo-1.jpg",
        date: "Julio 16",
      ),
      new PostModel(
        userName: "Shawn",
        userPhoto:
            "https://s3.amazonaws.com/uifaces/faces/twitter/vitorleal/128.jpg",
        caption:
            "Maiores cupiditate aliquid. Neque sint est. Quasi quam architecto officiis quas sequi reiciendis.",
        postPhoto: "https://static.vix.com/es/sites/default/files/styles/1x1/public/imj/p/paisajes-espectaculares-del-mundo-1.jpg",
        date: "Julio 11",
      ),
      new PostModel(
        userName: "Arturo",
        userPhoto:
            "https://s3.amazonaws.com/uifaces/faces/twitter/ChrisFarina78/128.jpg",
        caption:
            "Maiores cupiditate aliquid. Neque sint est. Quasi quam architecto officiis quas sequi reiciendis.",
        postPhoto: "https://static.vix.com/es/sites/default/files/styles/1x1/public/imj/p/paisajes-espectaculares-del-mundo-1.jpg",
        date: "Julio 29",
      ),
      new PostModel(
        userName: "Alize",
        userPhoto:
            "https://s3.amazonaws.com/uifaces/faces/twitter/wikiziner/128.jpg",
        caption:
            "Maiores cupiditate aliquid. Neque sint est. Quasi quam architecto officiis quas sequi reiciendis.",
        postPhoto: "https://static.vix.com/es/sites/default/files/styles/1x1/public/imj/p/paisajes-espectaculares-del-mundo-1.jpg",
        date: "Julio 01",
      ),
      new PostModel(
        userName: "Sylvan",
        userPhoto:
            "https://s3.amazonaws.com/uifaces/faces/twitter/d_nny_m_cher/128.jpg",
        caption:
            "Maiores cupiditate aliquid. Neque sint est. Quasi quam architecto officiis quas sequi reiciendis.",
        postPhoto: "https://static.vix.com/es/sites/default/files/styles/1x1/public/imj/p/paisajes-espectaculares-del-mundo-1.jpg",
        date: "Julio 05",
      )
    ];

    return posts;
  }
}
