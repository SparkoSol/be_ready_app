part of be_universe_core;

@JsonSerializable(createToJson: false)
class JourneyResponse {
  JourneyResponse(
      {required this.title,
      required this.description,
      required this.type,
      required this.audioName,
      required this.id});

  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String description;
  final String type;
  @JsonKey(name: 'audio_name')
  final String audioName;

  factory JourneyResponse.fromJson(_Json json) =>
      _$JourneyResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class JourneyProgressResponse {
  JourneyProgressResponse(
      {required this.mind, required this.body, required this.spirit});

  final double mind;
  final double body;
  final double spirit;

  factory JourneyProgressResponse.fromJson(_Json json) =>
      _$JourneyProgressResponseFromJson(json);
}
