class Article {
  final String id;
  final String title;
  final String source;
  final String content;
  final String imgURL;
  final String publshedAt;
  bool isBookmark;

  Article(this.id, this.title, this.source, this.content, this.imgURL,
      this.publshedAt,
      [this.isBookmark = false]);
}
