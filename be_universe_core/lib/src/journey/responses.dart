part of be_universe_core;

@JsonSerializable(createToJson: false)
class JourneyResponse {
  JourneyResponse({
    required this.title,
    required this.description,
    required this.type,
    required this.audioName,
  });

  final String title;
  final String description;
  final String type;
  @JsonKey(name: 'audio_name')
  final String audioName;

  factory JourneyResponse.fromJson(_Json json) =>
      _$JourneyResponseFromJson(json);
}
