import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FileState extends Equatable {
  const FileState();

  @override
  List<Object> get props => [];
}

class Empty extends FileState {}

class Loading extends FileState {}

class Loaded extends FileState {
  final List<String> urls;

  Loaded({@required this.urls});

  @override
  List<Object> get props => [urls];
}

class Error extends FileState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
