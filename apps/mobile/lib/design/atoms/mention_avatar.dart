import 'package:flutter/material.dart';

import '../tokens.dart';
import '../typography.dart';

/// MentionAvatar renders a small initials-circle placeholder for users
/// and tags in mention chips, hover cards, and preview panels. Until
/// real profile pictures are wired up this serves as the visual anchor.
///
/// Two flavours: [MentionAvatar.user] tinted with the accent palette,
/// and [MentionAvatar.tag] tinted with the blue palette so the two
/// look distinct at a glance.
class MentionAvatar extends StatelessWidget {
  const MentionAvatar._({
    required this.label,
    required this.size,
    required this.isUser,
  });

  factory MentionAvatar.user({required String displayName, double size = 28}) {
    return MentionAvatar._(
      label: _initials(displayName),
      size: size,
      isUser: true,
    );
  }

  factory MentionAvatar.tag({required String displayName, double size = 28}) {
    return MentionAvatar._(
      label: _tagInitial(displayName),
      size: size,
      isUser: false,
    );
  }

  final String label;
  final double size;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final (bg, fg) =
        isUser ? (t.accent, t.accentOn) : (t.blueSoft, t.blueInk);
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: pulseMonoFamily,
          fontSize: size * 0.42,
          fontWeight: FontWeight.w700,
          color: fg,
          height: 1.0,
        ),
      ),
    );
  }
}

String _initials(String displayName) {
  final parts = displayName
      .trim()
      .split(RegExp(r'\s+'))
      .where((s) => s.isNotEmpty)
      .toList();
  if (parts.isEmpty) return '?';
  if (parts.length == 1) {
    return parts.first.substring(0, 1).toUpperCase();
  }
  return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
      .toUpperCase();
}

String _tagInitial(String displayName) {
  final trimmed = displayName.trim();
  if (trimmed.isEmpty) return '#';
  return trimmed.substring(0, 1).toUpperCase();
}
