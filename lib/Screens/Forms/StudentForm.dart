import 'package:flutter/material.dart';
import 'package:students_details/Model/Student_Details.dart';
import 'package:students_details/bloc/bloc.dart';
import 'package:students_details/bloc/helper.dart';
import '/Screens/studentdetailsscreen.dart';

class StudentForm extends StatefulWidget {
  final bool isComingFromEditing;
  final Student_Details studentDetails;

  const StudentForm({
    this.isComingFromEditing = false,
    this.studentDetails = const Student_Details(),
    super.key,
  });

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _studentRegController = TextEditingController();
  final TextEditingController _studentBranchController =
      TextEditingController();
  String dropdownValue = 'Laki-laki';

  void _storeStudentDetailsHandler() {
    studentBloc.addStudent(
      studentDetails: Student_Details(
        studentId: widget.isComingFromEditing
            ? widget.studentDetails.studentId
            : helper.getRandomString(10),
        studentName: _studentNameController.text,
        studentBranch: _studentBranchController.text,
        studentReg: _studentRegController.text,
        studentGender: dropdownValue,
      ),
      isComingFromEditing: widget.isComingFromEditing,
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.isComingFromEditing) {
      _studentNameController.text = widget.studentDetails.studentName;
      _studentRegController.text = widget.studentDetails.studentReg;
      _studentBranchController.text = widget.studentDetails.studentBranch;
      dropdownValue = widget.studentDetails.studentGender;
    }
    studentBloc.isDataSuccess.listen((event) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StudentDetails(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
            Text(widget.isComingFromEditing ? 'Ubah Mahasiswa' : 'Tambah Mahasiswa'),
      ),
      body: _buildStudentFormUI(),
    );
  }

  Widget _buildStudentFormUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        children: [
          TextField(
            controller: _studentNameController,
            decoration: const InputDecoration(
              hintText: 'Masukan Nama',
              labelText: 'Nama',
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _studentRegController,
            decoration: const InputDecoration(
              hintText: 'Masukan NPM',
              labelText: 'NPM',
            ),
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Jenis kelamin:'),
                  DropdownButton<String>(
                    value: dropdownValue,
                    items: <String>['Laki-laki', 'Perempuan']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          TextField(
            controller: _studentBranchController,
            decoration: const InputDecoration(
              hintText: 'Masukan kelas',
              labelText: 'Kelas',
            ),
          ),
          const SizedBox(height: 15),
          _buildButtonUI()
        ],
      ),
    );
  }

  Widget _buildButtonUI() {
    return ElevatedButton(
      onPressed: _storeStudentDetailsHandler,
      child: Text(
        widget.isComingFromEditing
            ? 'Update'.toUpperCase()
            : 'Add'.toUpperCase(),
      ),
    );
  }
}
