import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/student_model.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.item});

  final Rx<Student> item;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 100,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xffE9E6E2), Colors.white]),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                      image: NetworkImage(item.value.imagePath),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(width: 15),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.value.name,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Color(0xff2F435A),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Colour : ',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.grey.shade600)),
                        TextSpan(
                            text: item.value.batch.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.grey.shade600))
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 40,
            )
          ],
        ),
      ),
    );
  }
}
