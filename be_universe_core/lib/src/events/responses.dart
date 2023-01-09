part of be_universe_core;

@JsonSerializable(createToJson: false)
class EventsResponse {
  EventsResponse(
      {required this.name,
      required this.date,
      required this.imageName,
      required this.location,
      required this.description});

  @JsonKey(name: 'image_name')
  final String imageName;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'location')
  final String location;
  @JsonKey(name: 'date')
  final String date;
  final String description;
  // @JsonKey(name: 'participate_by')
  // final List<String> participants;

  factory EventsResponse.fromJson(Json json) => _$EventsResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class BannerResponse {
  BannerResponse({
    required this.title,
    required this.imageName,
  });

  @JsonKey(name: 'image_name')
  final String imageName;

  final String title;

  factory BannerResponse.fromJson(Json json) => _$BannerResponseFromJson(json);
}
