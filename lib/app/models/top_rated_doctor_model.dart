class TopRatedDoctorModel {
  TopRatedDoctorModel({this.doctorId, this.id});
  String? doctorId;
  String? id;

  factory TopRatedDoctorModel.fromMap(Map<String, dynamic> data) {
    return TopRatedDoctorModel(doctorId: data['doctorId'], id: data['id']);
  }
}
