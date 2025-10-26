import 'package:flutter/material.dart';
import 'package:islamiq/api/dua.dart';
import 'package:islamiq/components/appbar.dart';
import 'package:islamiq/components/duaCategoryCard.dart';
import 'package:islamiq/components/searchBar.dart';
import 'package:islamiq/theme/app_theme.dart';


class DuaListScreen extends StatelessWidget {
  DuaListScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> duaCategories = getDuaCategories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromRGBO(251, 248, 247, 100),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const GenericAppBar(title: "Fardhu", iconPath: "assets/icons/utils/translator.svg", onIconPressed: null),
  
          const GenericSearchBar(placeholderText: "Search Dua",),
          const SizedBox(height: 16),
     
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                    for (var category in duaCategories.asMap().entries) ...[
                      GarmentListItem(
                        data: GarmentListItemData(
                          number: category.key + 1,
                          title: category.value['name'],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, "/dua/details");
                          // Define what happens when the item is tapped
                        },
                      ),
                      // const SizedBox(height: 12),
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
// Data Model
class GarmentListItemData {
  final int number;
  final String title;

  GarmentListItemData({
    required this.number,
    required this.title,
  });
}

// List Item Component
class GarmentListItem extends StatelessWidget {
  final GarmentListItemData data;
  final VoidCallback onTap;

  const GarmentListItem({
    Key? key,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      margin: const EdgeInsets.only(bottom: 0), // No margin for elevation effect
     
      child: Column(
        children: [
          Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)), // Apply radius only to the top
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                ItemNumber(number: data.number),
                const SizedBox(width: 16),
                Expanded(
                  child: ItemTitle(title: data.title),
                ),
                const ItemArrow(),
              ],
            ),
          ),
        ),
      ),  
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20), 
        child: Divider(color: Color.fromRGBO(94, 83, 77, 100), 
                      thickness: 0.4, 
                      radius: BorderRadiusGeometry.circular(9),
                      height: 12,)
        )

        ],
      ) 
    );
    
  }
}

// Item Number Component
class ItemNumber extends StatelessWidget {
  final int number;

  const ItemNumber({
    Key? key,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$number.',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color:  AppTheme.primaryGreen,
      ),
    );
  }
}

// Item Title Component
class ItemTitle extends StatelessWidget {
  final String title;

  const ItemTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color:  AppTheme.textDark,
      ),
    );
  }
}

// Item Arrow Component
class ItemArrow extends StatelessWidget {
  const ItemArrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.chevron_right,
      color:  AppTheme.primaryGreen,
      size: 24,
    );
  }
}