part of be_universe_core;

@JsonSerializable(createToJson: false)
class ResourceResponse {
  const ResourceResponse(
      {required this.description,
      required this.title,
      required this.filename,
      required this.thumbnail,
      required this.type,
      required this.likeBy,
      required this.likeCount});

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
  @JsonKey(name: 'like_by')
  final List<String> likeBy;

  factory ResourceResponse.fromJson(_Json json) {
    return _$ResourceResponseFromJson(json);
  }
}
