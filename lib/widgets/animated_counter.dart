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
    with TickerProviderStateMixin {
  late int _value;
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;
  late final AnimationController _buttonController;
  late final Animation<double> _buttonScale;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue.clamp(0, widget.maxValue).toInt();
    _scaleController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 1.15).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
    );
    _buttonScale = Tween<double>(begin: 1, end: 0.88).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  Future<void> _bounce() async {
    await _buttonController.forward(from: 0);
    if (!mounted) {
      return;
    }
    await _buttonController.reverse();
  }

  void _change(int delta) {
    final next = (_value + delta).clamp(0, widget.maxValue).toInt();
    if (next == _value) {
      _bounce();
      return;
    }
    setState(() => _value = next);
    _scaleController.forward(from: 0).then((_) {
      if (mounted) {
        _scaleController.reverse();
      }
    });
    _bounce();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = widget.primaryColor ?? theme.colorScheme.primary;
    final atMax = _value >= widget.maxValue;
    final targetColor = atMax ? theme.colorScheme.tertiary : primary;
    final progress = widget.maxValue == 0 ? 0.0 : _value / widget.maxValue;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TweenAnimationBuilder<Color?>(
              duration: widget.animationDuration,
              tween: ColorTween(end: targetColor),
              builder: (context, color, child) => ScaleTransition(
                scale: _scaleAnimation,
                child: Text(
                  '$_value',
                  style: theme.textTheme.displaySmall?.copyWith(color: color),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TweenAnimationBuilder<double>(
              duration: widget.animationDuration,
              tween: Tween<double>(begin: 0, end: progress),
              builder: (context, value, child) => LinearProgressIndicator(value: value),
            ),
            const SizedBox(height: 16),
            ScaleTransition(
              scale: _buttonScale,
              child: Wrap(
                spacing: 8,
                children: [
                  IconButton.filledTonal(
                    tooltip: 'Зменшити',
                    onPressed: () => _change(-1),
                    icon: const Icon(Icons.remove),
                  ),
                  IconButton.filled(
                    tooltip: 'Збільшити',
                    onPressed: () => _change(1),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
