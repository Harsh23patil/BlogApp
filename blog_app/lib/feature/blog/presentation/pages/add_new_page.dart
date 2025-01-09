import 'dart:io';

import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/feature/blog/presentation/widgets/blog_editor.dart';
import 'package:blog_app/feature/blog/presentation/widgets/category_box.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddNewPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => AddNewPage(),
      );
  const AddNewPage({super.key});

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {
  final titleContoller = TextEditingController();
  final contentContoller = TextEditingController();
  List<String> selecteCategories = [];
  File? image;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleContoller.dispose();
    contentContoller.dispose();
  }

  void selectImage() async{
    final pickedImage = await pickImage(); 

    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.done_rounded,
            ),
          )
        ],
        // surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // dotted border box for image selection
              DottedBorder(
                color: AppPallete.borderColor,
                dashPattern: [10, 4],
                radius: const Radius.circular(10),
                borderType: BorderType.RRect,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  child: const Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_open_rounded,
                        size: 40,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Select your image",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      "Technology",
                      "Bussiness",
                      "Programming",
                      "Entertainment"
                    ]
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                if (selecteCategories.contains(e)) {
                                  selecteCategories.remove(e);
                                } else {
                                  selecteCategories.add(e);
                                }
                                setState(() {});
                              },
                              child: Chip(
                                label: Text(e),
                                color: selecteCategories.contains(e)
                                    ? const WidgetStatePropertyAll(
                                        AppPallete.gradient1)
                                    : null,
                                side: selecteCategories.contains(e)
                                    ? null
                                    : const BorderSide(
                                        color: AppPallete.borderColor,
                                      ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  )),
              // Blog title and bolg content writting.
              const SizedBox(
                height: 10,
              ),
              BlogEditor(
                controller: titleContoller,
                hintText: "Blog Title",
              ),
              const SizedBox(
                height: 10,
              ),
              BlogEditor(
                controller: contentContoller,
                hintText: "Blog Content",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
