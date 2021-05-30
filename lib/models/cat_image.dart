class CatImage {
  final String id;
  final String url;

  CatImage({required this.id, required this.url});

  factory CatImage.fromJson(Map<String, dynamic> json) {
    return CatImage(
      id: json['id'],
      url: json['url'],
    );
  }
}
