part of be_universe_core;

@JsonSerializable(createToJson: false)
class DailyCheckInResponse {
  DailyCheckInResponse(
      {required this.userId,
      required this.myBodyFeels,
      required this.myMindFeels,
      required this.mySpiritFeels,
      required this.createdAt});

  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'my_mind_feels')
  final int myMindFeels;
  @JsonKey(name: 'my_body_feels')
  final int myBodyFeels;
  @JsonKey(name: 'my_spirit_feels')
  final int mySpiritFeels;
  final String createdAt;

  factory DailyCheckInResponse.fromJson(_Json json) =>
      _$DailyCheckInResponseFromJson(json);
}
