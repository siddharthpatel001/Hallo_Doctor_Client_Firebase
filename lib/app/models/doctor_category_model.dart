class DoctorCategory {
  String? categoryId;
  String? categoryName;
  String? iconUrl;
  DoctorCategory({this.categoryId, this.categoryName, this.iconUrl});

  static const String _categoryName = 'categoryName';
  static const String _iconUrl = 'iconUrl';
  static const String _categoryId = 'categoryId';

  factory DoctorCategory.fromJson(Map<String, dynamic> data) {
    return DoctorCategory(
      categoryId: data[_categoryId],
      categoryName: data[_categoryName],
      iconUrl: data[_iconUrl],
    );
  }
}
