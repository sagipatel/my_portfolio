// lib/widgets/navbar.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'glass_widgets.dart';

class PortfolioNavbar extends StatelessWidget {
  final String activeSection;
  final Function(String) onNavTap;

  const PortfolioNavbar({
    super.key,
    required this.activeSection,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 700;

    return Positioned(
      top: 16,
      left: 16,
      right: 16,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
              child: Container(
                padding: EdgeInsets.fromLTRB(24, 10, 10, 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColors.glassBorder),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 40,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Logo
                    ShaderMask(
                      shaderCallback: (b) => AppColors.accentGrad
                          .createShader(Rect.fromLTWH(0, 0, b.width, b.height)),
                      child: Text('⚡ Flutter.dev',
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: Colors.white,
                          )),
                    ),
                    const Spacer(),
                    // Nav links
                    if (!isMobile) ...[
                      NavTextButton(label: 'About',    active: activeSection == 'about',    onTap: () => onNavTap('about')),
                      NavTextButton(label: 'Skills',   active: activeSection == 'skills',   onTap: () => onNavTap('skills')),
                      NavTextButton(label: 'Projects', active: activeSection == 'projects', onTap: () => onNavTap('projects')),
                      NavTextButton(label: 'Contact',  active: activeSection == 'contact',  onTap: () => onNavTap('contact')),
                      const SizedBox(width: 8),
                    ],
                    // CTA
                    GestureDetector(
                      onTap: () => onNavTap('contact'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGrad,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.indigo.withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text('Hire Me →',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13, fontWeight: FontWeight.w700,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
