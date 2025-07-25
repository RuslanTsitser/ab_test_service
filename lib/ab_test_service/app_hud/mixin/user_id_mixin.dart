mixin UserIdMixin {
  String? _userId;

  void setUserId(String userId) {
    _userId = userId;
  }

  String? get userId => _userId;
}
