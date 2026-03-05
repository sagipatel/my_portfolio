// lib/screens/sections.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';
import '../models/portfolio_data.dart';
import '../widgets/glass_widgets.dart';

// ══════════════════════════════════════════════════
// ABOUT SECTION
// ══════════════════════════════════════════════════
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isSmall = w < 900;

    return _SectionWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            chip: 'About Me',
            title: 'Passionate about ',
            highlightedWord: 'great software',
            subtitle: 'Building products that are beautiful, fast, and maintainable — from first commit to App Store.',
          ),
          const SizedBox(height: 56),
          isSmall
              ? Column(children: [_AboutTextCard(), const SizedBox(height: 20), _TimelineCard()])
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _AboutTextCard()),
                    const SizedBox(width: 28),
                    Expanded(child: _TimelineCard()),
                  ],
                ),
        ],
      ),
    );
  }
}

class _AboutTextCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AboutPara("I'm a <b>Senior Flutter Developer</b> with 6+ years of crafting cross-platform mobile applications used by millions. I specialise in clean architecture, scalable state management, and pixel-perfect UI."),
          const SizedBox(height: 14),
          _AboutPara("I've worked with <b>startups, scale-ups and Fortune 500 companies</b> across fintech, healthcare, edtech, and e-commerce — always obsessing over performance, DX, and shipping on time."),
          const SizedBox(height: 14),
          _AboutPara("When not coding I contribute to open-source Flutter packages, write technical articles, and mentor junior mobile developers."),
          const SizedBox(height: 24),
          // Highlights grid
          GridView.count(
            crossAxisCount: 2, shrinkWrap: true,
            crossAxisSpacing: 14, mainAxisSpacing: 14,
            childAspectRatio: 2.8,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              _HighlightMini(icon: '📱', title: 'iOS & Android', sub: 'CROSS-PLATFORM'),
              _HighlightMini(icon: '🌐', title: 'Flutter Web', sub: 'PWA READY'),
              _HighlightMini(icon: '🏗️', title: 'Clean Arch', sub: 'SOLID PRINCIPLES'),
              _HighlightMini(icon: '🚀', title: 'CI / CD', sub: 'CODEMAGIC · FASTLANE'),
            ],
          ),
        ],
      ),
    );
  }
}

class _AboutPara extends StatelessWidget {
  final String text;
  const _AboutPara(this.text);

  @override
  Widget build(BuildContext context) {
    // Parse simple <b> tags
    final parts = text.split(RegExp(r'<b>|</b>'));
    bool bold = false;
    final spans = <TextSpan>[];
    for (final part in parts) {
      spans.add(TextSpan(
        text: part,
        style: TextStyle(
          fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
          color: bold ? AppColors.textPrimary : AppColors.textSub,
        ),
      ));
      bold = !bold;
    }
    return Text.rich(
      TextSpan(children: spans),
      style: GoogleFonts.plusJakartaSans(fontSize: 14, height: 1.8),
    );
  }
}

class _HighlightMini extends StatefulWidget {
  final String icon, title, sub;
  const _HighlightMini({required this.icon, required this.title, required this.sub});
  @override
  State<_HighlightMini> createState() => _HighlightMiniState();
}

class _HighlightMiniState extends State<_HighlightMini> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    cursor: SystemMouseCursors.click,
    onEnter: (_) => setState(() => _hovered = true),
    onExit:  (_) => setState(() => _hovered = false),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _hovered ? AppColors.indigo.withOpacity(0.1) : Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _hovered ? AppColors.indigo.withOpacity(0.35) : AppColors.glassBorder),
      ),
      child: Row(children: [
        Text(widget.icon, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.title, style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            Text(widget.sub,   style: GoogleFonts.plusJakartaSans(fontSize: 9,  fontWeight: FontWeight.w600, color: AppColors.textDim, letterSpacing: 0.5)),
          ],
        ),
      ]),
    ),
  );
}

class _TimelineCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Experience Timeline',
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 15)),
          Divider(color: AppColors.glassBorder, height: 28),
          ...List.generate(PortfolioData.experiences.length, (i) {
            final e = PortfolioData.experiences[i];
            final last = i == PortfolioData.experiences.length - 1;
            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 14,
                    child: Column(children: [
                      Container(
                        width: 14, height: 14,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGrad,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: AppColors.indigo.withOpacity(0.6), blurRadius: 12)],
                        ),
                      ),
                      if (!last)
                        Expanded(child: Container(
                          width: 2,
                          color: AppColors.indigo.withOpacity(0.3),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                        )),
                    ]),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: last ? 0 : 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.year,
                              style: GoogleFonts.firaCode(fontSize: 11, color: AppColors.violet, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 3),
                          Text(e.role,
                              style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w700)),
                          Text(e.company,
                              style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSub)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════
// SKILLS SECTION
// ══════════════════════════════════════════════════
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isSmall = w < 700;
    final cols = isSmall ? 1 : (w < 1000 ? 2 : 3);

    return _SectionWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            chip: 'Tech Stack',
            title: 'What I ',
            highlightedWord: 'work with',
            subtitle: 'A carefully chosen toolkit built over 6 years of production Flutter development.',
          ),
          const SizedBox(height: 56),
          // Skill category cards
          _ResponsiveGrid(
            cols: cols,
            children: PortfolioData.skillCategories.map((cat) => _SkillCategoryCard(cat: cat)).toList(),
          ),
          const SizedBox(height: 20),
          // Tools wide card
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  _SkillIcon(icon: '🛠️', color: AppColors.pink),
                  const SizedBox(width: 10),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Tools, Architecture & DevOps', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 14)),
                    Text('Everything around the code',  style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textDim)),
                  ]),
                ]),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 9, runSpacing: 9,
                  children: PortfolioData.toolPills.map((t) {
                    final styles = [PillStyle.indigo, PillStyle.sky, PillStyle.emerald, PillStyle.pink];
                    final s = styles[PortfolioData.toolPills.indexOf(t) % styles.length];
                    return PillTag(t, style: s);
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillCategoryCard extends StatefulWidget {
  final SkillCategory cat;
  const _SkillCategoryCard({required this.cat});
  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool _animate = false;

  Gradient get _gradient => switch (widget.cat.bars.first.color) {
    SkillBarColor.sky     => const LinearGradient(colors: [AppColors.sky, Color(0xFF2DD4BF)]),
    SkillBarColor.emerald => AppColors.emeraldGrad,
    SkillBarColor.pink    => LinearGradient(colors: [AppColors.pink, Colors.orange.shade400]),
    _                     => AppColors.primaryGrad,
  };

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.cat.title),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_animate) {
          setState(() => _animate = true);
        }
      },
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              _SkillIcon(icon: widget.cat.icon, color: AppColors.indigo),
              const SizedBox(width: 10),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(widget.cat.title,  style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 14)),
                Text(widget.cat.subtitle, style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textDim)),
              ]),
            ]),
            Divider(color: AppColors.glassBorder, height: 24),
            ...widget.cat.bars.map((bar) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: AnimatedSkillBar(
                name: bar.name,
                value: bar.percent,
                gradient: _gradient,
                animate: _animate,
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class _SkillIcon extends StatelessWidget {
  final String icon;
  final Color color;
  const _SkillIcon({required this.icon, required this.color});
  @override
  Widget build(BuildContext context) => Container(
    width: 36, height: 36,
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.2)),
    ),
    child: Center(child: Text(icon, style: const TextStyle(fontSize: 14))),
  );
}

// ══════════════════════════════════════════════════
// PROJECTS SECTION
// ══════════════════════════════════════════════════
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isSmall = w < 700;
    final featured = PortfolioData.projects.first;
    final rest = PortfolioData.projects.skip(1).toList();
    final cols = isSmall ? 1 : (w < 1000 ? 2 : 3);

    return _SectionWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            chip: 'Projects',
            title: 'Selected ',
            highlightedWord: 'Work',
            subtitle: 'A handpicked selection of apps shipped to production for real users.',
          ),
          const SizedBox(height: 56),

          // Featured
          GlassCard(
            hoverable: true,
            child: isSmall
                ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    _FeaturedLeft(project: featured),
                    const SizedBox(height: 24),
                    _FeaturedRight(project: featured),
                  ])
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _FeaturedLeft(project: featured)),
                      const SizedBox(width: 24),
                      SizedBox(width: 240, child: _FeaturedRight(project: featured)),
                    ],
                  ),
          ),

          const SizedBox(height: 20),
          _ResponsiveGrid(
            cols: cols,
            children: rest.map((p) => _ProjectCard(project: p)).toList(),
          ),
        ],
      ),
    );
  }
}

class _FeaturedLeft extends StatelessWidget {
  final Project project;
  const _FeaturedLeft({required this.project});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.indigo.withOpacity(0.15),
            border: Border.all(color: AppColors.indigo.withOpacity(0.25)),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text('⭐ Featured Project',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10, fontWeight: FontWeight.w700,
                color: AppColors.violet, letterSpacing: 0.5,
              )),
        ),
        const SizedBox(height: 12),
        Text(project.icon, style: const TextStyle(fontSize: 40)),
        const SizedBox(height: 10),
        Text(project.name,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -0.5,
            )),
        const SizedBox(height: 10),
        Text(project.desc,
            style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.textSub, height: 1.6)),
        const SizedBox(height: 16),
        Wrap(spacing: 7, runSpacing: 7,
          children: project.tags.map((t) => PillTag(t, style: PillStyle.indigo)).toList()),
        const SizedBox(height: 18),
        Wrap(spacing: 10, children: [
          _LinkButton(label: '↗ Live App', filled: true),
          _LinkButton(label: 'GitHub'),
        ]),
      ],
    );
  }
}

class _FeaturedRight extends StatelessWidget {
  final Project project;
  const _FeaturedRight({required this.project});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [AppColors.indigo.withOpacity(0.15), AppColors.sky.withOpacity(0.08)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.indigo.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          ...project.metrics!.entries.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ShaderMask(
                  shaderCallback: (b) => AppColors.accentGrad
                      .createShader(Rect.fromLTWH(0, 0, b.width, b.height)),
                  child: Text(e.key,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white,
                      )),
                ),
                Text(e.value,
                    style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSub)),
              ]),
            ),
          )),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('PLATFORMS',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10, fontWeight: FontWeight.w700,
                    color: AppColors.textSub, letterSpacing: 0.5,
                  )),
              const SizedBox(height: 8),
              Wrap(spacing: 6, runSpacing: 6,
                children: project.platforms!.map((p) => PillTag(p, style: PillStyle.sky)).toList()),
            ]),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;
  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      hoverable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 46, height: 46,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: Center(child: Text(project.icon, style: const TextStyle(fontSize: 20))),
              ),
              Row(children: [
                _LinkButton(label: '↗', filled: false, small: true),
                const SizedBox(width: 8),
                _LinkButton(label: 'GH', filled: false, small: true),
              ]),
            ],
          ),
          const SizedBox(height: 18),
          Text(project.name,
              style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(project.desc,
              style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.textSub, height: 1.6)),
          const SizedBox(height: 16),
          Wrap(spacing: 7, runSpacing: 7,
            children: project.tags.asMap().entries.map((e) {
              final styles = [PillStyle.indigo, PillStyle.sky, PillStyle.emerald, PillStyle.pink];
              return PillTag(e.value, style: styles[e.key % styles.length]);
            }).toList()),
        ],
      ),
    );
  }
}

class _LinkButton extends StatefulWidget {
  final String label;
  final bool filled;
  final bool small;
  const _LinkButton({required this.label, this.filled = false, this.small = false});
  @override
  State<_LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<_LinkButton> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    cursor: SystemMouseCursors.click,
    onEnter: (_) => setState(() => _hovered = true),
    onExit:  (_) => setState(() => _hovered = false),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: EdgeInsets.symmetric(
        horizontal: widget.small ? 10 : 18,
        vertical: widget.small ? 7 : 10,
      ),
      decoration: BoxDecoration(
        gradient: widget.filled ? AppColors.primaryGrad : null,
        color: widget.filled ? null
            : (_hovered ? AppColors.indigo.withOpacity(0.15) : Colors.white.withOpacity(0.05)),
        borderRadius: BorderRadius.circular(100),
        border: widget.filled ? null : Border.all(color: _hovered ? AppColors.violet : AppColors.glassBorder),
        boxShadow: widget.filled ? [BoxShadow(color: AppColors.indigo.withOpacity(0.4), blurRadius: 16, offset: const Offset(0,4))] : null,
      ),
      child: Text(widget.label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: widget.small ? 11 : 13, fontWeight: FontWeight.w700,
            color: widget.filled ? Colors.white : (_hovered ? AppColors.violet : AppColors.textSub),
          )),
    ),
  );
}

// ══════════════════════════════════════════════════
// CONTACT SECTION
// ══════════════════════════════════════════════════
class ContactSection extends StatefulWidget {
  const ContactSection({super.key});
  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameCtrl    = TextEditingController();
  final _emailCtrl   = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _msgCtrl     = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose(); _emailCtrl.dispose();
    _subjectCtrl.dispose(); _msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isSmall = w < 900;
    return _SectionWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            chip: 'Contact',
            title: 'Let\'s build ',
            highlightedWord: 'something great',
            subtitle: 'Open for freelance, full-time roles, and consulting. Response guaranteed within 24 hours.',
          ),
          const SizedBox(height: 56),
          isSmall
              ? Column(children: [_ContactInfo(), const SizedBox(height: 20), _ContactForm(nameCtrl: _nameCtrl, emailCtrl: _emailCtrl, subjectCtrl: _subjectCtrl, msgCtrl: _msgCtrl)])
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _ContactInfo()),
                    const SizedBox(width: 28),
                    Expanded(child: _ContactForm(nameCtrl: _nameCtrl, emailCtrl: _emailCtrl, subjectCtrl: _subjectCtrl, msgCtrl: _msgCtrl)),
                  ],
                ),
        ],
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(children: [
              TextSpan(text: 'Got a project\nin ', style: GoogleFonts.plusJakartaSans(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: -0.5, height: 1.15)),
              WidgetSpan(child: ShaderMask(
                shaderCallback: (b) => AppColors.accentGrad.createShader(Rect.fromLTWH(0, 0, b.width, b.height)),
                child: Text('mind?', style: GoogleFonts.plusJakartaSans(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -0.5)),
              )),
            ]),
          ),
          const SizedBox(height: 14),
          Text('I work with clients globally across all timezones. Whether it\'s a brand-new app, a Flutter migration, or a performance audit — let\'s talk.',
              style: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.textSub, height: 1.7)),
          const SizedBox(height: 28),
          ContactChannel(icon: '✉️', label: PortfolioData.email),
          const SizedBox(height: 10),
          ContactChannel(icon: '💼', label: PortfolioData.linkedin),
          const SizedBox(height: 10),
          ContactChannel(icon: '🐙', label: PortfolioData.github),
          // const SizedBox(height: 10),
          // ContactChannel(icon: '𝕏', label: PortfolioData.twitter),
        ],
      ),
    );
  }
}

class _ContactForm extends StatelessWidget {
  final TextEditingController nameCtrl, emailCtrl, subjectCtrl, msgCtrl;
  const _ContactForm({required this.nameCtrl, required this.emailCtrl, required this.subjectCtrl, required this.msgCtrl});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Send a Message', style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 24),
          Row(children: [
            Expanded(child: _Field(label: 'Name',  ctrl: nameCtrl,  hint: 'Your name')),
            const SizedBox(width: 14),
            Expanded(child: _Field(label: 'Email', ctrl: emailCtrl, hint: 'your@email.com')),
          ]),
          const SizedBox(height: 16),
          _Field(label: 'Subject', ctrl: subjectCtrl, hint: 'Project inquiry'),
          const SizedBox(height: 16),
          _Field(label: 'Message', ctrl: msgCtrl, hint: 'Tell me about your project, timeline, and budget...', maxLines: 5),
          const SizedBox(height: 20),
          GlowButton(label: 'Send Message →', onTap: () {}),
        ],
      ),
    );
  }
}

class _Field extends StatefulWidget {
  final String label, hint;
  final TextEditingController ctrl;
  final int maxLines;
  const _Field({required this.label, required this.ctrl, required this.hint, this.maxLines = 1});
  @override
  State<_Field> createState() => _FieldState();
}

class _FieldState extends State<_Field> {
  bool _focused = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11, fontWeight: FontWeight.w600,
              color: AppColors.textSub, letterSpacing: 0.3,
            )),
        const SizedBox(height: 7),
        Focus(
          onFocusChange: (f) => setState(() => _focused = f),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _focused ? AppColors.indigo.withOpacity(0.5) : AppColors.glassBorder,
                width: _focused ? 1.5 : 1,
              ),
              boxShadow: _focused
                  ? [BoxShadow(color: AppColors.indigo.withOpacity(0.12), blurRadius: 12)]
                  : [],
            ),
            child: TextField(
              controller: widget.ctrl,
              maxLines: widget.maxLines,
              style: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.textDim),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════
// FOOTER
// ══════════════════════════════════════════════════
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.glassBorder)),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShaderMask(
              shaderCallback: (b) => AppColors.accentGrad.createShader(Rect.fromLTWH(0,0,b.width,b.height)),
              child: Text('⚡ Flutter.dev',
                  style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 14, color: Colors.white)),
            ),
            if (w > 600)
              Text('© 2024 Alex Morgan · Built with Flutter 💙',
                  style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textDim)),
            TextButton(
              onPressed: () {},
              child: Text('Back to top ↑',
                  style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSub)),
            ),
          ],
        ),
      ),
    );
  }
}

// ── HELPERS ──────────────────────────────────────
class _SectionWrap extends StatelessWidget {
  final Widget child;
  const _SectionWrap({required this.child});
  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1100),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: child,
      ),
    ),
  );
}

class _ResponsiveGrid extends StatelessWidget {
  final int cols;
  final List<Widget> children;
  const _ResponsiveGrid({required this.cols, required this.children});

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (int i = 0; i < children.length; i += cols) {
      final rowChildren = children.sublist(i, (i + cols).clamp(0, children.length));
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rowChildren.expand((w) => [Expanded(child: w), if (w != rowChildren.last) const SizedBox(width: 20)]).toList(),
        ),
      );
      if (i + cols < children.length) rows.add(const SizedBox(height: 20));
    }
    return Column(children: rows);
  }
}
