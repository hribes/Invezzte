import 'package:flutter_test/flutter_test.dart';
import 'package:invezzte/features/autenticacao/domain/models/assets.dart';
import 'package:invezzte/features/autenticacao/domain/models/enums.dart';

void main() {
  group('Asset', () {
    test('fromJson creates object correctly', () {
      final json = {
        'id': 1,
        'userId': 10,
        'tickerOrName': 'Bitcoin',
        'assetClass': 'crypto',
        'isStaking': true,
      };

      final asset = Asset.fromJson(json);

      expect(asset.id, 1);
      expect(asset.userId, 10);
      expect(asset.tickerOrName, 'Bitcoin');
      expect(asset.assetClass, AssetClass.crypto);
      expect(asset.isStaking, true);
    });

    test('toJson produces correct JSON', () {
      final asset = const Asset(
        id: 1,
        userId: 10,
        tickerOrName: 'Bitcoin',
        assetClass: AssetClass.crypto,
        isStaking: true,
      );

      final json = asset.toJson();

      expect(json['id'], 1);
      expect(json['userId'], 10);
      expect(json['tickerOrName'], 'Bitcoin');
      expect(json['assetClass'], 'crypto');
      expect(json['isStaking'], true);
    });

    test('copyWith modifies only specified fields', () {
      final asset = const Asset(
        id: 1,
        userId: 10,
        tickerOrName: 'Bitcoin',
        assetClass: AssetClass.crypto,
        isStaking: true,
      );

      final updatedAsset = asset.copyWith(isStaking: false);

      expect(updatedAsset.id, 1);
      expect(updatedAsset.userId, 10);
      expect(updatedAsset.tickerOrName, 'Bitcoin');
      expect(updatedAsset.assetClass, AssetClass.crypto);
      expect(updatedAsset.isStaking, false);
    });
  });
}
