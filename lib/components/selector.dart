
import 'package:flutter/material.dart';
import 'package:islamiq/theme/app_theme.dart';

class SelectorTabData {
  final String label;
  final IconData? icon;
  SelectorTabData({required this.label, this.icon});
}

class SelectorTabs extends StatefulWidget {
  final List<SelectorTabData> tabs;
  final int initialIndex;
  final ValueChanged<int>? onTabSelected;

  const SelectorTabs({
    Key? key,
    required this.tabs,
    this.initialIndex = 0,
    this.onTabSelected,
  }) : super(key: key);

  @override
  State<SelectorTabs> createState() => _SelectorTabsState();
}

class _SelectorTabsState extends State<SelectorTabs> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 56,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.cardGreenLight,
          borderRadius: BorderRadius.circular(12),
          border: BoxBorder.all(color: AppTheme.primaryGreen, width: 1.5),
        ),
        child: Row(
          children: List.generate(widget.tabs.length, (index) {
            final tab = widget.tabs[index];
            final isSelected = selectedIndex == index;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  if (widget.onTabSelected != null) {
                    widget.onTabSelected!(index);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primaryGreen : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (tab.icon != null) ...[
                        Icon(
                          tab.icon,
                          color: isSelected ? Colors.white : AppTheme.textMedium,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                      ],
                      Text(
                        tab.label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : AppTheme.textMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

