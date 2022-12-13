part of be_universe_core;

@JsonSerializable(createToJson: false)
class FaqResponse {
  FaqResponse({
    required this.title,
    required this.description,
  });

  factory FaqResponse.fromJson(_Json json) => _$FaqResponseFromJson(json);

  final String description;
  final String title;

  @override
  bool operator ==(Object other) {
    if (other is! FaqResponse) return false;
    return other.title == title;
  }

  @override
  int get hashCode => title.hashCode;
}

@JsonSerializable(createToJson: false)
class SaveFileResponse {
  SaveFileResponse({
    required this.name,
    required this.path,
  });

  final String name;

  final String path;

  factory SaveFileResponse.fromJson(_Json json) =>
      _$SaveFileResponseFromJson(json);
}
