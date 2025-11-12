import 'package:flutter/material.dart';

enum SelectedMenu {
  edit,
  delete,
}

enum ProfileMenu {
  changePassword,
}

class CustomPopupMenuItem<T> extends PopupMenuItem<T> {
  CustomPopupMenuItem({
    super.key,
    required T value,
    IconData? icon,
    required String label,
    required Color color,
  }) : super(
          value: value,
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(
                  color: color,
                ),
              ),
            ],
          ),
        );
}
