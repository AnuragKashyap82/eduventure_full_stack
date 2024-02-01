class PostMsgModel {
  String classCode;
  String classMsg;
  String dateTime;
  int msgId;
  String attachment;
  bool isAttachment;
  String studentId;

  PostMsgModel({
    required this.classCode,
    required this.classMsg,
    required this.dateTime,
    required this.msgId,
    required this.attachment,
    required this.isAttachment,
    required this.studentId,
  });

  // Factory method to create an instance from a JSON map
  factory PostMsgModel.fromJson(Map<String, dynamic> json) {
    return PostMsgModel(
      classCode: json['classCode'] ?? '',
      classMsg: json['classMsg'] ?? '',
      dateTime: json['dateTime'] ?? '',
      msgId: json['msgId'] ?? 0,
      attachment: json['attachment'] ?? '',
      isAttachment: json['isAttachment'] ?? false,
      studentId: json['studentId'] ?? '',
    );
  }

  // Method to convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'classCode': classCode,
      'classMsg': classMsg,
      'dateTime': dateTime,
      'msgId': msgId,
      'attachment': attachment,
      'isAttachment': isAttachment,
      'studentId': studentId,
    };
  }
}
