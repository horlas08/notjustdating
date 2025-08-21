import 'package:flutter/material.dart';

class CategoryTabs extends StatelessWidget {
  final TabController tabController;

  const CategoryTabs({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    final tabs = ["All", "New Rooms", "Free Rooms", "For Premium Users"];
    return TabBar(
      controller: tabController,
      isScrollable: true,
      indicator: const BoxDecoration(),
      tabs: List.generate(tabs.length, (index) {
        return Tab(
          child: ChoiceChip(
            label: Text(tabs[index]),
            selected: tabController.index == index,
            onSelected: (selected) {
              if (selected) {
                tabController.animateTo(index);
              }
            },
            selectedColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            labelStyle: TextStyle(
              color: tabController.index == index ? Colors.white : Colors.black,
            ),
          ),
        );
      }),
    );
  }
}
