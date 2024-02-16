class Student_Details {
  final String studentId;
  final String studentReg;
  final String studentName;
  final String studentBranch;
  final String studentGender;

  const Student_Details({
    this.studentId = "",
    this.studentReg = '',
    this.studentName = "",
    this.studentBranch = "",
    this.studentGender = '',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'studentId': studentId,
      'studentReg': studentReg,
      'studentName': studentName,
      'studentBranch': studentBranch,
      'studentGender': studentGender,
    };
  }

  factory Student_Details.fromMap(Map<String, dynamic> json) {
    return Student_Details(
      studentId: json['studentId'] ?? '',
      studentReg: json['studentReg'] ?? '',
      studentName: json['studentName'] ?? '',
      studentBranch: json['studentBranch'] ?? '',
      studentGender: json['studentGender'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Student_Details(studentId:$studentId, studentReg:$studentReg,: $studentName, studentBranch: $studentBranch,studentGender:$studentGender';
  }
}
