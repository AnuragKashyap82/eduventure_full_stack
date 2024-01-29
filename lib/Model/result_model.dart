
class ResultModel {
  String semester;
  String resultYear;
  String branch;
  String resultUrl;
  String dateTime;
  String resultId;

  ResultModel({
    required this.semester,
    required this.resultYear,
    required this.branch,
    required this.resultUrl,
    required this.dateTime,
    required this.resultId,
  });

  // Static method to create an instance with empty values
  static ResultModel empty() => ResultModel(
    semester: '',
    resultYear: '',
    branch: '',
    resultUrl: '',
    dateTime: '',
    resultId: '',
  );

  // Method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'semester': semester,
      'resultYear': resultYear,
      'branch': branch,
      'resultUrl': resultUrl,
      'dateTime': dateTime,
      'resultId': resultId,
    };
  }

  // Factory method to create an instance from a Firestore DocumentSnapshot
  factory ResultModel.fromJson(Map<String, dynamic> data)
  {
      return ResultModel(
        semester: data['semester'] ?? '',
        resultYear: data['resultYear'] ?? '',
        branch: data['branch'] ?? '',
        resultUrl: data['resultUrl'] ?? '',
        dateTime: data['dateTime'] ?? '',
        resultId: data['resultId'] ?? '',
      );
  }
}
