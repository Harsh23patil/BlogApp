class Blog {
  final String id;
  final String posetrId;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final DateTime updatedDateTime;

  Blog({
    required this.id,
    required this.posetrId,
    required this.title,
    required this.content,
    required this.topics,
    required this.imageUrl,
    required this.updatedDateTime,
  });
}
