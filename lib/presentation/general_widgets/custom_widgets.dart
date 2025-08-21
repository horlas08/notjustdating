import 'package:flutter/material.dart';

class CustomRadioSelector extends StatefulWidget {
  final List<String> options;
  final int initialSelected;
  final void Function(int index) onChanged;

  const CustomRadioSelector({
    super.key,
    required this.options,
    this.initialSelected = 0,
    required this.onChanged,
  });

  @override
  State<CustomRadioSelector> createState() => _CustomRadioSelectorState();
}

class _CustomRadioSelectorState extends State<CustomRadioSelector> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.options.length, (index) {
        final isSelected = selectedIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() => selectedIndex = index);
            widget.onChanged(index);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                CustomRadio(isSelected: isSelected),
                const SizedBox(width: 12),
                Text(
                  widget.options[index],
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class CustomRadio extends StatelessWidget {
  final bool isSelected;

  const CustomRadio({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.pinkAccent : Colors.grey.shade400,
          width: 2,
        ),
        color: isSelected ? Colors.pinkAccent : Colors.transparent,
      ),
      child: isSelected
          ? const Center(
              child: Icon(Icons.diamond, size: 12, color: Colors.white),
            )
          : null,
    );
  }
}
