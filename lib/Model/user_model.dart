
class UserModel {
  String name;
  String email;
  String completeAddress;
  String dob;
  String regNo;
  String branch;
  String semester;
  String session;
  String seatType;
  String photoUrl;
  String userType;
  String studentId;
  String phoneNo;
  String token;
  bool isVerified;

  UserModel({
    required this.name,
    required this.email,
    required this.completeAddress,
    required this.dob,
    required this.regNo,
    required this.branch,
    required this.semester,
    required this.session,
    required this.seatType,
    required this.photoUrl,
    required this.userType,
    required this.studentId,
    required this.phoneNo,
    required this.token,
    required this.isVerified,

  });

  // Static method to create an instance with empty values
  static UserModel empty() => UserModel(
    name: '',
    email: '',
    completeAddress: '',
    dob: '',
    regNo: '',
    branch: '',
    semester: '',
    session: '',
    seatType: '',
    photoUrl: '',
    userType: '',
    studentId: '',
    phoneNo: '',
    token: '',
    isVerified: false,
  );

  // Method to convert the object to a Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'completeAddress': completeAddress,
      'dob': dob,
      'regNo': regNo,
      'branch': branch,
      'semester': semester,
      'session': session,
      'seatType': seatType,
      'photoUrl': photoUrl,
      'userType': userType,
      'studentId': studentId,
      'phoneNo': phoneNo,
      'token': token,
      'isVerified': isVerified,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      completeAddress: json['completeAddress'] ?? '',
      dob: json['dob'] ?? '',
      regNo: json['regNo'] ?? '',
      branch: json['branch'] ?? '',
      semester: json['semester'] ?? '',
      session: json['session'] ?? '',
      seatType: json['seatType'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      userType: json['userType'] ?? '',
      studentId: json['studentId'] ?? '',
      phoneNo: json['phoneNo'] ?? '',
      token: json['token'] ?? '',
      isVerified: json['isVerified'] ?? false,
    );
  }

}
