class AssignmentModel {
  int id;
  int assignmentId;
  String assignmentName;
  String classCode;
  String dueDate;
  String fullMarks;
  String dateTime;
  String assignmentUrl;
  String studentId;

  AssignmentModel({
    required this.id,
    required this.assignmentId,
    required this.assignmentName,
    required this.classCode,
    required this.dueDate,
    required this.fullMarks,
    required this.dateTime,
    required this.assignmentUrl,
    required this.studentId,
  });

  // Factory method to create an instance from a JSON map
  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      id: json['_id'] ?? '',
      assignmentId: json['assignmentId'] ?? '',
      assignmentName: json['assignmentName'] ?? '',
      classCode: json['classCode'] ?? '',
      dueDate: json['dueDate'] ?? '',
      fullMarks: json['fullMarks'] ?? '',
      dateTime: json['dateTime'] ?? '',
      assignmentUrl: json['assignmentUrl'] ?? '',
      studentId: json['studentId'] ?? '',
    );
  }

  // Method to convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'assignmentId': assignmentId,
      'assignmentName': assignmentName,
      'classCode': classCode,
      'dueDate': dueDate,
      'fullMarks': fullMarks,
      'dateTime': dateTime,
      'assignmentUrl': assignmentUrl,
      'studentId': studentId,
    };
  }
}
