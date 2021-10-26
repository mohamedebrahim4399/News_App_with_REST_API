import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app_with_rest_api/models/news_model.dart';

class ApiManager {
  // https://newsapi.org/v2/everything?domains=wsj.com&apiKey=396bab257f7441c3b0709194f8ede731
  Future<NewsModel> getNews() async{
    var clint = http.Client();
    NewsModel? newsModel;
    try{
   var response= await clint.get(Uri.https('newsapi.org', '/v2/everything',
        {'domains': 'wsj.com', 'apiKey': '396bab257f7441c3b0709194f8ede731'}));

   if(response.statusCode == 200){
      var body =response.body;
      var jsonMap =json.decode(body);
      newsModel = NewsModel.fromJson(jsonMap);
   }}on Exception{
      return newsModel!;
    }
    return newsModel!;
  }
}
