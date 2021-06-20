import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:shopping_cart/core/error/failures.dart';
import 'package:shopping_cart/features/file/domain/usecase/send_files.dart';

import 'bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class FileBloc extends Bloc<FileEvent, FileState> {
  final SendFiles sendFiles;

  FileBloc({@required SendFiles files})
      : assert(files != null),
        sendFiles = files,
        super(Empty());

  @override
  Stream<FileState> mapEventToState(
    FileEvent event,
  ) async* {
    if (event is SendFilesEvent) {
      yield Loading();
      final failureOrFiles = await sendFiles(Params(event.route, event.paths));
      yield* _eitherLoadedOrErrorState(failureOrFiles);
    }
  }

  Stream<FileState> _eitherLoadedOrErrorState(
      Either<Failure, List<String>> failureOrFiles) async* {
    yield failureOrFiles.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (urls) => Loaded(urls: urls),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
