
class IssueBookModel {
  String authorName;
  String bookId;
  String bookName;
  String subjectName;
  String appliedDate;
  String returnedDate;
  String issueDate;
  String status;
  String issueId;
  String timestamp;
  String uid;
  String name;
  String studentId;
  String photoUrl;
  String email;

  IssueBookModel({
    required this.authorName,
    required this.bookId,
    required this.bookName,
    required this.subjectName,
    required this.appliedDate,
    required this.returnedDate,
    required this.issueDate,
    required this.status,
    required this.issueId,
    required this.timestamp,
    required this.uid,
    required this.name,
    required this.studentId,
    required this.photoUrl,
    required this.email,
  });

  // Static method to create an instance with empty values
  static IssueBookModel empty() => IssueBookModel(
    authorName: '',
    bookId: '',
    bookName: '',
    subjectName: '',
    appliedDate: '',
    returnedDate: '',
    issueDate: '',
    status: '',
    issueId: '',
    timestamp: '',
    uid: '',
    name: '',
    studentId: '',
    photoUrl: '',
    email: '',
  );

  // Method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'authorName': authorName,
      'bookId': bookId,
      'bookName': bookName,
      'subjectName': subjectName,
      'appliedDate': appliedDate,
      'returnedDate': returnedDate,
      'issueDate': issueDate,
      'status': status,
      'issueId': issueId,
      'timestamp': timestamp,
      'uid': uid,
      'name': name,
      'studentId': studentId,
      'photoUrl': photoUrl,
      'email': email,
    };
  }

  // Factory method to create an instance from a Firestore DocumentSnapshot
  factory IssueBookModel.fromJson(Map<String, dynamic> data) {

      return IssueBookModel(
        authorName: data['authorName'] ?? '',
        bookId: data['bookId'] ?? '',
        bookName: data['bookName'] ?? '',
        subjectName: data['subjectName'] ?? '',
        appliedDate: data['appliedDate'] ?? '',
        returnedDate: data['returnedDate'] ?? '',
        issueDate: data['issueDate'] ?? '',
        status: data['status'] ?? '',
        issueId: data['issueId'] ?? '',
        timestamp: data['timestamp'] ?? '',
        uid: data['uid'] ?? '',
        name: data['name'] ?? '',
        studentId: data['studentId'] ?? '',
        photoUrl: data['photoUrl'] ?? '',
        email: data['email'] ?? '',
      );
  }
}
