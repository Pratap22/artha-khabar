import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/app_constants.dart';
import '../models/category.dart';
import '../models/post.dart';

class ApiService {
  final String _baseUrl = AppConstants.baseUrl;

  Future<List<Category>> getCategories() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/categories'))
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Category.fromJson(json as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Post>> getRecentPosts() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/posts'))
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Post.fromJson(json as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Post>> getPostsByCategory(int categoryId, {int count = 20}) async {
    try {
      final countClamped = count.clamp(1, 100);
      final response = await http
          .get(Uri.parse('$_baseUrl/get-category/$categoryId/$countClamped'))
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Post.fromJson(json as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
