import 'dart:collection';
import 'dart:io';

/// Offline mode mixin
/// - check offline mode
/// - set offline mode
/// - get offline mode
mixin OfflineModeMixin {
  void logInfo(Object message);
  void logError(Object message, [Object? error, StackTrace? stackTrace]);

  Future<bool> checkIsOffline() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isEmpty || result[0].rawAddress.isEmpty;
    } on SocketException catch (_) {
      return true;
    }
  }

  static const _difference = 10;
  static DateTime? _lastCheckTime;
  bool _isOfflineMode = false;

  bool get isOffline => _isOfflineMode;

  void setOffline([bool value = true]) {
    _isOfflineMode = value;
  }

  static final Queue<Future<void> Function()> _offlineQueue = Queue();

  Future<void> _checkOfflineMode() async {
    final now = DateTime.now();
    if (_lastCheckTime != null &&
        now.difference(_lastCheckTime!).inSeconds < _difference) {
      return;
    }
    _lastCheckTime = DateTime.now();
    logInfo('Checking offline mode $_lastCheckTime');
    try {
      final result = await checkIsOffline();
      logInfo('Offline mode: $result');
      setOffline(result);
    } catch (error, stackTrace) {
      logError(
        'Error in OfflineModeMixin._checkOfflineMode',
        error,
        stackTrace,
      );
    }
  }

  Future<void> checkOfflineMode() async {
    if (_offlineQueue.isNotEmpty) {
      return;
    }

    /// add to queue
    _offlineQueue.add(_checkOfflineMode);
    logInfo('Offline queue length: ${_offlineQueue.length}');

    while (_offlineQueue.isNotEmpty) {
      final task = _offlineQueue.removeFirst();
      await task();
    }
  }
}
