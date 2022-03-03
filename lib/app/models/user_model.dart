class UserModel {
  UserModel({this.displayName, this.photoUrl, this.userId, this.doctorId});
  String? displayName;
  String? photoUrl;
  String? userId;
  String? doctorId;

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
        displayName: jsonData['displayName'],
        photoUrl: jsonData['photoUrl'],
        userId: jsonData['userId'],
        doctorId: jsonData['doctorId']);
  }
}
