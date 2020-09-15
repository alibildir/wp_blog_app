import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wp_blog_app/models/posts.dart';

class WpApi {
  static const api = "https://www.naijatechguy.com/wp-json/wp/v2/";
  static const listApi = "https://www.naijatechguy.com/wp-json/wp/v2/";
  static const headers = {"Accept": "application/json"};

  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  Future<List<Posts>> fetchTopPosts() async {
    var response = await http.get(
      Uri.encodeFull(api + "posts?_embed&categories=417"),
      headers: headers,
    );

    var convertDataToJson = jsonDecode(response.body);

    List<Posts> posts = [];

    convertDataToJson.forEach((post) {
      String title = _parseHtmlString(post['title']['rendered']);

      // if (title.length > 30) {
      //   title = _parseHtmlString(post['title']['rendered']).substring(0, 20) + "...";
      // }

      var time = post['date'];

      var content = _parseHtmlString(post['content']['rendered']);

      var imageUrl = post['_embedded']['wp:featuredmedia'] != null
          ? post['_embedded']['wp:featuredmedia'][0]['source_url']
          : Image.network(
              'assets/images/img_error.jpg',
            );

      posts.add(
          Posts(title: title, image: imageUrl, contents: content, time: time));
    });

    return posts;
  }

  // call for all Game articles
  Future<List<Posts>> fetchListPosts() async {
    var response = await http.get(
      Uri.encodeFull(listApi + "posts?_embed&categories=467"),
      headers: headers,
    );

    var convertDataToJson = jsonDecode(response.body);

    List<Posts> posts = [];

    convertDataToJson.forEach((post) {
      String title = _parseHtmlString(post['title']['rendered']);

      // if (title.length > 30) {
      //   title = _parseHtmlString(post['title']['rendered']).substring(0, 50) + "...";
      // }

      var content = _parseHtmlString(post['content']['rendered']);
      var time = post['date'];

      var imageUrl = post['_embedded']['wp:featuredmedia'] != null
          ? post['_embedded']['wp:featuredmedia'][0]['source_url']
          : Image.network(
              'assets/images/img_error.jpg',
              fit: BoxFit.cover,
              width: 100,
              height: 90,
            );

      // var time = post['date'];

      posts.add(
          Posts(title: title, image: imageUrl, contents: content, time: time));
    });

    return posts;
  }
}
