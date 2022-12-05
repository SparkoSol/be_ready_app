part of be_universe_core;

@JsonSerializable(createToJson: false)
class ActivitiesResponse {
  ActivitiesResponse({
    required this.title,
    required this.duration,
    required this.icon,
  });

  final String title;
  final String duration;
  final String icon;

  factory ActivitiesResponse.fromJson(_Json json) =>
      _$ActivitiesResponseFromJson(json);
}
