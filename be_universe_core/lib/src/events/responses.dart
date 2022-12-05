part of be_universe_core;

@JsonSerializable(createToJson: false)
class EventsResponse {
  EventsResponse({
    required this.name,
    required this.date,
    required this.imageName,
    required this.location,
  });

  @JsonKey(name: 'image_name')
  final String imageName;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'location')
  final String location;
  @JsonKey(name: 'date')
  final String date;
  // @JsonKey(name: 'participate_by')
  // final List<String> participants;

  factory EventsResponse.fromJson(_Json json) => _$EventsResponseFromJson(json);
}
