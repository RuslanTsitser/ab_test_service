import 'dart:collection';

import 'package:apphud/apphud.dart';
import 'package:apphud/models/apphud_models/apphud_placement.dart';

import '../../model/placement_type.dart';
import '../../model/remote_config.dart';

mixin RemoteConfigMixin {
  bool get isOffline;
  Future<void> cachePlacements(List<ApphudPlacement> placements);
  Future<List<ApphudPlacement>> getCachedPlacements();
  void logInfo(Object message);
  void logError(Object message, [Object? error, StackTrace? stackTrace]);

  final HashMap<PlacementType, RemoteConfig> _remoteConfigs = HashMap();

  RemoteConfig remoteConfig(PlacementType type) {
    RemoteConfig config = _remoteConfigs[type]!;
    config = config.copyWith();
    return config;
  }

  void setRemoteConfig(
    RemoteConfig value,
    PlacementType type, {
    bool log = true,
  }) {
    _remoteConfigs[type] = value;
    if (log) {
      logInfo({
        'type': '$type',
        'placementName': type.placementName,
        'remoteConfig': _remoteConfigs[type]?.toJson(),
      });
    }
  }

  List<ApphudPlacement> _placements = [];
  List<ApphudPlacement> get placements => _placements;

  Future<void> fetchPlacements() async {
    if (isOffline) {
      _placements = await getCachedPlacements();
      return;
    }
    try {
      final value = await Apphud.placements();
      await cachePlacements(value);
      _placements = value;
    } on Exception catch (error, stackTrace) {
      logError('Error in Apphud.placements()', error, stackTrace);
    }
  }
}
