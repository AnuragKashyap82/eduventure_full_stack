class SubmissionModel {
  String id;
  String assignmentId;
  String assignmentName;
  String classCode;
  String dueDate;
  String fullMarks;
  String dateTime;
  String submissionUrl;
  String studentId;
  String marksObtained;

  SubmissionModel({
    required this.id,
    required this.assignmentId,
    required this.assignmentName,
    required this.classCode,
    required this.dueDate,
    required this.fullMarks,
    required this.dateTime,
    required this.submissionUrl,
    required this.studentId,
    required this.marksObtained,
  });

  // Factory method to create an instance from a JSON map
  factory SubmissionModel.fromJson(Map<String, dynamic> json) {
    return SubmissionModel(
      id: json['_id'] ?? '',
      assignmentId: json['assignmentId'] ?? '',
      assignmentName: json['assignmentName'] ?? '',
      classCode: json['classCode'] ?? '',
      dueDate: json['dueDate'] ?? '',
      fullMarks: json['fullMarks'] ?? '',
      dateTime: json['dateTime'] ?? '',
      submissionUrl: json['submissionUrl'] ?? '',
      studentId: json['studentId'] ?? '',
      marksObtained: json['marksObtained'] ?? '',
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
      'submissionUrl': submissionUrl,
      'studentId': studentId,
      'marksObtained': marksObtained,
    };
  }
}
