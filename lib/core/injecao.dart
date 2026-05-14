import 'package:get_it/get_it.dart';
import 'package:invezzte/domain/repositories/saldo_repository.dart';
import 'package:invezzte/domain/repositories/saldo_repository_mock.dart';
import 'package:invezzte/domain/notifiers/saldo_notifier.dart';

final sl = GetIt.instance;

Future<void> configurarDependencias() async {
  sl.registerLazySingleton<SaldoRepository>(() => SaldoRepositoryMock());

  sl.registerFactory<SaldoNotifier>(() => SaldoNotifier());
}
