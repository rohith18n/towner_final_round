import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Services {
  static Future<String> getImageUrl(File imageFile, String imageName) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$imageName');
    final UploadTask uploadTask = storageReference.putFile(imageFile);
    final TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
    final String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }
}
