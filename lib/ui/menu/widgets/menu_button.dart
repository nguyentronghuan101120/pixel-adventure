import 'package:flutter/material.dart';
import 'package:pixel_adventure/gen/fonts.gen.dart';
import 'package:pixel_adventure/ui/menu/widgets/menu_type.dart';

class MenuButton extends StatefulWidget {
  final MenuType menuType;

  final VoidCallback onPressed;

  const MenuButton({
    super.key,
    required this.menuType,
    required this.onPressed,
  });

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            color: widget.menuType.color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.menuType.name,
                  style: const TextStyle(
                    fontFamily: FontFamily.pixelMania,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 8),
                widget.menuType.icon,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
