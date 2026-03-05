// lib/widgets/glass_widgets.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

// ─── GLASS CARD ────────────────────────────────────────────
class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double borderRadius;
  final bool hoverable;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 20,
    this.hoverable = false,
    this.onTap,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _ctrl;
  late Animation<double> _elevation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 220));
    _elevation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  void _onEnter(_) { if (widget.hoverable) { setState(() => _hovered = true); _ctrl.forward(); } }
  void _onExit(_)  { if (widget.hoverable) { setState(() => _hovered = false); _ctrl.reverse(); } }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      cursor: widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      child: AnimatedBuilder(
        animation: _elevation,
        builder: (_, child) => Transform.translate(
          offset: Offset(0, -6 * _elevation.value),
          child: child,
        ),
        child: GestureDetector(
          onTap: widget.onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                decoration: BoxDecoration(
                  color: _hovered
                      ? const Color(0x12FFFFFF)
                      : AppColors.glassBg,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  border: Border.all(
                    color: _hovered
                        ? AppColors.indigo.withOpacity(0.35)
                        : AppColors.glassBorder,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _hovered
                          ? AppColors.indigo.withOpacity(0.18)
                          : AppColors.glassShadow,
                      blurRadius: _hovered ? 60 : 40,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: widget.padding ?? const EdgeInsets.all(28),
                  child: Stack(
                    children: [
                      widget.child,
                      // Inner shine overlay
                      Positioned.fill(
                        child: IgnorePointer(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(widget.borderRadius),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.06),
                                  Colors.transparent,
                                ],
                                stops: const [0.0, 0.6],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── GRADIENT TEXT ─────────────────────────────────────────
class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final TextStyle? style;

  const GradientText(this.text, {super.key, required this.gradient, this.style});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) =>
          gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(text, style: style),
    );
  }
}

// ─── SECTION HEADER ────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String chip;
  final String title;
  final String highlightedWord;
  final String? subtitle;

  const SectionHeader({
    super.key,
    required this.chip,
    required this.title,
    required this.highlightedWord,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isSmall = w < 700;
    final parts = title.split(highlightedWord);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.indigo.withOpacity(0.12),
            border: Border.all(color: AppColors.indigo.withOpacity(0.25)),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PulseDot(color: AppColors.violet),
              const SizedBox(width: 8),
              Text(chip.toUpperCase(),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11, fontWeight: FontWeight.w700,
                    color: AppColors.violet, letterSpacing: 1.2,
                  )),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Title with gradient highlight
        Text.rich(
          TextSpan(
            children: [
              if (parts.isNotEmpty)
                TextSpan(
                  text: parts[0],
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: isSmall ? 28 : 36,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -1,
                    height: 1.1,
                  ),
                ),
              WidgetSpan(
                child: GradientText(
                  highlightedWord,
                  gradient: AppColors.accentGrad,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: isSmall ? 28 : 36,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                    height: 1.1,
                  ),
                ),
              ),
              if (parts.length > 1)
                TextSpan(
                  text: parts[1],
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: isSmall ? 28 : 36,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -1,
                    height: 1.1,
                  ),
                ),
            ],
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          Text(subtitle!,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15, color: AppColors.textSub, height: 1.7,
              )),
        ],
      ],
    );
  }
}

// ─── PILL TAG ──────────────────────────────────────────────
enum PillStyle { indigo, sky, emerald, pink, amber }

class PillTag extends StatelessWidget {
  final String label;
  final PillStyle style;

  const PillTag(this.label, {super.key, this.style = PillStyle.indigo});

  Color get _bg => switch (style) {
    PillStyle.indigo  => AppColors.indigo.withOpacity(0.15),
    PillStyle.sky     => AppColors.sky.withOpacity(0.12),
    PillStyle.emerald => AppColors.emerald.withOpacity(0.12),
    PillStyle.pink    => AppColors.pink.withOpacity(0.10),
    PillStyle.amber   => AppColors.amber.withOpacity(0.12),
  };

  Color get _border => switch (style) {
    PillStyle.indigo  => AppColors.indigo.withOpacity(0.25),
    PillStyle.sky     => AppColors.sky.withOpacity(0.22),
    PillStyle.emerald => AppColors.emerald.withOpacity(0.22),
    PillStyle.pink    => AppColors.pink.withOpacity(0.20),
    PillStyle.amber   => AppColors.amber.withOpacity(0.22),
  };

  Color get _text => switch (style) {
    PillStyle.indigo  => AppColors.violet,
    PillStyle.sky     => AppColors.sky,
    PillStyle.emerald => AppColors.emerald,
    PillStyle.pink    => AppColors.pink,
    PillStyle.amber   => AppColors.amber,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: _bg, border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(label,
          style: GoogleFonts.firaCode(
            fontSize: 11, fontWeight: FontWeight.w500, color: _text,
          )),
    );
  }
}

// ─── ANIMATED SKILL BAR ────────────────────────────────────
class AnimatedSkillBar extends StatefulWidget {
  final String name;
  final double value; // 0.0 – 1.0
  final Gradient gradient;
  final bool animate;

  const AnimatedSkillBar({
    super.key,
    required this.name,
    required this.value,
    required this.gradient,
    this.animate = false,
  });

  @override
  State<AnimatedSkillBar> createState() => _AnimatedSkillBarState();
}

class _AnimatedSkillBarState extends State<AnimatedSkillBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1100));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    if (widget.animate) _ctrl.forward();
  }

  @override
  void didUpdateWidget(AnimatedSkillBar old) {
    super.didUpdateWidget(old);
    if (widget.animate && !old.animate) _ctrl.forward();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final pct = '${(widget.value * 100).round()}%';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.name,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13, fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                )),
            Text(pct,
                style: GoogleFonts.firaCode(
                  fontSize: 11, color: AppColors.violet,
                )),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 5,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.07),
            borderRadius: BorderRadius.circular(100),
          ),
          child: AnimatedBuilder(
            animation: _anim,
            builder: (_, __) => FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _anim.value * widget.value,
              child: Container(
                decoration: BoxDecoration(
                  gradient: widget.gradient,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: (widget.gradient.colors.first).withOpacity(0.5),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── PULSE DOT ─────────────────────────────────────────────
class _PulseDot extends StatefulWidget {
  final Color color;
  const _PulseDot({required this.color});
  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _a;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))
      ..repeat(reverse: true);
    _a = CurvedAnimation(parent: _c, curve: Curves.easeInOut);
  }

  @override
  void dispose() { _c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _a,
    builder: (_, __) => Container(
      width: 7, height: 7,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.4 + 0.6 * _a.value),
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: widget.color.withOpacity(0.5 * _a.value), blurRadius: 6)],
      ),
    ),
  );
}

// ─── NAV BUTTON ────────────────────────────────────────────
class NavTextButton extends StatefulWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const NavTextButton({super.key, required this.label, required this.active, required this.onTap});

  @override
  State<NavTextButton> createState() => _NavTextButtonState();
}

class _NavTextButtonState extends State<NavTextButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.active || _hovered;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: active ? AppColors.indigo.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(widget.label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13, fontWeight: FontWeight.w500,
                color: active ? AppColors.violet : AppColors.textSub,
              )),
        ),
      ),
    );
  }
}

// ─── GLOW BUTTON ───────────────────────────────────────────
class GlowButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool outlined;
  const GlowButton({super.key, required this.label, required this.onTap, this.outlined = false});

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: widget.outlined
              ? BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: _hovered ? AppColors.violet : AppColors.glassBorder),
                  borderRadius: BorderRadius.circular(100),
                )
              : BoxDecoration(
                  gradient: AppColors.primaryGrad,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.indigo.withOpacity(_hovered ? 0.6 : 0.45),
                      blurRadius: _hovered ? 36 : 24,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
          child: Text(widget.label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14, fontWeight: FontWeight.w700,
                color: widget.outlined
                    ? (_hovered ? AppColors.violet : AppColors.textPrimary)
                    : Colors.white,
              )),
        ),
      ),
    );
  }
}

// ─── CONTACT CHANNEL ROW ───────────────────────────────────
class ContactChannel extends StatefulWidget {
  final String icon;
  final String label;
  final VoidCallback? onTap;
  const ContactChannel({super.key, required this.icon, required this.label, this.onTap});

  @override
  State<ContactChannel> createState() => _ContactChannelState();
}

class _ContactChannelState extends State<ContactChannel> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.indigo.withOpacity(0.07) : Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered ? AppColors.indigo.withOpacity(0.35) : AppColors.glassBorder,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 32, height: 32,
                decoration: BoxDecoration(
                  color: AppColors.indigo.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: AppColors.indigo.withOpacity(0.18)),
                ),
                child: Center(child: Text(widget.icon, style: const TextStyle(fontSize: 14))),
              ),
              const SizedBox(width: 12),
              Text(widget.label,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14, fontWeight: FontWeight.w500,
                    color: _hovered ? AppColors.violet : AppColors.textSub,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
