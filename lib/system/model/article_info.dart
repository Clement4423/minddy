import 'package:flutter/material.dart';

class ArticleInfo {
  String title;
  String readingTime;
  String author;
  String path;
  IconData icon;
  bool isBookmarked;

  ArticleInfo(this.title, this.readingTime, this.author,this.isBookmarked, this.icon, this.path);
}