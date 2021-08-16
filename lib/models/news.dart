class News {
  final String source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  const News({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  static List<News> fromJson(dynamic json) {
    List<News> news = [];

    for (var data in json) {
      // jika gambar atau deskripsi null, maka skip
      if (data['url'] == null || data['urlToImage'] == null) {
        continue;
      }

      news.add(News(
        source: data['source']['name'] ?? 'Sumber tidak diketahui',
        author: data['author'] ?? 'Penulis tidak diketahui',
        title: data['title'] ?? 'Tidak ada judul',
        description: data['description'] ?? 'Tidak ada deskripsi',
        url: data['url'],
        urlToImage: data['urlToImage'],
        publishedAt: DateTime.parse(data['publishedAt']),
        content: data['content'] ?? 'Tidak ada konten',
      ));
    }

    return news;
  }
}
