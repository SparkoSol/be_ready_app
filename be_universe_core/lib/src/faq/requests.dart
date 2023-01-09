part of be_universe_core;

@JsonSerializable(createFactory: false)
class ContactUsRequest {
  ContactUsRequest(
      {required this.email,
      required this.subject,
      required this.message,
      this.attachment});

  final String email;
  final String subject;
  final String message;
  @JsonKey(includeIfNull: false)
  String? attachment;

  Map<String, dynamic> toJson() => _$ContactUsRequestToJson(this);
}
