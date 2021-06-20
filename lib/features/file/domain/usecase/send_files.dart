import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/core/error/failures.dart';
import 'package:shopping_cart/core/usecases/usecases.dart';
import 'package:shopping_cart/features/file/domain/repositories/file_repository.dart';

class SendFiles implements UseCase<List<String>, Params> {
  final FileRepository repository;

  SendFiles(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(Params params) async {
    return await repository.sendFiles(params.route, params.paths);
  }
}

class Params extends Equatable {
  final String route;
  final List<String> paths;

  Params(this.route, this.paths);

  @override
  List<Object> get props => [route, paths];
}
