import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryService {
  static const String _searchHistoryKey = 'search_history';
  static const int _maxHistoryItems = 5;

  static Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_searchHistoryKey) ?? [];
  }

  static Future<void> addSearchTerm(String searchTerm) async {
    if (searchTerm.trim().isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    List<String> history = await getSearchHistory();

    history.removeWhere((item) => item.toLowerCase() == searchTerm.toLowerCase());

    history.insert(0, searchTerm.trim());

    if (history.length > _maxHistoryItems) {
      history = history.take(_maxHistoryItems).toList();
    }

    await prefs.setStringList(_searchHistoryKey, history);
  }

  static Future<void> removeSearchTerm(String searchTerm) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = await getSearchHistory();
    history.removeWhere((item) => item.toLowerCase() == searchTerm.toLowerCase());
    await prefs.setStringList(_searchHistoryKey, history);
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_searchHistoryKey);
  }
}
