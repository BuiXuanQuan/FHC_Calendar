import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GoBackWidget extends StatelessWidget {
  const GoBackWidget({
    Key? key,
    required this.onGoBack, this.goBackWidget,
  }) : super(key: key);
  final VoidCallback onGoBack;
  final Widget? goBackWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onGoBack, child: goBackWidget ?? const Text('Back'));
  }
}
