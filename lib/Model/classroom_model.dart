class ClassroomModel {
  String classCode;
  String className;
  String subjectName;
  String studentId;
  String name;

  ClassroomModel({
    required this.classCode,
    required this.className,
    required this.subjectName,
    required this.studentId,
    required this.name,
  });

  // Static method to create an instance with empty values
  static ClassroomModel empty() => ClassroomModel(
        classCode: '',
        className: '',
        subjectName: '',
        studentId: '',
        name: '',
      );

  // Method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'classCode': classCode,
      'className': className,
      'subjectName': subjectName,
      'studentId': studentId,
      'name': name,
    };
  }

  // Factory method to create an instance from a Firestore DocumentSnapshot
  factory ClassroomModel.fromJson(Map<String, dynamic> data) {
    return ClassroomModel(
      classCode: data['classroom']['classCode'] ?? '',
      className: data['classroom']['className'] ?? '',
      subjectName: data['classroom']['subjectName'] ?? '',
      studentId: data['classroom']['studentId'] ?? '',
      name: data['classroom']['name'] ?? '',
    );
  }
}
