import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const _biometricsKey = 'biometrics_enabled';
  static const _firstTIme = 'first_time';

  Future<void> saveBiometricsPreference(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricsKey, enabled);
  }

  Future<bool> getBiometricsPreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_biometricsKey) ?? false;
  }

  Future<void> saveFirstTimePreference(bool enable) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstTIme, enable);
  }

  Future<bool> getFirstTimePreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_firstTIme) ?? false;
  }
}
