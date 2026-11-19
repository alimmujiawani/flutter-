import 'dart:async';
import 'dart:convert';

import 'package:flutter_ikbal/models/comments_post.dart';
import 'package:http/http.dart' as http;

import '../constants/comments_constants.dart';

class CommentsServices {
  Future<List<Comments>> fetchComments() async {
    final url = Uri.parse(
      '${CommentsConstants.baseUrl}${CommentsConstants.postsEndpoint}',
    );

    try {
      // 1. Minta data dari API
      final response = await http.get(url).timeout(const Duration(seconds: 10));

      // 2. Cek status response
      if (response.statusCode == 200) {
        // 3. Decode JSON
        final List data = jsonDecode(response.body);

        // 4. Ubah JSON menjadi List Comments
        return data.map((e) => Comments.fromJson(e)).toList();
      } else {
        throw Exception('Gagal memuat data (kode: ${response.statusCode})');
      }
    } on TimeoutException {
      throw Exception('Koneksi terlalu lama. Coba lagi.');
    } on http.ClientException {
      throw Exception('Terjadi kesalahan koneksi.');
    }
  }
}
