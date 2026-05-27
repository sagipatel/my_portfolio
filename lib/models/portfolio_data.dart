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
  static const linkedin = 'linkedin.com/in/sagar-zadafiya';
  static const github = 'github.com/sagipatel';
  static const twitter = '@alexmorgan_dev';

  static const stats = [
    ('6+', 'Years Exp.'),
    ('40+', 'Apps Shipped'),
    ('12M+', 'Users'),
    ('98%', 'Satisfaction'),
  ];

  static const experiences = [
    Experience('2024 — Present', 'Senior Flutter Developer', 'FunFull · Ahmedabad (Based-USA)'),
    Experience('2023 — 2024', 'Sr.Flutter Engineer', 'Tweleve Springs Limited · (UK)Remote'),
    Experience('2020 — 2023', 'Flutter Developer', 'Auxano Global Service · Ahmedabad'),
    Experience('2019 — 2020', 'Angular Js & Flutter Trainee', 'GeekMindz Solution'),
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
        SkillBar('Riverpod', 0.80, SkillBarColor.sky),
        SkillBar('BLoC / Cubit', 0.75, SkillBarColor.sky),
        SkillBar('GetX', 0.90, SkillBarColor.sky),
        SkillBar('Provider', 0.65, SkillBarColor.sky),
      ],
    ),
    SkillCategory(
      title: 'AI & Automation',
      subtitle: 'AI/n8n',
      icon: '🤖',
      bars: [
        SkillBar('OpenAI/GPT APIs', 0.87, SkillBarColor.indigo),
        SkillBar('Gemini AI', 0.74, SkillBarColor.indigo),
        SkillBar('n8n Automation', 0.88, SkillBarColor.indigo),
        SkillBar('AI Chatbots', 0.78, SkillBarColor.indigo),
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
      name: 'ScanNova: Food & Cosmetic Scan',
      desc: 'ScanNova is the food scanner and cosmetic scanner that deciphers product labels and evaluates their health impact — in one quick scan.\n\nIn a world of incomprehensible ingredient labels, ScanNova gives you clear-sighted purchases with a simple color code Excellent, Good, Mediocre, or Poor. Tap any product for a detailed ingredient analysis so you always understand its grade.\n\n◆ 4 MILLION FOOD PRODUCTS ◆\nEvery food product is evaluated across 3 objective criteria: nutritional value, food additives, and the organic dimension. No guessing — just science.\n\n◆ 3 MILLION BEAUTY PRODUCTS ◆\nScanNova\'s ingredient scanner analyzes every ingredient in your beauty products and personal care items. Each ingredient is assigned a risk level based on current scientific research.\n\n◆ BEST PRODUCT RECOMMENDATIONS ◆\nFor any product with a poor health rating, ScanNova recommends a healthier alternative — a similar product that\'s genuinely better for you.\n\n◆ 100% INDEPENDENT ◆\nScanNova is a 100% independent app. All product evaluations and product recommendations are completely objective — no brand, no manufacturer, no advertiser can influence them. Learn more about our funding on our websit',
      icon: '🥑',
      tags: ['Flutter', 'GetX', 'N8n Workflow', 'Gemini AI', 'Firebase'],
      liveUrl: 'https://play.google.com/store/apps/details?id=com.app.scan_eats.scan_eats',
      featured: true,
      metrics: {'4M+': 'Food Products', '3M+': 'Beauty Products', '100%': 'Independent'},
      platforms: ['iOS', 'Android'],
    ),
    Project(
      name: 'MindDuel',
      desc: 'Get ready to challenge your instincts and dive deep into your decision-making skills with Mind Duel – a fresh twist on the classic “Would You Rather” game! Whether you\'re seeking a laugh, a deep conversation, or just a quick escape from boredom, Mind Duel has you covered.',
      icon: '🧠',
      tags: ['Flutter', 'GetX', 'Firebase', 'Game'],
      liveUrl: 'https://play.google.com/store/apps/details?id=com.app.mind_duel',
    ),
    Project(
      name: 'TipZen – Tip & Bill Splitter',
      desc: 'TipZen – The Smartest Tip Calculator & Bill Splitter!\n\nEating out and not sure how much to tip? TipZen gives you the perfect tip amount in seconds. Whether you\'re at a restaurant, hotel, taxi, hair salon or café — TipZen makes tipping stress-free!',
      icon: '💸',
      tags: ['Flutter', 'Riverpod', 'Firebase', 'GraphQL'],
      liveUrl: 'https://play.google.com/store/apps/details?id=com.tipzen.tip_calc',
    ),
    Project(
      name: 'MindJournal — Personal Journal App',
      desc: 'The app integrates an AI-powered mood tracker that analyzes the text of each entry to detect the user\'s emotional state, automatically tagging entries with mood insights and helping users visualize emotional patterns over time.\n\nKey Features:\n• Daily journal entries with rich text input\n• Image upload and attachment for each entry\n• Unified timeline showing all entries by date\n• AI-based mood detection and tracking from entry content\n• Mood history and trend visualization',
      icon: '📔',
      tags: ['Flutter', 'Dart', 'Firebase', 'OpenAI', 'BLoC'],
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
    Project(
      name: 'CryptoTracker',
      desc: 'Real-time cryptocurrency portfolio tracker and market analysis tool with advanced charting, price alerts, and live market data.',
      icon: '📈',
      tags: ['Flutter', 'Riverpod', 'WebSockets', 'Firebase'],
    ),
    Project(
      name: 'TaskMaster',
      desc: 'A productivity app focusing on the Pomodoro technique with task management, deep focus analytics, and cross-device cloud sync.',
      icon: '⏱️',
      tags: ['Flutter', 'Provider', 'SQLite', 'Local Notifs'],
    ),
    Project(
      name: 'TiffinBot — WhatsApp Vendor Automation',
      desc: 'An end-to-end WhatsApp automation platform built for tiffin service vendors, eliminating manual order tracking and payment follow-ups.\n\nVendors manage their entire tiffin business through a conversational WhatsApp bot — customers place and modify daily meal orders, and vendors get a real-time dashboard showing total active orders, delivery slots, and customer preferences.\n\nWhen a vendor configures a weekly or monthly billing cycle, the system automatically generates personalized payment links via Razorpay and dispatches them to each customer over WhatsApp at the right time — zero manual effort required.\n\nKey capabilities: real-time order tracking, automated payment link dispatch, customer subscription management, daily order summaries, and a Flutter companion app for vendor analytics and menu control.',
      icon: '🤖',
      tags: ['Flutter', 'Node.js', 'n8n', 'WhatsApp API', 'Razorpay', 'Firebase', 'Gemini AI'],
    ),
  ];
}
