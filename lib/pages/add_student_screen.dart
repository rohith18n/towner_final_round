// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:towner_final_round/controllers/id_card_controller.dart';
import 'package:towner_final_round/controllers/student_controller.dart';
import 'package:towner_final_round/database/database_helper.dart';
import 'package:towner_final_round/model/student_model.dart';
import '../widgets/id_card_widget.dart';
import '../widgets/snackbar_widget.dart';
import '../widgets/text_widget.dart';

class ScreenAddStudent extends StatelessWidget {
  ScreenAddStudent({super.key, this.student});
  Rx<Student>? student;

  File? profileImage;
  StudentController studentController = Get.find();
  IdCardController idCardController = Get.find();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final batchController = TextEditingController();
  final regController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    populateStudentDatas();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            idCardController.clearFields();
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(student == null ? 'New Car Details' : 'Edit Car Details'),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: [
            //Id Card
            IdCard(
              profileImage: profileImage,
            ),
            const SizedBox(height: 30),
            CustomTextField(
              controller: nameController,
              label: 'Car Name',
              type: TextInputType.text,
              onChanged: (value) {
                idCardController.updateName(value);
              },
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'Please Enter Car Name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: ageController,
              label: 'Car Model',
              type: TextInputType.text,
              onChanged: (value) {
                idCardController.updateAge(value);
              },
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'Please Enter Car Model';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: batchController,
              label: 'Car Colour',
              type: TextInputType.text,
              onChanged: (value) {
                idCardController.updateBatch(value);
              },
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'Please Enter Car Colour';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: regController,
              label: 'Manufacturing Year',
              type: TextInputType.number,
              onChanged: (value) {
                idCardController.updateregNum(value);
              },
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'Please Enter Manufacturing Year';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff333F63),
        onPressed: () {
          addStudent();
        },
        child: const Icon(Icons.done),
      ),
    );
  }

  addStudent() async {
    if (idCardController.imagePath.value.trim().isEmpty) {
      customSnackbar(
        title: 'Warning',
        subtitle: 'Please Provide Car Photo',
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      final name = nameController.text;
      final age = ageController.text;
      final batch = batchController.text;
      final reg = regController.text;
      final imagePath = idCardController.imagePath.value;

      final newStudent = Student(
              age: age,
              batch: batch,
              name: name,
              regnum: reg,
              imagePath: imagePath)
          .obs;
      if (student == null) {
        final rxStudent =
            await DatabaseHelper.instence.addToStudentTable(newStudent.value);
        studentController.addStudent(rxStudent);
        Get.back();
        customSnackbar(
            title: 'Success',
            subtitle: 'Car added Successfully',
            isError: false);
      } else {
        student!.update((student) {
          student!.name = name;
          student.age = age;
          student.batch = batch;
          student.regnum = reg;
          student.imagePath = imagePath;
        });
        newStudent.value.id = student!.value.id;
        DatabaseHelper.instence.updateStudent(student!.value);

        Get.back();
        customSnackbar(
            title: 'Success',
            subtitle: 'Car Updated Successfully',
            isError: false);
      }
      idCardController.clearFields();
    }
  }

  populateStudentDatas() {
    nameController.text = student?.value.name ?? '';
    ageController.text = student?.value.age.toString() ?? '';
    batchController.text = student?.value.batch.toString() ?? '';
    regController.text = student?.value.regnum.toString() ?? '';
    idCardController.name.value =
        nameController.text.isEmpty ? 'Name' : nameController.text;
    idCardController.age.value = ageController.text;
    idCardController.batch.value = batchController.text;
    idCardController.regNum.value = regController.text;
    if (student != null) {
      profileImage = File(student!.value.imagePath);
      idCardController.addImage(profileImage!.path);
    }
  }
}
