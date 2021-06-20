import 'package:dartz/dartz.dart';
import 'package:shopping_cart/core/error/failures.dart';

abstract class FileRepository {
  Future<Either<Failure, List<String>>> sendFiles(
      String route, List<String> paths);
}
