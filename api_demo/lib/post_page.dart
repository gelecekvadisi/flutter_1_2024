import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/post_model.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  late Future<List<PostModel>> postList;

  @override
  void initState() {
    super.initState();
    postList = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Page"),
      ),
      body: FutureBuilder(
        future: postList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<PostModel> postList = snapshot.data!;

            return ListView.separated(
              itemCount: postList.length,
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemBuilder: (context, index) {
                PostModel currentPost = postList[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(currentPost.id.toString()),
                  ),
                  title: Text(currentPost.title.toString()),
                  subtitle: Text(currentPost.body.toString()),
                  trailing: Text(currentPost.userId.toString()),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Hata: ${snapshot.error}"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<List<PostModel>> fetchData() async {
    List<PostModel> postList = [];
    try {
      String postUrl = "https://jsonplaceholder.typicode.com/posts";
      // http.Response response = await http.get(Uri.parse(postUrl));
      // postList = (jsonDecode(response.body) as List)
      //     .map((e) => PostModel.fromJson(e))
      //     .toList();
      Response response = await Dio().get(postUrl);
      postList = (response.data as List)
          .map((e) => PostModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
    }

    return postList;
  }
}
