import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageHelper {
  Future<String?> uploadImageFromFile(File file);
}

class StorageHelperImpl extends StorageHelper {
  @override
  Future<String?> uploadImageFromFile(File file) async {
    String? imageUrl;
    final storageRef = FirebaseStorage.instance.ref();
    print('$storageRef aya');

    try {
      final uploadTask = storageRef
          .child('PlantImages/${file.path.split('/').last}')
          .putFile(file);
      print(uploadTask.snapshot);
      uploadTask.then((TaskSnapshot taskSnapshot) async {
        print('from upload');
        print(taskSnapshot.state);
        if (taskSnapshot.state == TaskState.running) {
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
        } else if (taskSnapshot.state == TaskState.error) {
          print('error');
        } else if (taskSnapshot.state == TaskState.success) {
          imageUrl = await taskSnapshot.ref.getDownloadURL();
          print(imageUrl);
        }
      });
      // TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
      // print('from upload');
      // print('from upload');
      // if (taskSnapshot.state == TaskState.running) {
      //   final progress =
      //       100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
      //   print("Upload is $progress% complete.");
      // } else if (taskSnapshot.state == TaskState.error) {
      //   print('errror');
      //   throw Exception('error');
      // } else if (taskSnapshot.state == TaskState.success) {
      //   imageUrl = await taskSnapshot.ref.getDownloadURL();
      //   print(imageUrl);
      //   return imageUrl;
      // }
    } catch (e) {
      print('Error during file upload: $e');
      // Handle the error accordingly
      throw Exception('File upload failed');
    }
  }
}