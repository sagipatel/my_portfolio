# ⚡ Flutter Portfolio — Glass UI

A fully responsive Flutter Web portfolio with a stunning **Glassmorphism** design.

---

## 🎨 Design Features

- **Glass UI** — `BackdropFilter` blur cards with inner shine overlays
- **Animated background** — 4 drifting color orbs + subtle grid
- **Gradient branding** — Indigo `#6C63FF` → Violet `#A78BFA` → Sky `#38BDF8`
- **Floating pill navbar** — active section highlighting + smooth scroll
- **Animated skill bars** — triggered on scroll via `VisibilityDetector`
- **Hover micro-interactions** — card lift, glow, color transitions
- **Fully responsive** — Mobile / Tablet / Desktop layouts
- **Dark code snippet** — Dart syntax highlighting in Hero card

---

## 📁 Project Structure

```
lib/
├── main.dart                      # App entry point
├── theme/
│   └── app_theme.dart             # Colors, gradients, glass helper
├── models/
│   └── portfolio_data.dart        # All content data
├── widgets/
│   ├── glass_widgets.dart         # GlassCard, PillTag, AnimatedSkillBar, etc.
│   ├── animated_background.dart   # Orbs + grid background
│   └── navbar.dart                # Floating pill navigation
└── screens/
    ├── portfolio_screen.dart      # Main scroll scaffold
    ├── hero_section.dart          # Hero with code card
    └── sections.dart              # About, Skills, Projects, Contact, Footer
```

---

## 🚀 Quick Start

### Prerequisites
- Flutter SDK `>=3.10.0`
- Dart SDK `>=3.0.0`

### 1. Get dependencies
```bash
flutter pub get
```

### 2. Run on Chrome (development)
```bash
flutter run -d chrome
```

### 3. Build for production
```bash
flutter build web --release --web-renderer canvaskit
```
Your production build will be in `build/web/` — deploy to Firebase Hosting, Vercel, Netlify, or GitHub Pages.

---

## ✏️ Personalise It

All content is in **one file**: `lib/models/portfolio_data.dart`

Just update:
```dart
static const name = 'Your Name';
static const role = 'Your Role';
static const email = 'you@email.com';
// ... projects, skills, experiences
```

---

## 📦 Dependencies

| Package | Purpose |
|---------|---------|
| `google_fonts` | Plus Jakarta Sans + Fira Code |
| `visibility_detector` | Trigger skill bar animations on scroll |
| `animate_do` | Section entrance animations |

---

## 🌐 Deploy to Firebase Hosting

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login & init
firebase login
firebase init hosting

# Build & deploy
flutter build web --release
firebase deploy
```

---

Built with 💙 Flutter
