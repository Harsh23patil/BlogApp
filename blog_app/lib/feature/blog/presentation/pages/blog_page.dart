import 'package:blog_app/feature/blog/presentation/pages/add_new_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog App"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewPage.route());
            },
            icon: Icon(
              CupertinoIcons.add_circled,
            ),
          ),
        ],
        // centerTitle: true,
      ),
    );
  }
}
