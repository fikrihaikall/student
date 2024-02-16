import 'package:rxdart/rxdart.dart';
import 'package:students_details/Model/Student_Details.dart';

class StudentBloc {
  final PublishSubject<List<Student_Details>> _studentList =
      PublishSubject<List<Student_Details>>();
  Stream<List<Student_Details>> get studentList => _studentList.stream;

  final PublishSubject<bool> _isDataSuccess = PublishSubject<bool>();
  Stream<bool> get isDataSuccess => _isDataSuccess.stream;

  List<Student_Details> list = [];

  void addStudent({
    required Student_Details studentDetails,
    required bool isComingFromEditing,
  }) {
    if (isComingFromEditing) {
      int getIndex = list.indexWhere(
        (element) => element.studentId == studentDetails.studentId,
      );
      list[getIndex] = studentDetails;
    } else {
      list.add(studentDetails);
    }
    _isDataSuccess.sink.add(true);
  }

  void getStudentDetails() {
    _studentList.sink.add(list);
  }
}

StudentBloc studentBloc = StudentBloc();
