import 'dart:async';

import 'package:flutter/material.dart';

class RebuildLoop extends StatefulWidget {
  final Duration duration;
  final Widget child;
  const RebuildLoop({
    super.key,
    this.duration = const Duration(seconds: 90),
    required this.child,
  });

  @override
  State<RebuildLoop> createState() => _RebuildLoopState();
}

class _RebuildLoopState extends State<RebuildLoop> {
  late final Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.duration, (_) => setState(() {}));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
