import 'package:flutter/material.dart';
import 'package:edidact_app/widgets/menu_barre_enfant.dart';

const _kCyan        = Color(0xFF00BCD4);
const _kCyanLight   = Color(0xFFB2EBF2);
const _kCyanBg      = Color(0xFFE0F7FA);
const _kOrange      = Color(0xFFFFA726);
const _kOrangeLight = Color(0xFFFFF3E0);
const _kGold        = Color(0xFFFFD700);
const _kSilver      = Color(0xFFB0BEC5);
const _kBronze      = Color(0xFFCD7F32);
const _kText        = Color(0xFF1A1A2E);
const _kSubText     = Color(0xFF78909C);
const _kBorder      = Color(0xFFE0E0E0);
const _kWhite       = Colors.white;

class ExercicePage extends StatelessWidget {
  final String exerciceNom;
  final String matiereNom;
  final String sousMatiereNom;
  final String lessonNom;

  const ExercicePage({
    super.key,
    required this.exerciceNom,
    required this.matiereNom,
    required this.sousMatiereNom,
    required this.lessonNom,
  });

  bool _isTablet(BuildContext ctx) =>
      MediaQuery.of(ctx).size.shortestSide >= 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            final isTablet    = _isTablet(context);
            final isLandscape = orientation == Orientation.landscape;

            if (isTablet && isLandscape) {
              return _LandscapeLayout(
                exerciceNom: exerciceNom,
                matiereNom: matiereNom,
                sousMatiereNom: sousMatiereNom,
                lessonNom: lessonNom,
              );
            } else if (isTablet) {
              return _TabletPortraitLayout(
                exerciceNom: exerciceNom,
                matiereNom: matiereNom,
                sousMatiereNom: sousMatiereNom,
                lessonNom: lessonNom,
              );
            } else {
              return _MobileLayout(
                exerciceNom: exerciceNom,
                matiereNom: matiereNom,
                sousMatiereNom: sousMatiereNom,
                lessonNom: lessonNom,
              );
            }
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Breadcrumb partagée
// ─────────────────────────────────────────────

class _Breadcrumb extends StatelessWidget {
  final String matiereNom;
  final String sousMatiereNom;
  final String lessonNom;
  final String exerciceNom;
  final bool   isTablet;

  const _Breadcrumb({
    required this.matiereNom,
    required this.sousMatiereNom,
    required this.lessonNom,
    required this.exerciceNom,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    final double fontSize = isTablet ? 14 : 12;
    final double iconSize = isTablet ? 20 : 16;

    Widget sep() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Icon(Icons.chevron_right, size: iconSize, color: Colors.grey[500]),
        );

    Widget link(String label, VoidCallback onTap) => GestureDetector(
          onTap: onTap,
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              color: _kCyan,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 20 : 16,
        vertical:   isTablet ? 14 : 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Icon(Icons.menu_book_rounded, color: Colors.red[400], size: iconSize),
            const SizedBox(width: 6),
            link('Table des matières', () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }),
            sep(),
            link(matiereNom, () {
              Navigator.of(context)
                ..pop()
                ..pop()
                ..pop();
            }),
            sep(),
            link(sousMatiereNom, () {
              Navigator.of(context)
                ..pop()
                ..pop();
            }),
            sep(),
            link(lessonNom, () {
              Navigator.of(context).pop();
            }),
            sep(),
            Text(
              exerciceNom,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Layouts
// ─────────────────────────────────────────────

class _MobileLayout extends StatelessWidget {
  final String exerciceNom;
  final String matiereNom;
  final String sousMatiereNom;
  final String lessonNom;

  const _MobileLayout({
    required this.exerciceNom,
    required this.matiereNom,
    required this.sousMatiereNom,
    required this.lessonNom,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _MenuIcon(size: 32),
          const SizedBox(height: 16),
          _Breadcrumb(
            matiereNom: matiereNom,
            sousMatiereNom: sousMatiereNom,
            lessonNom: lessonNom,
            exerciceNom: exerciceNom,
          ),
          const SizedBox(height: 24),
          const _LessonCard(index: 1),
          const SizedBox(height: 20),
          const _LessonCard(index: 2),
          const SizedBox(height: 24),
          const _ResultsBox(),
          const SizedBox(height: 20),
          _VideoBox(exerciceNom: exerciceNom),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── Tablet Portrait :
//    EN HAUT  → Résultats + Vidéo côte-à-côte
//    EN BAS   → Cartes exercices côte-à-côte
// ─────────────────────────────────────────────
class _TabletPortraitLayout extends StatelessWidget {
  final String exerciceNom;
  final String matiereNom;
  final String sousMatiereNom;
  final String lessonNom;

  const _TabletPortraitLayout({
    required this.exerciceNom,
    required this.matiereNom,
    required this.sousMatiereNom,
    required this.lessonNom,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _MenuIcon(size: 36),
          const SizedBox(height: 16),
          _Breadcrumb(
            matiereNom: matiereNom,
            sousMatiereNom: sousMatiereNom,
            lessonNom: lessonNom,
            exerciceNom: exerciceNom,
            isTablet: true,
          ),
          const SizedBox(height: 24),

          // ── EN HAUT : Résultats + Vidéo côte-à-côte ──
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: const _ResultsBox(isTablet: true),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: _VideoBox(exerciceNom: exerciceNom, isTablet: true),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── EN BAS : Cartes exercices côte-à-côte ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: const _LessonCard(index: 1, isTablet: true),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: const _LessonCard(index: 2, isTablet: true),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── Landscape :
//    Colonne GAUCHE (flex 55) → 2 cartes exercices empilées
//    Colonne DROITE (flex 45) → Résultats EN HAUT + Vidéo EN BAS
// ─────────────────────────────────────────────
class _LandscapeLayout extends StatelessWidget {
  final String exerciceNom;
  final String matiereNom;
  final String sousMatiereNom;
  final String lessonNom;

  const _LandscapeLayout({
    required this.exerciceNom,
    required this.matiereNom,
    required this.sousMatiereNom,
    required this.lessonNom,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _MenuIcon(size: 36),
          const SizedBox(height: 14),
          _Breadcrumb(
            matiereNom: matiereNom,
            sousMatiereNom: sousMatiereNom,
            lessonNom: lessonNom,
            exerciceNom: exerciceNom,
            isTablet: true,
          ),
          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Colonne GAUCHE : 2 cartes exercices empilées ──
              Expanded(
                flex: 55,
                child: Column(
                  children: [
                    const _LessonCard(index: 1, isTablet: true, isLandscape: true),
                    const SizedBox(height: 14),
                    const _LessonCard(index: 2, isTablet: true, isLandscape: true),
                  ],
                ),
              ),

              const SizedBox(width: 18),

              // ── Colonne DROITE : Résultats + Vidéo ──
              Expanded(
                flex: 45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _ResultsBox(isTablet: true, isLandscape: true),
                    const SizedBox(height: 14),
                    _VideoBox(exerciceNom: exerciceNom, isTablet: true),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Widgets communs
// ─────────────────────────────────────────────

class _MenuIcon extends StatelessWidget {
  final double size;
  const _MenuIcon({required this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          opaque: false,
          barrierColor: Colors.black45,
          pageBuilder: (_, __, ___) => const MenuBarreEnfant(),
        ),
      ),
      child: Icon(Icons.menu, size: size, color: _kCyan),
    );
  }
}

class _LessonCard extends StatelessWidget {
  final int  index;
  final bool isTablet;
  final bool isLandscape;

  const _LessonCard({
    required this.index,
    this.isTablet    = false,
    this.isLandscape = false,
  });

  @override
  Widget build(BuildContext context) {
    // En mode paysage on réduit un peu la hauteur de l'illustration
    final double imageHeight = isLandscape ? 110 : (isTablet ? 130 : 150);

    return Container(
      decoration: BoxDecoration(
        color: _kWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBorder, width: 1.2),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              height: imageHeight,
              width: double.infinity,
              color: _kCyanLight,
              child: Stack(
                children: [
                  Positioned.fill(child: CustomPaint(painter: _WavePainter())),
                  Positioned(left: 10, bottom: 8, child: _IllustrationLeft()),
                  Positioned(right: 10, bottom: 8, child: _IllustrationRight()),
                  const Center(
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: _kWhite,
                      child: Icon(Icons.play_arrow, color: _kCyan, size: 26),
                    ),
                  ),
                  Positioned(
                    top: 8, left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                          color: _kCyan.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        index.toString().padLeft(2, '0'),
                        style: const TextStyle(
                            color: _kWhite,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 18, top: 18,
                    child: Text('Hello!',
                        style: TextStyle(
                            color: _kCyan,
                            fontSize: 11,
                            fontWeight: FontWeight.bold)),
                  ),
                  const Positioned(
                    right: 18, top: 18,
                    child: Text('Hello!',
                        style: TextStyle(
                            color: _kCyan,
                            fontSize: 11,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),

          // ── Zone texte + boutons avec espace blanc augmenté ──
          Padding(
            padding: EdgeInsets.fromLTRB(
              isTablet ? 20 : 16,   // left
              isTablet ? 20 : 18,   // top   ↑ augmenté
              isTablet ? 20 : 16,   // right
              isTablet ? 22 : 20,   // bottom↑ augmenté
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'oooooo',
                        style: TextStyle(
                            fontSize: isTablet ? 15 : 14,
                            fontWeight: FontWeight.bold,
                            color: _kText),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.emoji_events, color: _kSilver, size: 22),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'explication ..................',
                  style: TextStyle(fontSize: 11, color: _kSubText),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 22),   // ↑ augmenté (était 18)
                Row(
                  children: [
                    Expanded(child: _CyanButton(label: 'Consigne',   onTap: () {})),
                    const SizedBox(width: 12),
                    Expanded(child: _CyanButton(label: 'Correction', onTap: () {})),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CyanButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _CyanButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        decoration: BoxDecoration(
            color: _kCyan, borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Text(label,
            style: const TextStyle(
                color: _kWhite, fontSize: 13, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _ResultsBox extends StatelessWidget {
  final bool isTablet;
  final bool isLandscape;

  const _ResultsBox({this.isTablet = false, this.isLandscape = false});

  @override
  Widget build(BuildContext context) {
    // Taille du titre alignée sur celle de "Vidéo explicative" (14)
    const double titleFontSize = 14.0;

    // Icônes de médailles réduites, encore plus en mode paysage
    final double medalIconSize  = isLandscape ? 26 : (isTablet ? 32 : 36);
    final double trophyIconSize = isLandscape ? 24 : (isTablet ? 28 : 36);
    final double medalFontSize  = isLandscape ? 11 : (isTablet ? 12 : 13);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 18 : 20,
        vertical:   isTablet ? 18 : 22,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF6E3),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFFCB317), width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.emoji_events,
                  color: const Color(0xFFFCB317), size: trophyIconSize),
              const SizedBox(width: 8),
              const Text(
                'Mes Résultats',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: _MedalBadge(
                    bgColor:   const Color(0xFFEEEEEE),
                    iconColor: const Color(0xFF9E9E9E),
                    label:     '0 Argent',
                    iconSize:  medalIconSize,
                    fontSize:  medalFontSize,
                    isTablet:  isTablet,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: _MedalBadge(
                    bgColor:   const Color(0xFFFFF8E1),
                    iconColor: const Color(0xFFFCB317),
                    label:     '0 OR',
                    iconSize:  medalIconSize,
                    fontSize:  medalFontSize,
                    isTablet:  isTablet,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: _MedalBadge(
                    bgColor:   const Color(0xFFE8C07A),
                    iconColor: const Color(0xFF7B4F1E),
                    label:     '0 Bronze',
                    iconSize:  medalIconSize,
                    fontSize:  medalFontSize,
                    isTablet:  isTablet,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MedalBadge extends StatelessWidget {
  final Color  bgColor;
  final Color  iconColor;
  final String label;
  final double iconSize;
  final double fontSize;
  final bool   isTablet;

  const _MedalBadge({
    required this.bgColor,
    required this.iconColor,
    required this.label,
    required this.iconSize,
    required this.fontSize,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical:   isTablet ? 12 : 10,
        horizontal: isTablet ? 6  : 4,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.emoji_events, color: iconColor, size: iconSize),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoBox extends StatelessWidget {
  final String exerciceNom;
  final bool isTablet;
  const _VideoBox({required this.exerciceNom, this.isTablet = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _kWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBorder, width: 1.2),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      padding: EdgeInsets.all(isTablet ? 16 : 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vidéo explicative - $exerciceNom',
            // Même taille que le titre de _ResultsBox (14)
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: _kText),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: isTablet ? 120 : 100,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: _kCyanBg, borderRadius: BorderRadius.circular(12)),
              child: const Center(
                  child: Icon(Icons.videocam, color: _kCyan, size: 44)),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'cette vidéo explique les concepts clés avant de commencer les exercices',
            style: TextStyle(fontSize: 11, color: _kSubText),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Illustrations & Painter
// ─────────────────────────────────────────────

class _IllustrationLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70, height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: 70, height: 16,
              decoration: BoxDecoration(
                  color: const Color(0xFF80DEEA),
                  borderRadius: BorderRadius.circular(4)),
            ),
          ),
          Positioned(
            bottom: 16, left: 4,
            child: Column(children: [
              _BookRect(const Color(0xFF4DD0E1), 50, 9),
              _BookRect(const Color(0xFF00BCD4), 44, 9),
              _BookRect(const Color(0xFF0097A7), 38, 9),
            ]),
          ),
          Positioned(
            bottom: 28, right: 2,
            child: Column(children: [
              const CircleAvatar(radius: 11, backgroundColor: Color(0xFFFFCC80)),
              Container(
                  width: 18, height: 28,
                  decoration: const BoxDecoration(
                      color: Color(0xFF4FC3F7),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _BookRect extends StatelessWidget {
  final Color color;
  final double w, h;
  const _BookRect(this.color, this.w, this.h);

  @override
  Widget build(BuildContext context) => Container(
        width: w, height: h,
        margin: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(2)),
      );
}

class _IllustrationRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70, height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0, right: 0,
            child: Column(children: [
              Container(width: 4,  height: 30, color: const Color(0xFF78909C)),
              Container(width: 20, height: 6,
                  decoration: BoxDecoration(color: const Color(0xFF78909C), borderRadius: BorderRadius.circular(2))),
              Container(width: 30, height: 6,
                  decoration: BoxDecoration(color: const Color(0xFF90A4AE), borderRadius: BorderRadius.circular(2))),
              Container(width: 40, height: 8,
                  decoration: BoxDecoration(color: const Color(0xFF90A4AE), borderRadius: BorderRadius.circular(2))),
            ]),
          ),
          Positioned(
            bottom: 0, left: 0,
            child: Column(children: [
              const CircleAvatar(radius: 9, backgroundColor: Color(0xFF80CBC4)),
              Container(
                  width: 16, height: 32,
                  decoration: const BoxDecoration(
                      color: Color(0xFF80CBC4),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00BCD4).withOpacity(0.15)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.55)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.4,
          size.width * 0.5, size.height * 0.55)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.7,
          size.width, size.height * 0.55)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}