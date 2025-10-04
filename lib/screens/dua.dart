import 'package:flutter/material.dart';
import 'package:islamiq/api/dua.dart';
import 'package:islamiq/components/appbar.dart';
import 'package:islamiq/components/duaCategoryCard.dart';
import 'package:islamiq/components/searchBar.dart';





class DuaScreen extends StatelessWidget {
  DuaScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> duaCategories = getDuaCategories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(251, 248, 247, 100),
      body: Column(
        children: [
          const GenericAppBar(title: "Dua", iconPath: "assets/icons/utils/translator.svg", onIconPressed: null),
          const SizedBox(height: 16),
          const GenericSearchBar(placeholderText: "Search Dua",),
          const SizedBox(height: 16),
          const CategoryTabs(),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                    for (var category in duaCategories.asMap().entries) ...[
                      DuaCategory(
                        title: category.value['name'],
                        duasCount: category.value['duaCount'],
                        index: category.key + 1,
                      ),
                    
                    ],
                ]
             
            ),
          ),
        ],
      ),
    );
  }
}

// App Bar Component

// Category Tabs Component
class CategoryTabs extends StatefulWidget {
  const CategoryTabs({Key? key}) : super(key: key);

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs> {
  bool isCategoriesSelected = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 56,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFE8E0DD),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
            children: [
            Expanded(
              child: GestureDetector(
              onTap: () {
                setState(() {
                isCategoriesSelected = true;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8), // Added padding
                decoration: BoxDecoration(
                color: isCategoriesSelected
                  ? const Color(0xFFB8998C)
                  : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                  Icons.menu,
                  color: isCategoriesSelected
                    ? Colors.white
                    : const Color(0xFF757575),
                  size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: isCategoriesSelected
                      ? Colors.white
                      : const Color(0xFF757575),
                  ),
                  ),
                ],
                ),
              ),
              ),
            ),
            Expanded(
              child: GestureDetector(
              onTap: () {
                setState(() {
                isCategoriesSelected = false;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8), // Added padding
                decoration: BoxDecoration(
                color: !isCategoriesSelected
                  ? const Color(0xFFB8998C)
                  : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                  Icons.bookmark_border,
                  color: !isCategoriesSelected
                    ? Colors.white
                    : const Color(0xFF757575),
                  size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                  'My Duas',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: !isCategoriesSelected
                      ? Colors.white
                      : const Color(0xFF757575),
                  ),
                  ),
                ],
                ),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

