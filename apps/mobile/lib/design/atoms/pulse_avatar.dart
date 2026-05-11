import 'package:flutter/material.dart';

import '../tokens.dart';
import '../typography.dart';

enum PulseAvatarSize { sm, md, lg }

extension on PulseAvatarSize {
  double get diameter {
    switch (this) {
      case PulseAvatarSize.sm:
        return 14;
      case PulseAvatarSize.md:
        return 18;
      case PulseAvatarSize.lg:
        return 28;
    }
  }

  double get fontSize {
    switch (this) {
      case PulseAvatarSize.sm:
        return 8;
      case PulseAvatarSize.md:
        return 9;
      case PulseAvatarSize.lg:
        return 11;
    }
  }
}

/// Initials avatar matching `.hf-av` in the designer's CSS.
class PulseAvatar extends StatelessWidget {
  const PulseAvatar({
    super.key,
    required this.initials,
    this.size = PulseAvatarSize.md,
    this.solid = false,
  });

  final String initials;
  final PulseAvatarSize size;
  final bool solid;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final d = size.diameter;
    return Container(
      width: d,
      height: d,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: solid ? t.ink : t.paper2,
        border: Border.all(color: solid ? t.ink : t.hair, width: 1),
        shape: BoxShape.circle,
      ),
      child: Text(
        initials,
        style: TextStyle(
          fontFamily: pulseMonoFamily,
          fontSize: size.fontSize,
          color: solid ? t.paper : t.ink2,
          height: 1.0,
        ),
      ),
    );
  }
}

/// Overlapping row of avatars.
class PulseAvatarStack extends StatelessWidget {
  const PulseAvatarStack({
    super.key,
    required this.initials,
    this.size = PulseAvatarSize.sm,
  });

  final List<String> initials;
  final PulseAvatarSize size;

  @override
  Widget build(BuildContext context) {
    final d = size.diameter;
    return SizedBox(
      height: d,
      width: d + (initials.length - 1) * (d - 5),
      child: Stack(
        children: [
          for (int i = 0; i < initials.length; i++)
            Positioned(
              left: i * (d - 5),
              child: PulseAvatar(initials: initials[i], size: size),
            ),
        ],
      ),
    );
  }
}
