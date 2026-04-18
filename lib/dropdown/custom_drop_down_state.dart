import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({super.key});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  OverlayEntry? overlayEntry;
  final LayerLink layerLink = LayerLink();

  String selected = "Select";

  void toggleDropdown() {
    if (overlayEntry == null) {
      overlayEntry = createOverlay();
      Overlay.of(context).insert(overlayEntry!);
    } else {
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }

  OverlayEntry createOverlay() {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 100,
        child: CompositedTransformFollower(
          link: layerLink,
          offset: Offset(0, 40),
          child: Material(
            elevation: 4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: ["A", "B", "C"].map((item) {
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      selected = item;
                    });
                    toggleDropdown();
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: GestureDetector(
        onTap: toggleDropdown,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(selected), Icon(Icons.arrow_drop_down)],
            ),
          ),
        ),
      ),
    );
  }
}
