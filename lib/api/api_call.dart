import 'dart:convert';
import 'dart:io';

import 'package:flutter_news_app/model/news_model.dart';
import 'package:flutter_news_app/util/failure.dart';
import 'package:http/http.dart' as http;

class ApiCallClass{
  Future<List<Article>> getNews() async{
    try{
      final news = await http.get(
        Uri.parse(
          "https://newsapi.org/v2/everything?q=tesla&from=2021-04-14&sortBy=publishedAt&apiKey=423af7e1453848ac861d8dbb27d5c3de")
        );

        if(news.statusCode == 200){
          final Iterable rawJson = jsonDecode(news.body)["articles"];
          return rawJson.map((article) => Article.fromJson(article)).toList();
        }else{
          throw Failure(message: news.body.toString());
        }
    } on SocketException{
      throw Failure(message:"You are not connected to the Internet");
    } catch(error){
      throw Failure(message:error.toString());
    }
  }
}
