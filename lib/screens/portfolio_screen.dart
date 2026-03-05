// lib/screens/portfolio_screen.dart
import 'package:flutter/material.dart';
import '../widgets/animated_background.dart';
import '../widgets/navbar.dart';
import 'hero_section.dart';
import 'sections.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});
  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final _scrollCtrl = ScrollController();
  String _activeSection = 'hero';

  final _heroKey     = GlobalKey();
  final _aboutKey    = GlobalKey();
  final _skillsKey   = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey  = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollCtrl.removeListener(_onScroll);
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollCtrl.offset;
    String section = 'hero';

    void check(GlobalKey key, String name) {
      final ctx = key.currentContext;
      if (ctx == null) return;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) return;
      final pos = box.localToGlobal(Offset.zero, ancestor: null).dy + _scrollCtrl.offset;
      if (offset >= pos - 120) section = name;
    }

    check(_aboutKey,    'about');
    check(_skillsKey,   'skills');
    check(_projectsKey, 'projects');
    check(_contactKey,  'contact');

    if (section != _activeSection) setState(() => _activeSection = section);
  }

  void _scrollTo(String section) {
    final key = switch (section) {
      'about'    => _aboutKey,
      'skills'   => _skillsKey,
      'projects' => _projectsKey,
      'contact'  => _contactKey,
      _          => _heroKey,
    };
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B14),
      body: Stack(
        children: [
          // Animated background (fixed)
          const Positioned.fill(
            child: AnimatedBackground(child: SizedBox.expand()),
          ),

          // Scrollable content
          SingleChildScrollView(
            controller: _scrollCtrl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Hero
                SizedBox(
                  key: _heroKey,
                  child: HeroSection(
                    onViewProjects: () => _scrollTo('projects'),
                    onContact:      () => _scrollTo('contact'),
                  ),
                ),

                // About
                SizedBox(key: _aboutKey, child: const AboutSection()),

                // Skills
                SizedBox(key: _skillsKey, child: const SkillsSection()),

                // Projects
                SizedBox(key: _projectsKey, child: const ProjectsSection()),

                // Contact
                SizedBox(key: _contactKey, child: const ContactSection()),

                // Footer
                const Center(child: FooterSection()),
              ],
            ),
          ),

          // Floating Navbar (on top)
          PortfolioNavbar(
            activeSection: _activeSection,
            onNavTap: _scrollTo,
          ),
        ],
      ),
    );
  }
}
