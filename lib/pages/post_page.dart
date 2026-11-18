import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/post.dart';
import 'post_detail_page.dart';

class ApiService {
  static const String _postsUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(_postsUrl));

    if (response.statusCode != 200) {
      throw Exception('Gagal memuat data (${response.statusCode})');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((item) => Post.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final ApiService _api = ApiService();
  late Future<List<Post>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _futurePosts = _api.fetchPosts(); // dipanggil sekali saat layar dibuat
  }

  // Dipakai tombol refresh dan tombol "Coba lagi"
  void _reload() {
    setState(() {
      _futurePosts = _api.fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Post'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _reload),
        ],
      ),
      body: FutureBuilder<List<Post>>(
        future: _futurePosts,
        builder: (context, snapshot) {
          // Kondisi 1: error
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wifi_off, size: 48),
                    const SizedBox(height: 12),
                    Text(
                      'Terjadi kesalahan:\n${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _reload,
                      child: const Text('Coba lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          // Kondisi 2: masih loading
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // Kondisi 3: data siap
          final posts = snapshot.data!;

          if (posts.isEmpty) {
            return const Center(child: Text('Belum ada data'));
          }

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, i) {
              final post = posts[i];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(child: Text('${post.id}')),
                  title: Text(
                    post.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    post.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PostDetailPage(post: post),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
