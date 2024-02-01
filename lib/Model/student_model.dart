class StudentModel {
  String id;
  String name;
  String email;
  String studentId;
  String attendence;

  StudentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.studentId,
    required this.attendence,
  });

  // Static method to create an instance with empty values
  static StudentModel empty() => StudentModel(
    id: '',
    name: '',
    email: '',
    studentId: '',
    attendence: '',
  );

  // Method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'studentId': studentId,
      'attendence': attendence,
    };
  }

  // Factory method to create an instance from JSON data
  factory StudentModel.fromJson(Map<String, dynamic> data) {
    return StudentModel(
      id: data['_id'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      studentId: data['studentId'] ?? '',
      attendence: data['attendence'] ?? '',
    );
  }
}
