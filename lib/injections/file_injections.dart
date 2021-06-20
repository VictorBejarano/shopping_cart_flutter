import 'package:firebase_storage/firebase_storage.dart';
import 'package:shopping_cart/features/file/data/datasources/file_data_source.dart';
import 'package:shopping_cart/features/file/data/repositories/file_repository_impl.dart';
import 'package:shopping_cart/features/file/domain/repositories/file_repository.dart';
import 'package:shopping_cart/features/file/domain/usecase/send_files.dart';
import 'package:shopping_cart/features/file/infrastructure/bloc/bloc.dart';
import 'package:shopping_cart/injections/injections.dart';

Future<void> fileDI() async {
  // Bloc
  sl.registerFactory<FileBloc>(() => FileBloc(files: sl()));

  // Use cases
  sl.registerLazySingleton<SendFiles>(() => SendFiles(sl()));
  // Repository
  sl.registerLazySingleton<FileRepository>(
    () {
      return FileRepositoryImpl(fileDataSource: sl());
    },
  );
  // Data sources
  sl.registerLazySingleton<FileDataSource>(
    () => FileDataSourceImpl(storage: sl()),
  );
}
