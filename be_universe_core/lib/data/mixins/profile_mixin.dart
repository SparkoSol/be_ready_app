part of be_universe_core;

mixin ProfileMixin {
  static late Box<ProfileResponse> _box;

  static Future<void> initialize() async {
    _box = await Hive.openBox<ProfileResponse>('user');
  }

  bool get isLogin => _box.isNotEmpty;

  ProfileResponse readLastUser() {
    // return UserModel(id: '636558237fcb30a73c0a8828', username: 'username');
    if (_box.isEmpty) {
      throw ('No Record Found');
    } else {
      return _box.values.last;
    }
  }

  static Future<void> clearUsers() async {
    if (_box.isNotEmpty) await _box.clear();
  }

  Future<void> saveUser(ProfileResponse userData) async {
    await clearUsers();
    await _box.add(userData);
    await userData.save();
  }
}
