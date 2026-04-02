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
  /// Nom de l'exercice cliqué depuis LessonPage (ex: "Exercice 1")
  final String exerciceNom;

  const ExercicePage({super.key, required this.exerciceNom});

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
              return _LandscapeLayout(exerciceNom: exerciceNom);
            } else if (isTablet) {
              return _TabletPortraitLayout(exerciceNom: exerciceNom);
            } else {
              return _MobileLayout(exerciceNom: exerciceNom);
            }
          },
        ),
      ),
    );
  }
}


class _MobileLayout extends StatelessWidget {
  final String exerciceNom;
  const _MobileLayout({required this.exerciceNom});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MenuIcon(size: 32),
          const SizedBox(height: 16),

          _TitleBar(titre: exerciceNom),
          const SizedBox(height: 20),

          _LessonCard(index: 1),
          const SizedBox(height: 14),
          _LessonCard(index: 2),
          const SizedBox(height: 20),

          _ResultsBox(),
          const SizedBox(height: 14),

          _VideoBox(exerciceNom: exerciceNom),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}


class _TabletPortraitLayout extends StatelessWidget {
  final String exerciceNom;
  const _TabletPortraitLayout({required this.exerciceNom});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MenuIcon(size: 36),
          const SizedBox(height: 16),

          _TitleBar(titre: exerciceNom, isTablet: true),
          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _LessonCard(index: 1, isTablet: true),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: _LessonCard(index: 2, isTablet: true),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _ResultsBox(isTablet: true),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: _VideoBox(exerciceNom: exerciceNom, isTablet: true),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}


class _LandscapeLayout extends StatelessWidget {
  final String exerciceNom;
  const _LandscapeLayout({required this.exerciceNom});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MenuIcon(size: 36),
          const SizedBox(height: 14),

          _TitleBar(titre: exerciceNom, isTablet: true),
          const SizedBox(height: 18),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _LessonCard(index: 1, isTablet: true),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: _LessonCard(index: 2, isTablet: true),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
                    height: 220,
                    decoration: BoxDecoration(
                      color: _kCyanBg.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: _kCyan.withOpacity(0.2), width: 1.5),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add_circle_outline,
                              color: _kCyan, size: 36),
                          SizedBox(height: 8),
                          Text('Autre exercice',
                              style:
                                  TextStyle(color: _kCyan, fontSize: 13)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _ResultsBox(isTablet: true),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _VideoBox(exerciceNom: exerciceNom, isTablet: true),
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}


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

class _TitleBar extends StatelessWidget {
  final String titre;
  final bool isTablet;
  const _TitleBar({required this.titre, this.isTablet = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 22 : 18,
        vertical:   isTablet ? 16 : 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isTablet ? 32 : 30),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(Icons.menu_book_rounded, color: Colors.red[400]),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              titre,
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w600,
                color: _kCyan,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonCard extends StatelessWidget {
  final int  index;
  final bool isTablet;
  const _LessonCard({required this.index, this.isTablet = false});

  @override
  Widget build(BuildContext context) {
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
              height: isTablet ? 130 : 150,
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
                  // Badge numéro
                  Positioned(
                    top: 8, left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
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

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Radical du verbe',
                        style: TextStyle(
                            fontSize: isTablet ? 15 : 14,
                            fontWeight: FontWeight.bold,
                            color: _kText),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.emoji_events,
                        color: _kSilver, size: 22),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'distinction entre base ou radical/terminaisons',
                  style: TextStyle(fontSize: 11, color: _kSubText),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),

                // Boutons
                Row(
                  children: [
                    Expanded(
                        child:
                            _CyanButton(label: 'Consigne', onTap: () {})),
                    const SizedBox(width: 10),
                    Expanded(
                        child: _CyanButton(
                            label: 'Correction', onTap: () {})),
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
        height: 36,
        decoration: BoxDecoration(
            color: _kCyan, borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Text(label,
            style: const TextStyle(
                color: _kWhite,
                fontSize: 13,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}

//resultats
class _ResultsBox extends StatelessWidget {
  final bool isTablet;
  const _ResultsBox({this.isTablet = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 28 : 20,
        vertical:   isTablet ? 28 : 22,
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
              const Icon(Icons.emoji_events,
                  color: Color(0xFFFCB317), size: 36),
              const SizedBox(width: 10),
              Text(
                'Mes Résultats',
                style: TextStyle(
                  fontSize: isTablet ? 22 : 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: _MedalBadge(
                    bgColor:   const Color(0xFFEEEEEE),
                    iconColor: const Color(0xFF9E9E9E),
                    label:     '0 Argent',
                    isTablet:  isTablet,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: _MedalBadge(
                    bgColor:   const Color(0xFFFFF8E1),
                    iconColor: const Color(0xFFFCB317),
                    label:     '0 OR',
                    isTablet:  isTablet,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: _MedalBadge(
                    bgColor:   const Color(0xFFE8C07A),
                    iconColor: const Color(0xFF7B4F1E),
                    label:     '0 Bronze',
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
  final Color bgColor;
  final Color iconColor;
  final String label;
  final bool isTablet;

  const _MedalBadge({
    required this.bgColor,
    required this.iconColor,
    required this.label,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical:   isTablet ? 18 : 14,
        horizontal: isTablet ? 12 : 8,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.emoji_events,
              color: iconColor, size: isTablet ? 44 : 36),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isTablet ? 14 : 13,
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
            style: TextStyle(
                fontSize: isTablet ? 15 : 14,
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
                  color: _kCyanBg,
                  borderRadius: BorderRadius.circular(12)),
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



class _IllustrationLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: 70,
              height: 16,
              decoration: BoxDecoration(
                  color: const Color(0xFF80DEEA),
                  borderRadius: BorderRadius.circular(4)),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 4,
            child: Column(children: [
              _BookRect(const Color(0xFF4DD0E1), 50, 9),
              _BookRect(const Color(0xFF00BCD4), 44, 9),
              _BookRect(const Color(0xFF0097A7), 38, 9),
            ]),
          ),
          Positioned(
            bottom: 28,
            right: 2,
            child: Column(children: [
              const CircleAvatar(
                  radius: 11,
                  backgroundColor: Color(0xFFFFCC80)),
              Container(
                  width: 18,
                  height: 28,
                  decoration: const BoxDecoration(
                      color: Color(0xFF4FC3F7),
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(6)))),
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
        width: w,
        height: h,
        margin: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(2)),
      );
}

class _IllustrationRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Column(children: [
              Container(
                  width: 4,
                  height: 30,
                  color: const Color(0xFF78909C)),
              Container(
                  width: 20,
                  height: 6,
                  decoration: BoxDecoration(
                      color: const Color(0xFF78909C),
                      borderRadius: BorderRadius.circular(2))),
              Container(
                  width: 30,
                  height: 6,
                  decoration: BoxDecoration(
                      color: const Color(0xFF90A4AE),
                      borderRadius: BorderRadius.circular(2))),
              Container(
                  width: 40,
                  height: 8,
                  decoration: BoxDecoration(
                      color: const Color(0xFF90A4AE),
                      borderRadius: BorderRadius.circular(2))),
            ]),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Column(children: [
              const CircleAvatar(
                  radius: 9,
                  backgroundColor: Color(0xFF80CBC4)),
              Container(
                  width: 16,
                  height: 32,
                  decoration: const BoxDecoration(
                      color: Color(0xFF80CBC4),
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(4)))),
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