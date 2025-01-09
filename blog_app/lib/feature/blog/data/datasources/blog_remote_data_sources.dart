import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/feature/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSources {
  Future<BlogModel> uploadBlogs({BlogModel blog});
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });
}

class BlogRemoteDataSourcesImpl implements BlogRemoteDataSources {
  SupabaseClient supabaseClient;
  BlogRemoteDataSourcesImpl(this.supabaseClient);
  @override
  Future<BlogModel> uploadBlogs({BlogModel? blog}) async {
    try {
      if (blog != null) {
        final blogData =
            await supabaseClient.from('blogs').insert(blog!.toJson()).select();

        return BlogModel.fromJson(blogData.first);
      }
      throw ServerException("Blog data might be null");
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage.from('blog_image').upload(
            blog.id,
            image,
          );
      return supabaseClient.storage.from('blog_image').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
