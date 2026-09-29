import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  const AnimatedCounter({
    super.key,
    this.initialValue = 0,
    this.maxValue = 100,
    this.animationDuration = const Duration(milliseconds: 300),
    this.primaryColor,
  });

  final int initialValue;
  final int maxValue;
  final Duration animationDuration;
  final Color? primaryColor;

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late int _value;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
    _controller = AnimationController(vsync: this, duration: widget.animationDuration);
  }

  void _change(int delta) {
    setState(() => _value = (_value + delta).clamp(0, widget.maxValue).toInt());
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('$_value', style: Theme.of(context).textTheme.displaySmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () => _change(-1), icon: const Icon(Icons.remove)),
                IconButton(onPressed: () => _change(1), icon: const Icon(Icons.add)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
