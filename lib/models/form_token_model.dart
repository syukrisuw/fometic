class FormToken {
  final int primaryId;
  final String sessionId;
  final String tokenId;
  final int status;
  final String createdDtm;
  final String updateDtm;
  final String expireDtm;

  FormToken({
    required this.primaryId,
    required this.sessionId,
    required this.tokenId,
    required this.status,
    required this.createdDtm,
    required this.updateDtm,
    required this.expireDtm,
  });

  factory FormToken.fromJson(Map<String, dynamic> json) {
    return FormToken(
      primaryId: json['sessionTokensId'],
      sessionId: json['sessionId'],
      tokenId: json['csrfTokenId'],
      status: 1,
      createdDtm: "",
      updateDtm: "",
      expireDtm: "",
    );
  }

  String toJsonString() {
    return '{"primaryId":$primaryId, "sessionId":"$sessionId", "tokenId":"$tokenId",'
        ' "status":$status, "createdDtm":"$createdDtm", "updateDtm":"$updateDtm", "expireDtm":"$expireDtm" }';
  }
}