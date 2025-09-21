import 'package:flutter/material.dart';

class ThemeToggleWidget extends StatelessWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return IconButton(
      icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
      onPressed: () {},
      tooltip: isDark ? 'Tema oscuro' : 'Tema claro',
    );
  }
}
