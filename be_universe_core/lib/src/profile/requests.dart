part of be_universe_core;

@JsonSerializable(createFactory: false)
class ProfileUpdateRequest {
  const ProfileUpdateRequest({
    required this.name,
    required this.image,
  });

  final String name;
  final String image;

  Map<String, dynamic> toJson() => _$ProfileUpdateRequestToJson(this);
}
