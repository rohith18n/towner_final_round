import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:towner_final_round/model/student_model.dart';

class DatabaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final DatabaseHelper instence = DatabaseHelper._internal();
  factory DatabaseHelper() => instence;
  DatabaseHelper._internal();

  Future<Rx<Student>> addToStudentTable(Student student) async {
    final docRef = _firestore.collection('cars').doc();
    student.id = docRef.id;
    // Reference to a new document
    final studentRx = Rx<Student>(
        Student(age: '', batch: '', name: '', imagePath: '', regnum: ''));

    try {
      docRef.set(Student.toJson(student)).then((_) {
        // After successfully setting the document, listen for changes
        docRef.snapshots().listen((snapshot) {
          if (snapshot.exists) {
            studentRx.value = Student.fromStudent(snapshot.data()!).value;
          } else {
            studentRx.value = Student(
                age: '',
                batch: '',
                name: '',
                imagePath: '',
                regnum: ''); // Empty student
          }
        });
      });
    } catch (e) {
      log('Error adding student to Firestore: $e');
    }

    return studentRx;
  }

  Future<List<Map<String, dynamic>>> getAllStudent() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('cars').get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      log('Error fetching students: $e');
      return []; // Return an empty list in case of error
    }
  }

  Future<void> deleteStudent(String id) async {
    try {
      // Get a reference to the document with the specified ID
      final DocumentReference documentReference =
          _firestore.collection('cars').doc(id.toString());

      // Delete the document
      await documentReference.delete();
    } catch (e) {
      log('Error deleting student: $e');
      // Handle error as needed
    }
  }

  Future<void> updateStudent(Student student) async {
    try {
      // Get a reference to the document with the student's ID
      final DocumentReference documentReference =
          _firestore.collection('cars').doc(student.id);

      // Update the document with the new data
      await documentReference.update(Student.toJson(student));
    } catch (e) {
      log('Error updating student: $e');
      // Handle error as needed
    }
  }
}
