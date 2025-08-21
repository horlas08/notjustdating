import 'package:flutter/material.dart';

class RoundedCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const RoundedCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: Colors.transparent, // No fill color
          borderRadius: BorderRadius.circular(6),

          border: Border.all(color: Colors.black, width: 1.5),
        ),
        child: value
            ? const Icon(Icons.check, size: 20, color: Colors.black)
            : null,
      ),
    );
  }
}
