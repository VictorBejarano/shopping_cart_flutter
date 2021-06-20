import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class File extends Equatable {
  final String path;
  final String filePath;

  File({
    @required this.path,
    @required this.filePath,
  });

  @override
  List<Object> get props => [path, filePath];
}
