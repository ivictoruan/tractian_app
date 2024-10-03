import 'package:flutter/material.dart';

import 'thee_line_painter.dart';

class ExpansionTileWidget extends StatefulWidget {
  final String assetName;
  final String title;
  final int depth;
  final List<Widget>? children;
  final Widget? trailing;

  const ExpansionTileWidget({
    super.key,
    required this.assetName,
    required this.title,
    required this.depth,
    this.children,
    this.trailing,
  });

  @override
  State<ExpansionTileWidget> createState() => _ExpansionTileWidgetState();
}

class _ExpansionTileWidgetState extends State<ExpansionTileWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    bool hasChildren = widget.children != null && widget.children!.isNotEmpty;

    return Column(
      children: [
        InkWell(
          onTap: hasChildren
              ? () {
                  _isExpanded = !_isExpanded;
                  setState(() {});
                }
              : null,
          child: SizedBox(
            height: 28,
            child: Row(
              children: [
                if (hasChildren) ...[
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                  const SizedBox(width: 8),
                ] else ...{

                  const SizedBox(width: 32),
                },
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.assetName),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (widget.trailing != null) ...[
                  const SizedBox(width: 4),
                  widget.trailing!,
                ],
              ],
            ),
          ),
        ),
        if (_isExpanded && hasChildren)
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
              top: 0,
              bottom: 4,
            ),
            child: CustomPaint(
              painter: TreeLinePainter(
                depth: widget.depth,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: widget.children ?? [],
              ),
            ),
          ),
      ],
    );
  }
}
