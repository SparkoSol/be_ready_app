part of be_universe_core;

@JsonSerializable(createToJson: false)
class FaqResponse {
  FaqResponse(
      {required this.title, required this.description, required this.id});

  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String description;

  factory FaqResponse.fromJson(_Json json) => _$FaqResponseFromJson(json);
}
