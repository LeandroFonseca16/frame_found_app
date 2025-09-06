import 'package:flutter/material.dart';
import '../../data/services/local/search_history_service.dart';
import '../utils/home_strings.dart';

class SearchHistoryWidget extends StatefulWidget {
  final Function(String) onSearchSelected;
  final VoidCallback onClose;

  const SearchHistoryWidget({
    super.key,
    required this.onSearchSelected,
    required this.onClose,
  });

  @override
  State<SearchHistoryWidget> createState() => _SearchHistoryWidgetState();
}

class _SearchHistoryWidgetState extends State<SearchHistoryWidget> {
  final ValueNotifier<List<String>> _searchHistoryNotifier = ValueNotifier<List<String>>([]);
  final ValueNotifier<bool> _isLoadingNotifier = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  @override
  void dispose() {
    _searchHistoryNotifier.dispose();
    _isLoadingNotifier.dispose();
    super.dispose();
  }

  Future<void> _loadSearchHistory() async {
    _isLoadingNotifier.value = true;
    final history = await SearchHistoryService.getSearchHistory();
    _searchHistoryNotifier.value = history;
    _isLoadingNotifier.value = false;
  }

  Future<void> _removeItem(String searchTerm) async {
    await SearchHistoryService.removeSearchTerm(searchTerm);
    await _loadSearchHistory();
  }

  Future<void> _clearAll() async {
    await SearchHistoryService.clearHistory();
    await _loadSearchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _searchHistoryNotifier,
          _isLoadingNotifier,
        ]),
        builder: (context, child) {
          final searchHistory = _searchHistoryNotifier.value;
          final isLoading = _isLoadingNotifier.value;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.history_rounded,
                      color: Colors.blue.shade600,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        HomeStrings.searchHistoryTitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    if (searchHistory.isNotEmpty)
                      GestureDetector(
                        onTap: _clearAll,
                        child: Text(
                          HomeStrings.searchHistoryClearAll,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: widget.onClose,
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                )
              else if (searchHistory.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 48,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        HomeStrings.searchHistoryEmpty,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        HomeStrings.searchHistoryEmptySubtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else
                Container(
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: searchHistory.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: Colors.grey.shade200,
                    ),
                    itemBuilder: (context, index) {
                      final searchTerm = searchHistory[index];
                      return ListTile(
                        leading: Icon(
                          Icons.history_rounded,
                          color: Colors.grey.shade500,
                          size: 20,
                        ),
                        title: Text(
                          searchTerm,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () => _removeItem(searchTerm),
                          child: Icon(
                            Icons.close_rounded,
                            color: Colors.grey.shade500,
                            size: 18,
                          ),
                        ),
                        onTap: () {
                          widget.onSearchSelected(searchTerm);
                          widget.onClose();
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
