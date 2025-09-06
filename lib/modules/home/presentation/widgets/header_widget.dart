import 'package:flutter/material.dart';
import 'package:frame_found_app/modules/home/presentation/utils/home_strings.dart';
import '../widgets/search_history_widget.dart';
import '../../data/services/local/search_history_service.dart';

class HeaderWidget extends StatefulWidget {
  final Function(String)? onSearch;
  final String? placeholder;

  const HeaderWidget({
    super.key,
    this.onSearch,
    this.placeholder,
  });

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final ValueNotifier<bool> _isFocusedNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _hasTextNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _showHistoryNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _focusNode.addListener(() {
      _isFocusedNotifier.value = _focusNode.hasFocus;
      if (_focusNode.hasFocus) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });

    _searchController.addListener(() {
      _hasTextNotifier.value = _searchController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    _isFocusedNotifier.dispose();
    _hasTextNotifier.dispose();
    _showHistoryNotifier.dispose();
    super.dispose();
  }

  void _performSearch(String searchTerm) async {
    if (searchTerm.trim().isNotEmpty) {
      await SearchHistoryService.addSearchTerm(searchTerm);
      if (widget.onSearch != null) {
        widget.onSearch!(searchTerm);
      }
    }
  }

  void _selectFromHistory(String searchTerm) {
    _searchController.text = searchTerm;
    _performSearch(searchTerm);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, top: 16, bottom: 16),
              child: AnimatedBuilder(
                animation: _showHistoryNotifier,
                builder: (context, child) {
                  final showHistory = _showHistoryNotifier.value;
                  return GestureDetector(
                    onTap: () {
                      _showHistoryNotifier.value = !showHistory;
                    },
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: showHistory ? Colors.blue.shade500 : Colors.grey.shade100,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: showHistory ? Colors.blue.shade600 : Colors.grey.shade300,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: showHistory
                                ? Colors.blue.withOpacity(0.2)
                                : Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.history_rounded,
                        color: showHistory ? Colors.white : Colors.grey.shade600,
                        size: 24,
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8, right: 20, top: 16, bottom: 16),
                child: AnimatedBuilder(
                  animation: Listenable.merge([
                    _scaleAnimation,
                    _isFocusedNotifier,
                    _hasTextNotifier,
                  ]),
                  builder: (context, child) {
                    final isFocused = _isFocusedNotifier.value;
                    final hasText = _hasTextNotifier.value;

                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isFocused
                                ? [Colors.white, Colors.blue.shade50]
                                : [Colors.grey.shade50, Colors.grey.shade100],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(26),
                          border: Border.all(
                            color: isFocused ? Colors.blue.shade400 : Colors.grey.shade300,
                            width: isFocused ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isFocused ? Colors.blue.withOpacity(0.15) : Colors.black.withOpacity(0.08),
                              blurRadius: isFocused ? 12 : 8,
                              offset: const Offset(0, 4),
                              spreadRadius: isFocused ? 1 : 0,
                            ),
                            if (isFocused)
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                                spreadRadius: 2,
                              ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 16),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                child: hasText
                                    ? GestureDetector(
                                        onTap: () {
                                          _searchController.clear();
                                          if (widget.onSearch != null) {
                                            widget.onSearch!('');
                                          }
                                        },
                                        child: Icon(
                                          Icons.close_rounded,
                                          color: isFocused ? Colors.blue.shade600 : Colors.grey.shade600,
                                          size: 22,
                                        ),
                                      )
                                    : Icon(
                                        Icons.search_rounded,
                                        color: isFocused ? Colors.blue.shade600 : Colors.grey.shade600,
                                        size: 22,
                                      ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                focusNode: _focusNode,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.3,
                                ),
                                decoration: InputDecoration(
                                  hintText: widget.placeholder ?? HomeStrings.searchHintDefault,
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.2,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                onSubmitted: (value) {
                                  _performSearch(value);
                                },
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: hasText ? 46 : 0,
                              child: hasText
                                  ? GestureDetector(
                                      onTap: () {
                                        _performSearch(_searchController.text);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 16),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade500,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.arrow_forward_rounded,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _showHistoryNotifier,
          builder: (context, showHistory, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: showHistory ? null : 0,
              child: showHistory
                  ? SearchHistoryWidget(
                      onSearchSelected: _selectFromHistory,
                      onClose: () {
                        _showHistoryNotifier.value = false;
                      },
                    )
                  : null,
            );
          },
        ),
      ],
    );
  }
}
