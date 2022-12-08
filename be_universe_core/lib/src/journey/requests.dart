part of be_universe_core;

@JsonSerializable(createFactory: false)
class JourneyProgressRequest {
  const JourneyProgressRequest({
    required this.user,
    required this.id,
  });

  final String user;
  final String id;

  Map<String, dynamic> toJson() => _$JourneyProgressRequestToJson(this);
}
