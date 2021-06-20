import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class FileEvent extends Equatable {
  const FileEvent();

  @override
  List<Object> get props => [];
}

class SendFilesEvent extends FileEvent {
  final String route;
  final List<String> paths;

  SendFilesEvent({@required this.route, @required this.paths});

  @override
  List<Object> get props => [route, paths];
}
