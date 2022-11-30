part of be_universe_core;

// @JsonSerializable(createToJson: false)
// class PaginatedResource {
//   PaginatedResource();
//
//   List<ResourceResponse>? data;
//
//   factory PaginatedResource.fromJson(Map<String, dynamic> json) =>
//       _$PaginatedResourceFromJson(json);
// }

@JsonSerializable(createToJson: false)
class ResourceResponse {
  const ResourceResponse(
      {required this.description,
      required this.title,
      required this.filename,
      required this.thumbnail,
      required this.type,
      required this.liked,
      required this.likeCount,
      required this.createdAt,
      required this.id,
      required this.authorName,
      required this.updateAt});

  @JsonKey(name: 'filename')
  final String filename;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'thumbnail')
  final String thumbnail;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'like_count')
  final int likeCount;
  @JsonKey(name: 'liked')
  final bool liked;
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'createdAt')
  final String createdAt;
  @JsonKey(name: 'updatedAt')
  final String updateAt;
  @JsonKey(name: 'author_name')
  final String? authorName;

  factory ResourceResponse.fromJson(_Json json) {
    return _$ResourceResponseFromJson(json);
  }
}

@JsonSerializable(createToJson: false)
class ResourceCountResponse {
  const ResourceCountResponse(
      {required this.articles,
      required this.audios,
      required this.quotes,
      required this.books,
      required this.podcasts,
      required this.videos});

  @JsonKey(name: 'Article')
  final int? articles;
  @JsonKey(name: 'Video')
  final int? videos;
  @JsonKey(name: 'Audio')
  final int? audios;
  @JsonKey(name: 'Book')
  final int? books;
  @JsonKey(name: 'Podcast')
  final int? podcasts;
  @JsonKey(name: 'Quote')
  final int? quotes;

  factory ResourceCountResponse.fromJson(_Json json) {
    return _$ResourceCountResponseFromJson(json);
  }
}
