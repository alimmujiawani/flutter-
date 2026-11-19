import 'package:flutter/material.dart';
import 'package:flutter_ikbal/models/comments_post.dart';

class CommentsDetail extends StatelessWidget {
  final Comments post;

  const CommentsDetail({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comments #${post.id}')),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.name, style: Theme.of(context).textTheme.titleLarge),

            const SizedBox(height: 12),

            Text(post.body, style: Theme.of(context).textTheme.bodyMedium),

            const SizedBox(height: 24),

            Text(
              'Email: ${post.email}',
              style: Theme.of(context).textTheme.bodySmall,
            ),

            const SizedBox(height: 8),

            Text(
              'Post ID: ${post.postId}',
              style: Theme.of(context).textTheme.bodySmall,
            ),

            const SizedBox(height: 8),

            Text(
              'Comment ID: ${post.id}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
