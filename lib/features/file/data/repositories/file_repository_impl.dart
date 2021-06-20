import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:shopping_cart/core/error/exceptions.dart';
import 'package:shopping_cart/core/error/failures.dart';
import 'package:shopping_cart/features/file/data/datasources/file_data_source.dart';
import 'package:shopping_cart/features/file/domain/repositories/file_repository.dart';

typedef Future<List<String>> _FilesChooser();

class FileRepositoryImpl implements FileRepository {
  final FileDataSource fileDataSource;

  FileRepositoryImpl({@required this.fileDataSource});

  @override
  Future<Either<Failure, List<String>>> sendFiles(
      String route, List<String> paths) async {
    return await _sendFiles(() {
      return fileDataSource.sendFiles(route, paths);
    });
  }

  Future<Either<Failure, List<String>>> _sendFiles(
    _FilesChooser sendFiles,
  ) async {
    try {
      final urlList = await sendFiles();
      return Right(urlList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
