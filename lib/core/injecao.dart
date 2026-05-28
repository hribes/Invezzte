import 'package:get_it/get_it.dart';
import 'package:invezzte/domain/repositories/saldo_repository.dart';
import 'package:invezzte/domain/repositories/saldo_repository_mock.dart';
import 'package:invezzte/domain/notifiers/saldo_notifier.dart';
import 'package:invezzte/domain/notifiers/categoria_notifier.dart';
import 'package:invezzte/domain/notifiers/historico_notifier.dart';

final sl = GetIt.instance;
Future<void> configurarDependencias() async {
  sl.registerLazySingleton<SaldoRepository>(() => SaldoRepositoryMock());
  sl.registerFactory<SaldoNotifier>(() => SaldoNotifier());

  // 1. Registra o CategoriaNotifier
  sl.registerLazySingleton<CategoriaNotifier>(() {
    final notifier = CategoriaNotifier();
    notifier.carregarCategoriasMock();
    return notifier;
  });

  // 2. Registra o HistoricoNotifier e passa as categorias para ele
  sl.registerLazySingleton<HistoricoNotifier>(() {
    final notifier = HistoricoNotifier();

    // Pega a instância do CategoriaNotifier que já foi criada
    final categoriaNotifier = sl<CategoriaNotifier>();

    // Carrega os dados e as categorias
    notifier.carregarDadosMock();
    notifier.carregarCategorias(categoriaNotifier.categorias);

    return notifier;
  });
}
