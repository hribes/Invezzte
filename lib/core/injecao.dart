import 'package:get_it/get_it.dart';
import 'package:invezzte/domain/suporte/database_helper.dart';
import 'package:invezzte/domain/repositories/user_repository.dart';
import 'package:invezzte/domain/repositories/asset_repository.dart';
import 'package:invezzte/domain/repositories/transaction_repository.dart';
import 'package:invezzte/domain/repositories/investment_operation_repository.dart';
import 'package:invezzte/domain/repositories/saldo_repository.dart';
import 'package:invezzte/domain/repositories/saldo_repository_mock.dart';
import 'package:invezzte/domain/notifiers/user_notifier.dart';
import 'package:invezzte/domain/notifiers/categoria_notifier.dart';
import 'package:invezzte/domain/notifiers/historico_notifier.dart';
import 'package:invezzte/domain/notifiers/saldo_notifier.dart';
import 'package:invezzte/domain/notifiers/investimento_notifier.dart';
import 'package:invezzte/domain/repositories/category_repository.dart';

final sl = GetIt.instance;

Future<void> setupInjecao() async {
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);

  sl.registerLazySingleton<UserRepository>(() => UserRepository(sl()));
  sl.registerLazySingleton<AssetRepository>(() => AssetRepository(sl()));
  sl.registerLazySingleton<TransactionRepository>(() => TransactionRepository(sl()));
  sl.registerLazySingleton<InvestmentOperationRepository>(() => InvestmentOperationRepository(sl()));
  sl.registerLazySingleton<SaldoRepository>(() => SaldoRepositoryMock()); 
  sl.registerLazySingleton<UserProvider>(() => UserProvider());
  sl.registerLazySingleton<CategoriaNotifier>(() => CategoriaNotifier());
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepository(sl()));
  sl.registerLazySingleton<HistoricoNotifier>(() => HistoricoNotifier());
  sl.registerLazySingleton<SaldoNotifier>(() => SaldoNotifier());
  sl.registerLazySingleton<InvestimentoNotifier>(() => InvestimentoNotifier());
}