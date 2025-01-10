import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/feature/blog/domain/entities/blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) => MaterialPageRoute(
        builder: (context) => BlogViewerPage(
          blog: blog,
        ),
      );
  final Blog blog;
  BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blog.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                blog.posterName ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                '${blog.updatedDateTime.toString()}  ${calculateReadingTime(blog.content)}min',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppPallete.greyColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(
                  blog.imageUrl,
                ),
              ),
              Text(
                blog.content,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
