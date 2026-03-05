// lib/models/portfolio_data.dart

class SkillBar {
  final String name;
  final double percent;
  final SkillBarColor color;
  const SkillBar(this.name, this.percent, [this.color = SkillBarColor.indigo]);
}

enum SkillBarColor { indigo, sky, emerald, pink }

class SkillCategory {
  final String title;
  final String subtitle;
  final String icon;
  final List<SkillBar> bars;
  const SkillCategory({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.bars,
  });
}

class Project {
  final String name;
  final String desc;
  final String icon;
  final List<String> tags;
  final String? liveUrl;
  final String? githubUrl;
  final bool featured;
  final Map<String, String>? metrics;
  final List<String>? platforms;
  const Project({
    required this.name,
    required this.desc,
    required this.icon,
    required this.tags,
    this.liveUrl,
    this.githubUrl,
    this.featured = false,
    this.metrics,
    this.platforms,
  });
}

class Experience {
  final String year;
  final String role;
  final String company;
  const Experience(this.year, this.role, this.company);
}

class PortfolioData {
  static const name = 'Sagar Zadafiya';
  static const role = 'Senior Flutter Developer';
  static const tagline =
      'Crafting pixel-perfect, high-performance Flutter apps for iOS, Android & Web. 6+ years turning ideas into products that users love.';
  static const email = 'sagarzadafiya1808@gmail.com';
  static const linkedin = 'linkedin.com/in/sagarzadafiya';
  static const github = 'github.com/sagarzadafiya';
  static const twitter = '@alexmorgan_dev';

  static const stats = [
    ('6+', 'Years Exp.'),
    ('40+', 'Apps Shipped'),
    ('12M+', 'Users'),
    ('98%', 'Satisfaction'),
  ];

  static const experiences = [
    Experience('2022 — Present', 'Senior Flutter Developer', 'NovaTech Labs · San Francisco'),
    Experience('2020 — 2022', 'Flutter Engineer', 'Finova Fintech · Remote'),
    Experience('2018 — 2020', 'Mobile Developer', 'AppForge Studio · New York'),
    Experience('2017 — 2018', 'Junior Developer', 'Pixel Craft Agency'),
  ];

  static const skillCategories = [
    SkillCategory(
      title: 'Flutter Core',
      subtitle: 'Primary expertise',
      icon: '💙',
      bars: [
        SkillBar('Flutter / Dart', 0.98),
        SkillBar('Custom Animations', 0.93),
        SkillBar('Flutter Web', 0.88),
        SkillBar('Platform Channels', 0.85),
      ],
    ),
    SkillCategory(
      title: 'State Management',
      subtitle: 'Architecture patterns',
      icon: '⚙️',
      bars: [
        SkillBar('Riverpod', 0.96, SkillBarColor.sky),
        SkillBar('BLoC / Cubit', 0.95, SkillBarColor.sky),
        SkillBar('GetX', 0.90, SkillBarColor.sky),
        SkillBar('Provider', 0.92, SkillBarColor.sky),
      ],
    ),
    SkillCategory(
      title: 'Backend & APIs',
      subtitle: 'Data & services',
      icon: '🔥',
      bars: [
        SkillBar('Firebase Suite', 0.94, SkillBarColor.emerald),
        SkillBar('REST APIs', 0.97, SkillBarColor.emerald),
        SkillBar('GraphQL', 0.82, SkillBarColor.emerald),
        SkillBar('Supabase', 0.86, SkillBarColor.emerald),
      ],
    ),
  ];

  static const toolPills = [
    'Clean Architecture', 'MVVM', 'TDD', 'SOLID',
    'Codemagic CI/CD', 'Fastlane', 'GitHub Actions',
    'Figma', 'Lottie / Rive', 'Crashlytics',
    'WebRTC', 'Socket.io', 'ARKit / ARCore',
  ];

  static const projects = [
    Project(
      name: 'PayFlow — Fintech Wallet',
      desc: 'Full-featured digital wallet with P2P transfers, real-time spending analytics, card management, and biometric authentication. Built from 0 to 1M+ downloads in 8 months.',
      icon: '💳',
      tags: ['Flutter', 'BLoC', 'Firebase', 'Stripe', 'Biometrics'],
      featured: true,
      metrics: {'1M+': 'Play Store Downloads', '4.8★': 'Average Rating', '60fps': 'Smooth Performance'},
      platforms: ['iOS', 'Android', 'Web'],
    ),
    Project(
      name: 'MedTrack',
      desc: 'Patient health tracking with appointment scheduling, medication reminders, and real-time doctor video chat via WebRTC.',
      icon: '🏥',
      tags: ['Flutter', 'Riverpod', 'WebRTC', 'Firebase'],
    ),
    Project(
      name: 'ShopNest',
      desc: 'E-commerce platform with AR product preview, smart search, personalized recommendations, and seamless Stripe checkout.',
      icon: '🛒',
      tags: ['Flutter', 'GetX', 'ARKit', 'GraphQL'],
    ),
    Project(
      name: 'LearnIt',
      desc: 'Interactive edtech platform with video courses, live quizzes, gamification, and offline content for 500K+ learners.',
      icon: '📚',
      tags: ['Flutter', 'Supabase', 'Lottie', 'Hive'],
    ),
    Project(
      name: 'FitPulse',
      desc: 'Wearable-connected fitness tracker with custom workout plans, progress analytics, and Apple Health / Google Fit integration.',
      icon: '🏋️',
      tags: ['Flutter', 'BLoC', 'HealthKit', 'SQLite'],
    ),
    Project(
      name: 'RoamAI',
      desc: 'AI-powered travel companion with smart itinerary generation, offline maps, local discovery, and budget management.',
      icon: '🗺️',
      tags: ['Flutter', 'Riverpod', 'OpenAI', 'MapBox'],
    ),
  ];
}
