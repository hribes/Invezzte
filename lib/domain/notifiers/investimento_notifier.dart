import 'package:flutter/material.dart';
import 'package:invezzte/domain/investment_operation.dart';
import 'package:invezzte/domain/assets.dart'; 
import 'package:invezzte/domain/enums.dart'; 
import 'package:invezzte/core/injecao.dart';
import 'package:invezzte/domain/repositories/investment_operation_repository.dart';
import 'package:invezzte/domain/repositories/asset_repository.dart';

class InvestimentoNotifier extends ChangeNotifier {
  List<InvestmentOperation> _operacoes = [];
  List<Asset> _ativos = []; 

  Future<void> carregarDadosDoBanco(int userId) async {
    _operacoes.clear();
    _ativos.clear();
    
    final assetRepo = sl<AssetRepository>();
    final opRepo = sl<InvestmentOperationRepository>();
    
    _ativos = await assetRepo.getByUserId(userId);
    
    for (var ativo in _ativos) {
      final ops = await opRepo.getByAssetId(ativo.id);
      _operacoes.addAll(ops);
    }
    
    notifyListeners();
  }

  Future<void> adicionarOperacao(int userId, String ticker, double valorInvestido, int quantidade) async {
    final assetRepo = sl<AssetRepository>();
    final opRepo = sl<InvestmentOperationRepository>();
    
    Asset? ativo = await assetRepo.getByTickerAndUserId(ticker, userId);
    
    if (ativo == null) {
      final novoAtivo = Asset(
        id: 0, 
        userId: userId,
        ticker: ticker,
        name: ticker, 
        isStaking: false,
      );
      final novoAtivoId = await assetRepo.insert(novoAtivo);
      
      ativo = novoAtivo.copyWith(id: novoAtivoId);
    }

    final novaOperacao = InvestmentOperation(
      id: 0,
      assetId: ativo.id,
      operationType: OperationType.values.first,
      totalAmount: valorInvestido,
      quantity: quantidade.toDouble(),
      date: DateTime.now(),
    );

    await opRepo.insert(novaOperacao);
    await carregarDadosDoBanco(userId); 
  }

  List<InvestmentOperation> get operacoes => _operacoes;

  List<InvestmentOperation> obterOperacoesDoAtivo(int assetId) {
    return _operacoes.where((op) => op.assetId == assetId).toList();
  }

  String obterTickerDoAtivo(int assetId) {
    try {
      return _ativos.firstWhere((a) => a.id == assetId).ticker;
    } catch (e) {
      return 'Desconhecido';
    }
  }

  List<Map<String, dynamic>> get carteiraAgrupada {
    Map<int, Map<String, dynamic>> agrupado = {};

    for (var op in _operacoes) {
      if (!agrupado.containsKey(op.assetId)) {
        agrupado[op.assetId] = {
          'assetId': op.assetId,
          'quantidade_raw': 0.0,
          'totalValue': 0.0,
        };
      }
      agrupado[op.assetId]!['quantidade_raw'] += op.quantity;
      agrupado[op.assetId]!['totalValue'] += op.totalAmount;
    }

    return agrupado.values.map((item) {

      final ativoOriginal = _ativos.firstWhere(
        (a) => a.id == item['assetId'], 
        orElse: () => const Asset(id: 0, userId: 0, ticker: 'Outro', name: 'Outro', isStaking: false)
      );

      return {
        'assetId': item['assetId'],
        'name': ativoOriginal.ticker,
        'quantidade': '${item['quantidade_raw'].toInt()} cotas',
        'totalValue': item['totalValue'],
      };
    }).toList();
  }
}