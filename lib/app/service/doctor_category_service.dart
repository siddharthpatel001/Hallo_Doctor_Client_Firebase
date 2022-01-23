import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hallo_doctor_client/app/models/doctor_category_model.dart';

class DoctorCategoryService {
  FirebaseFirestore? _instance;

  final List<DoctorCategory> _doctorCategory = [];

  List<DoctorCategory> get getCategories => _doctorCategory;

  Future<List<DoctorCategory>> getListDoctorCategory() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference doctorCategory =
        _instance!.collection('DoctorCategory');

    QuerySnapshot snapshot = await doctorCategory.get();

    final allData = snapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      data['categoryId'] = doc.reference.id;
      return data;
    });

    for (var category in allData) {
      DoctorCategory doc = DoctorCategory.fromJson(category);
      _doctorCategory.add(doc);
    }

    return _doctorCategory;
  }
}
