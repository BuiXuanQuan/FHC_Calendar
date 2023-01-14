import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NextWidget extends StatelessWidget {
  const NextWidget({
    Key? key,
    required this.onNext, this.nextWidget,
  }) : super(key: key);
  final VoidCallback onNext;
  final Widget? nextWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onNext,
      child: nextWidget ?? const Text('Next'));
    
  }
}