import 'package:flutter/material.dart';

class SidebarButton extends StatelessWidget {
  final String label;
  final bool isHighlighted;
  final VoidCallback onPressed;

  const SidebarButton({
    Key? key,
    required this.label,
    this.isHighlighted = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isHighlighted ? Colors.blueGrey : Colors.grey[100],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                color: isHighlighted ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
