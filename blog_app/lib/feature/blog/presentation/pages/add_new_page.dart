import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/feature/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/feature/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/feature/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final formKey = GlobalKey<FormState>();
  List<String> selecteCategories = [];
  File? image;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleContoller.dispose();
    contentContoller.dispose();
  }

  void selectImage() async {
    final pickedImage = await pickImage();

    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBloc() {
    if (formKey.currentState!.validate() &&
        selecteCategories.isNotEmpty &&
        image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(BlogUpload(
            posterId: posterId,
            title: titleContoller.text.trim(),
            content: contentContoller.text.trim(),
            image: image!,
            topics: selecteCategories,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              uploadBloc();
            },
            icon: Icon(
              Icons.done_rounded,
            ),
          )
        ],
        // surfaceTintColor: Colors.transparent,
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is BlogFailure) {
            showSnackbar(context, state.error);
          }
          if (state is BlogUploadSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              BlogPage.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if(state is BlogLoading){
            return Loader();
          }
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // dotted border box for image selection
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: DottedBorder(
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
        },
      ),
    );
  }
}
