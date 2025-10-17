import 'package:flutter/material.dart';

class AppAnimations {
  static Widget fadeIn({required Widget child, Duration duration = const Duration(milliseconds: 800)}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration,
      curve: Curves.easeInOut,
      builder: (_, value, child) => Opacity(opacity: value, child: child),
      child: child,
    );
  }

  static Widget slideUp({required Widget child, Duration duration = const Duration(milliseconds: 800)}) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: const Offset(0, 0.2), end: Offset.zero),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (_, value, child) => Transform.translate(offset: value * 100, child: child),
      child: child,
    );
  }

  static Widget scaleIn({required Widget child, Duration duration = const Duration(milliseconds: 700)}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.8, end: 1),
      duration: duration,
      curve: Curves.elasticOut,
      builder: (_, value, child) => Transform.scale(scale: value, child: child),
      child: child,
    );
  }
}
