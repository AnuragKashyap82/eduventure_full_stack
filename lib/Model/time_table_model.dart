class TimetableModel {
  String id;
  String semester;
  String branch;
  String dayName;
  String subName;
  String subCode;
  String facultyUid;
  String startTime;
  String endTime;
  String facultyName;

  TimetableModel({
    required this.id,
    required this.semester,
    required this.branch,
    required this.dayName,
    required this.subName,
    required this.subCode,
    required this.facultyUid,
    required this.startTime,
    required this.endTime,
    required this.facultyName,
  });

  // Static method to create an instance with empty values
  static TimetableModel empty() =>
      TimetableModel(
        id: '',
        semester: '',
        branch: '',
        dayName: '',
        subName: '',
        subCode: '',
        facultyUid: '',
        startTime: '',
        endTime: '',
        facultyName: '',
      );

  // Method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'semester': semester,
      'branch': branch,
      'dayName': dayName,
      'subName': subName,
      'subCode': subCode,
      'facultyUid': facultyUid,
      'startTime': startTime,
      'endTime': endTime,
      'facultyName': facultyName,
    };
  }

  // Factory method to create an instance from a Firestore DocumentSnapshot
  factory TimetableModel.fromJson(Map<String, dynamic> data)
  {
    return TimetableModel(
      id: data['id'] ?? '',
      semester: data['semester'] ?? '',
      branch: data['branch'] ?? '',
      dayName: data['dayName'] ?? '',
      subName: data['subName'] ?? '',
      subCode: data['subCode'] ?? '',
      facultyUid: data['facultyUid'] ?? '',
      startTime: data['startTime'] ?? '',
      endTime: data['endTime'] ?? '',
      facultyName: data['facultyName'] ?? '',
    );
  }
}