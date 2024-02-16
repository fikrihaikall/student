import 'package:flutter/material.dart';
import 'package:students_details/Screens/Forms/StudentForm.dart';
import 'package:students_details/Model/Student_Details.dart';
import 'package:students_details/bloc/bloc.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key});

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  @override
  int indexs = 0;
  List<Student_Details> studentDetailsData = [];
  var validateStudentName = '';

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      studentBloc.getStudentDetails();
    });
    studentBloc.studentList.listen((event) {
      if (mounted) {
        setState(() {
          studentDetailsData = event;
        });
      }
    });
    super.initState();
  }

  void _studentFormHandler() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StudentForm(),
      ),
    );
  }

  void _updateIndex(int newIndex, Student_Details employeeDetails) {
    setState(() {
      indexs = newIndex;

      validateStudentName = employeeDetails.studentName;
    });
  }

  void _editStudentDetailsHandler(Student_Details studentDetail) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentForm(
          isComingFromEditing: true,
          studentDetails: studentDetail,
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail data mahasiswa'),
      ),
      body: Column(
        children: [
          _buildBodyUI(),
          // studentDetailsData.isNotEmpty
          //     ? _buildStudentDetailsUI()
          //     : const SizedBox(
          //         child: Center(
          //           child: Text('No Data'),
          //         ),
          //       )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _studentFormHandler,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBodyUI() {
    return StreamBuilder<List<Student_Details>>(
      stream: studentBloc.studentList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          studentDetailsData = snapshot.data!;
          return studentDetailsData.isNotEmpty
              ? _buildStudentDetailsUI()
              : const SizedBox();
        }
        return const Expanded(
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Expanded _buildStudentDetailsUI() {
    return Expanded(
      child: ListView.builder(
        itemCount: studentDetailsData.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(children: [
              _buildcardUI(studentDetailsData[index]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        _updateIndex(index, studentDetailsData[index]);
                        _editStudentDetailsHandler(studentDetailsData[indexs]);
                      },
                      icon: const Icon(Icons.edit_rounded)),
                  IconButton(
                      onPressed: () {
                        _updateIndex(index, studentDetailsData[index]);
                        print(index);
                        studentDetailsData.remove(studentDetailsData[indexs]);
                        print(studentDetailsData);
                      },
                      icon: const Icon(Icons.delete))
                ],
              )
            ]),
          );
        },
      ),
    );
  }

  Card _buildcardUI(Student_Details studentDetails) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            margin: const EdgeInsets.only(right: 45),
            alignment: Alignment.topLeft,
            child: (studentDetails.studentGender == 'Laki-laki')
                ? const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/premium-vector/graduate-student-avatar-student-student-icon-flat-design-style-education-graduation-isolated-student-icon-white-background-vector-illustration-web-application-printing_153097-1566.jpg?w=2000'),
                    minRadius: 45,
                  )
                : const CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://png.pngtree.com/element_our/png_detail/20181208/female-student-icon-png_265422.jpg',
                    ),
                    minRadius: 45,
                  ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${studentDetails.studentName}',
                  style: TextStyle(fontSize: 20, fontFamily: 'Open Sans'),
                ),
                Text(
                  '${studentDetails.studentGender}',
                  style: TextStyle(fontSize: 20, fontFamily: 'Open Sans'),
                ),
                Text(
                  '${studentDetails.studentReg}',
                  style: TextStyle(fontSize: 20, fontFamily: 'Open Sans'),
                ),
                Text(
                  'Kelas:${studentDetails.studentBranch}'.toUpperCase(),
                  style: TextStyle(fontSize: 20, fontFamily: 'Open Sans'),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
