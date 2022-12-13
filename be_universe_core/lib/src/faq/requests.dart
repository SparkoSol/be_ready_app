part of be_universe_core;

@JsonSerializable(createFactory: false)
class ContactUsRequest {
  const ContactUsRequest(
      {required this.email,
      required this.subject,
      required this.message,
      required this.attachment});

  final String email;
  final String subject;
  final String message;
  final String attachment;

  Map<String, dynamic> toJson() => _$ContactUsRequestToJson(this);
}
