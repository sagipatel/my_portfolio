// lib/screens/hero_section.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/portfolio_data.dart';
import '../widgets/glass_widgets.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewProjects;
  final VoidCallback onContact;

  const HeroSection({
    super.key,
    required this.onViewProjects,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isSmall = w < 900;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: isSmall
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100),
                      _HeroLeft(onViewProjects: onViewProjects, onContact: onContact, isSmall: true),
                      const SizedBox(height: 40),
                      _HeroCard(),
                      const SizedBox(height: 80),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: _HeroLeft(onViewProjects: onViewProjects, onContact: onContact, isSmall: false)),
                      const SizedBox(width: 60),
                      SizedBox(width: 420, child: _HeroCard()),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _HeroLeft extends StatelessWidget {
  final VoidCallback onViewProjects;
  final VoidCallback onContact;
  final bool isSmall;
  const _HeroLeft({required this.onViewProjects, required this.onContact, required this.isSmall});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Available badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.emerald.withOpacity(0.10),
            border: Border.all(color: AppColors.emerald.withOpacity(0.25)),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _GlowDot(color: AppColors.emerald),
              const SizedBox(width: 8),
              Text('Available for Opportunities',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11, fontWeight: FontWeight.w700,
                    color: AppColors.emerald, letterSpacing: 0.5,
                  )),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // Name
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(
            colors: [Colors.white, AppColors.violet, AppColors.sky],
          ).createShader(Rect.fromLTWH(0, 0, b.width, b.height)),
          child: Text(PortfolioData.name,
              style: GoogleFonts.plusJakartaSans(
                fontSize: isSmall ? 44 : 72,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -2,
                height: 1.0,
              )),
        ),
        const SizedBox(height: 8),

        // Role
        Text(PortfolioData.role,
            style: GoogleFonts.plusJakartaSans(
              fontSize: isSmall ? 18 : 24,
              fontWeight: FontWeight.w300,
              color: AppColors.textSub,
            )),
        const SizedBox(height: 20),

        // Tagline
        Text(PortfolioData.tagline,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15, color: AppColors.textSub, height: 1.75,
            )),
        const SizedBox(height: 36),

        // Buttons
        Wrap(
          spacing: 12, runSpacing: 12,
          children: [
            GlowButton(label: 'View Projects ↓', onTap: onViewProjects),
            GlowButton(label: 'Let\'s Talk', onTap: onContact, outlined: true),
          ],
        ),
        const SizedBox(height: 48),

        // Stats
        Wrap(
          spacing: 32, runSpacing: 16,
          children: PortfolioData.stats.map((s) => _StatItem(num: s.$1, label: s.$2)).toList(),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row
          Row(
            children: [
              // Avatar
              Container(
                width: 52, height: 52,
                decoration: BoxDecoration(
                  gradient: AppColors.accentGrad,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: AppColors.indigo.withOpacity(0.5), blurRadius: 20)],
                ),
                child: Center(child: Text('SR',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white,
                    ))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sagar Zadafiya',
                        style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 15)),
                    Text('Flutter · Dart · Firebase · N8n · Automation',
                        style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSub)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.emerald.withOpacity(0.12),
                  border: Border.all(color: AppColors.emerald.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _GlowDot(color: AppColors.emerald, size: 5),
                    const SizedBox(width: 5),
                    Text('Open to work',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.emerald,
                        )),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: AppColors.glassBorder, height: 1),
          const SizedBox(height: 16),

          // Code snippet
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.35),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.06)),
            ),
            child: SelectableText.rich(
              TextSpan(
                style: GoogleFonts.firaCode(fontSize: 12, height: 1.8),
                children: const [
                  TextSpan(text: 'class ', style: TextStyle(color: Color(0xFFC792EA))),
                  TextSpan(text: 'Developer ', style: TextStyle(color: Color(0xFF82AAFF))),
                  TextSpan(text: '{\n', style: TextStyle(color: AppColors.textPrimary)),
                  TextSpan(text: '  final ', style: TextStyle(color: Color(0xFFC792EA))),
                  TextSpan(text: 'name ', style: TextStyle(color: AppColors.textPrimary)),
                  TextSpan(text: '= ', style: TextStyle(color: AppColors.textPrimary)),
                  TextSpan(text: "'Sagar Zadafiya'", style: TextStyle(color: Color(0xFFC3E88D))),
                  TextSpan(text: ';\n', style: TextStyle(color: AppColors.textPrimary)),
                  TextSpan(text: '  final ', style: TextStyle(color: Color(0xFFC792EA))),
                  TextSpan(text: 'exp ', style: TextStyle(color: AppColors.textPrimary)),
                  TextSpan(text: '= ', style: TextStyle(color: AppColors.textPrimary)),
                  TextSpan(text: '6', style: TextStyle(color: Color(0xFFF78C6C))),
                  TextSpan(text: ';\n', style: TextStyle(color: AppColors.textPrimary)),
                  TextSpan(text: '  // Passionate about Flutter 💙\n', style: TextStyle(color: Color(0xFF546E7A))),
                  TextSpan(text: '  ', style: TextStyle(color: AppColors.textPrimary)),
                  TextSpan(text: 'Widget ', style: TextStyle(color: Color(0xFF82AAFF))),
                  TextSpan(text: 'build', style: TextStyle(color: Color(0xFF82AAFF))),
                  TextSpan(text: '() => ', style: TextStyle(color: AppColors.textPrimary)),
                  TextSpan(text: 'AwesomeApp', style: TextStyle(color: Color(0xFF82AAFF))),
                  TextSpan(text: '();\n}', style: TextStyle(color: AppColors.textPrimary)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Pill tags
          Wrap(
            spacing: 7, runSpacing: 7,
            children: const [
              PillTag('Flutter 3.x', style: PillStyle.indigo),
              PillTag('Dart',        style: PillStyle.sky),
              PillTag('BLoC',        style: PillStyle.indigo),
              PillTag('Firebase',    style: PillStyle.emerald),
              PillTag('Riverpod',    style: PillStyle.indigo),
              PillTag('GetX',        style: PillStyle.pink),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String num;
  final String label;
  const _StatItem({required this.num, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (b) => AppColors.accentGrad
              .createShader(Rect.fromLTWH(0, 0, b.width, b.height)),
          child: Text(num,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 28, fontWeight: FontWeight.w800,
                color: Colors.white, letterSpacing: -1,
              )),
        ),
        Text(label.toUpperCase(),
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10, fontWeight: FontWeight.w700,
              color: AppColors.textDim, letterSpacing: 1,
            )),
      ],
    );
  }
}

class _GlowDot extends StatefulWidget {
  final Color color;
  final double size;
  const _GlowDot({required this.color, this.size = 7});
  @override
  State<_GlowDot> createState() => _GlowDotState();
}

class _GlowDotState extends State<_GlowDot> with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _a;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat(reverse: true);
    _a = CurvedAnimation(parent: _c, curve: Curves.easeInOut);
  }
  @override
  void dispose() { _c.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _a,
    builder: (_, __) => Container(
      width: widget.size, height: widget.size,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.4 + 0.6 * _a.value),
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: widget.color.withOpacity(0.5 * _a.value), blurRadius: 6)],
      ),
    ),
  );
}
