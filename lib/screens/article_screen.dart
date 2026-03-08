import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/post.dart';
import '../theme/app_theme.dart';

class ArticleScreen extends StatelessWidget {
  final Post post;

  const ArticleScreen({super.key, required this.post});

  String _formatDate(String dateStr) {
    if (dateStr.isEmpty) return '';
    try {
      final parsed = DateTime.tryParse(dateStr);
      if (parsed != null) {
        return DateFormat('MMM d, yyyy • h:mm a').format(parsed);
      }
      final timestamp = int.tryParse(dateStr);
      if (timestamp != null) {
        return DateFormat('MMM d, yyyy • h:mm a')
            .format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));
      }
    } catch (_) {}
    return dateStr;
  }

  Future<void> _openNewsUrl() async {
    final uri = Uri.parse(post.newsUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          post.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (post.thumbnailUrl.isNotEmpty)
              SizedBox(
                height: 220,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: post.thumbnailUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, err) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported, size: 48),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (post.publishedDate.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      _formatDate(post.publishedDate),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                  if (post.newsOverView.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Html(
                      data: post.newsOverView,
                      style: {
                        'body': Style(
                          fontSize: FontSize(14),
                          lineHeight: const LineHeight(1.6),
                          margin: Margins.zero,
                        ),
                      },
                    ),
                  ],
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _openNewsUrl,
                      icon: const Icon(Icons.open_in_new, size: 18),
                      label: const Text('Read more'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryRed,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
