// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../app_hud/mixin/offline_mode_mixin.dart';

mixin WebToWaveMixin on OfflineModeMixin {
  /// Example: 'hello-world-api-key'
  String get web2WaveApiKey;

  /// Example: 'https://quiz.hello-world.com'
  String get web2WaveBaseUrl;

  /// Example: 'api/user/subscriptions'
  String get path;

  /// Checks if the user has an active subscription in the Web2Wave service.
  Future<(bool, String?)> checkIsWeb2WavePremium() async {
    final userId = await getWeb2WaveUserId();
    logInfo('Web2Wave user id: $userId');
    if (userId == null) {
      return (false, null);
    }

    /// for testing purposes
    if (userId == 'test') {
      return (true, null);
    }
    final hasActiveSubscription = await _fetchSubscriptionStatus(userId);
    logInfo(
      'Web2Wave subscription status: ${hasActiveSubscription.hasActiveSubscription}',
    );
    return (
      hasActiveSubscription.hasActiveSubscription,
      hasActiveSubscription.cancelSubscriptionLink,
    );
  }

  /// Fetches the subscription status of the user from the Web2Wave service.
  Future<Web2WaveResponse> _fetchSubscriptionStatus(String userId) async {
    await checkOfflineMode();

    if (isOffline) {
      final cachedIsPremium = await getCachedWeb2WaveIsPremium();
      return cachedIsPremium;
    }

    final url = Uri.https(web2WaveBaseUrl, path, {'user': userId});

    try {
      final response = await http.get(
        url,
        headers: {'api_key': web2WaveApiKey},
      );

      if (response.statusCode == 200) {
        final result = _handleSubscriptionResponse(response.body);
        await cacheWeb2WaveIsPremium(result);
        return result;
      } else {
        logError('Failed to fetch subscription status: ${response.statusCode}');
        return const Web2WaveResponse.empty();
      }
    } catch (e) {
      logError('Failed to fetch subscription status: $e');
      return const Web2WaveResponse.empty();
    }
  }

  /// Parses the response from the Web2Wave service and returns whether the user has an active subscription.
  Web2WaveResponse _handleSubscriptionResponse(String responseBody) {
    try {
      Map<String, dynamic> jsonResponse =
          jsonDecode(responseBody) as Map<String, dynamic>;
      List<dynamic> subscriptions =
          jsonResponse['subscription'] as List<dynamic>;

      bool hasActiveSubscription = subscriptions.any((sub) {
        String status = sub['status'] as String;
        return status == 'active' || status == 'trialing';
      });

      String? cancelSubscriptionLink;

      for (final sub in subscriptions) {
        if (sub['manage_link'] is String) {
          cancelSubscriptionLink = sub['manage_link'] as String;
          break;
        }
      }

      return Web2WaveResponse(
        hasActiveSubscription: hasActiveSubscription,
        cancelSubscriptionLink: cancelSubscriptionLink,
      );
    } catch (e, s) {
      logError('Failed to parse subscription response', e, s);
      return const Web2WaveResponse.empty();
    }
  }

  /// Returns the user id of the Web2Wave service from the query parameters of the [uri].
  String? getWeb2WaveUserIdFromQueryParameters(Uri uri) {
    final userId = uri.queryParameters['user_id'];
    return userId;
  }

  static const String _web2WaveUserIdKey = 'WebToWaveMixin.web2WaveUserId';

  /// Returns the user id of the Web2Wave service if it was saved before.
  Future<String?> getWeb2WaveUserId() async {
    final prefs = await SharedPreferences.getInstance();
    // return 'test'; // TODO: For test purposes
    return prefs.getString(_web2WaveUserIdKey);
  }

  /// Saves the user id of the Web2Wave service.
  Future<void> setWeb2WaveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_web2WaveUserIdKey, userId);
  }

  static const String _web2WaveIsPremiumKey =
      'WebToWaveMixin.web2WaveIsPremium';
  static const String _web2WaveCancelLink = 'WebToWaveMixin.web2WaveCancelLink';

  Future<void> cacheWeb2WaveIsPremium(Web2WaveResponse response) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_web2WaveIsPremiumKey, response.hasActiveSubscription);
    await prefs.setString(
      _web2WaveCancelLink,
      response.cancelSubscriptionLink ?? '',
    );
  }

  Future<Web2WaveResponse> getCachedWeb2WaveIsPremium() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSubscription = prefs.getBool(_web2WaveIsPremiumKey) ?? false;
    final cancelSubscriptionLink = prefs.getString(_web2WaveCancelLink);
    return Web2WaveResponse(
      hasActiveSubscription: hasSubscription,
      cancelSubscriptionLink: cancelSubscriptionLink,
    );
  }
}

class Web2WaveResponse {
  final bool hasActiveSubscription;
  final String? cancelSubscriptionLink;
  const Web2WaveResponse({
    required this.cancelSubscriptionLink,
    this.hasActiveSubscription = false,
  });

  const Web2WaveResponse.empty([this.hasActiveSubscription = false])
    : cancelSubscriptionLink = null;
}
