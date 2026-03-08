class Post {
  final String title;
  final String newsUrl;
  final String thumbnailUrl;
  final String newsOverView;
  final String publishedDate;
  final String? videoUrl;

  Post({
    required this.title,
    required this.newsUrl,
    required this.thumbnailUrl,
    required this.newsOverView,
    required this.publishedDate,
    this.videoUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'] ?? '',
      newsUrl: json['newsUrl'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      newsOverView: json['newsOverView'] ?? '',
      publishedDate: json['publishedDate'] ?? '',
      videoUrl: json['videoUrl'],
    );
  }
}
