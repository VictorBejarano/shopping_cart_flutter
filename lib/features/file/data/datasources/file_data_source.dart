import 'dart:io' show File;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'package:shopping_cart/core/error/exceptions.dart';

abstract class FileDataSource {
  /// Throws a [ServerException] for all error codes.
  Future<List<String>> sendFiles(String route, List<String> paths);
}

class FileDataSourceImpl implements FileDataSource {
  final FirebaseStorage storage;

  FileDataSourceImpl({@required this.storage});

  @override
  Future<List<String>> sendFiles(String route, List<String> paths) {
    return _sendFilesToFirestorage(route, paths);
  }

  Future<List<String>> _sendFilesToFirestorage(
      String route, List<String> paths) async {
    try {
      var result = <String>[];
      var counterPaths = 0;
      UploadTask uploadTask;
      for (var path in paths) {
        final storageReference =
            FirebaseStorage.instance.ref(route + '/image$counterPaths');
        uploadTask = storageReference.putFile(File(path));
        await uploadTask.whenComplete(() async {
          final photoURL = await storageReference.getDownloadURL();
          result.add(photoURL);
        });
        counterPaths++;
      }
      return result;
    } catch (e) {
      throw ServerException();
    }
  }
}
