import 'package:flutter/material.dart';
import 'package:edidact_app/widgets/menu_barre_enfant.dart';
import 'package:edidact_app/pages/enfant/contenu_sous_matiere.dart';

const _kCyan        = Color(0xFF00BCD4);
const _kYellow      = Color(0xFFFCB317);
const _kYellowLight = Color(0xFFFFF0C2);
const _kBlueLight   = Color(0xFFB2EBF2);
const _kBlueDark    = Color.fromARGB(255, 8, 153, 189);

class SousMatiere {
  final String name;
  final String description;
  final double progress;
  final Color color;

  const SousMatiere({
    required this.name,
    required this.description,
    required this.progress,
    required this.color,
  });
}

const List<SousMatiere> _sousMatieres = [
  SousMatiere(
    name: 'a',
    description: 'Découvrez cette matière passionnante avec nos exercices adaptés',
    progress: 0.14,
    color: _kYellowLight,
  ),
  SousMatiere(
    name: 'b',
    description: 'Découvrez cette matière passionnante avec nos exercices adaptés',
    progress: 0.09,
    color: _kBlueLight,
  ),
  SousMatiere(
    name: 'c',
    description: 'Découvrez cette matière passionnante avec nos exercices adaptés',
    progress: 0.0,
    color: _kYellowLight,
  ),
  SousMatiere(
    name: 'd',
    description: 'Découvrez cette matière passionnante avec nos exercices adaptés',
    progress: 0.36,
    color: _kBlueLight,
  ),
];

class SousMatierePage extends StatelessWidget {
  final String matiereNom;

  const SousMatierePage({super.key, required this.matiereNom});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 20 : 12,
            vertical: isTablet ? 16 : 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    opaque: false,
                    barrierColor: Colors.black45,
                    pageBuilder: (_, __, ___) => const MenuBarreEnfant(),
                  ),
                ),
                child: const Icon(Icons.menu, size: 30, color: _kCyan),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 18 : 14,
                  vertical: isTablet ? 14 : 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.menu_book_rounded,
                        color: Colors.red[400], size: isTablet ? 20 : 18),
                    const SizedBox(width: 8),
                    Text(
                      matiereNom,
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        fontWeight: FontWeight.w600,
                        color: _kCyan,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              LayoutBuilder(
                builder: (context, constraints) {
                  if (!isTablet || !isLandscape) {
                    return Column(
                      children: _sousMatieres
                          .map((sm) => _SousMatiereCard(
                              sousMatiere: sm,
                              compact: true // <-- boxes plus petites
                              ))
                          .toList(),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _sousMatieres.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 10,
                      childAspectRatio:4.2,
                    ),
                    itemBuilder: (context, index) {
                      return _SousMatiereCard(
                        sousMatiere: _sousMatieres[index],
                        compact: true, // <-- box compacte
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SousMatiereCard extends StatelessWidget {
  final SousMatiere sousMatiere;
  final bool compact; // <-- nouveau paramètre
  const _SousMatiereCard({required this.sousMatiere, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final int percent = (sousMatiere.progress * 100).round();
    final bool isYellow = sousMatiere.color == _kYellowLight;
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ContenuSousMatierePage(
            sousMatiereNom: sousMatiere.name,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: compact ? 4 : 8),
        padding: EdgeInsets.fromLTRB(
          isTablet ? (compact ? 6 : 10) : (compact ? 4 : 8),
          isTablet ? (compact ? 4 : 8) : (compact ? 3 : 6),
          isTablet ? (compact ? 6 : 10) : (compact ? 4 : 8),
          isTablet ? (compact ? 4 : 8) : (compact ? 3 : 6),
        ),
        decoration: BoxDecoration(
          color: sousMatiere.color,
          borderRadius: BorderRadius.circular(compact ? 8 : 12),
          border: Border.all(
            color: isYellow
                ? _kYellow.withOpacity(0.6)
                : _kCyan.withOpacity(0.4),
            width: 1.2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Texte gardé tel quel
            Text(
              sousMatiere.name,
              style: TextStyle(
                fontSize: isTablet ? 17 : 15.5,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              sousMatiere.description,
              style: TextStyle(
                fontSize: isTablet ? 14 : 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Progression:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$percent%',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: sousMatiere.progress,
                minHeight: 6,
                backgroundColor: Colors.white.withOpacity(0.6),
                valueColor: AlwaysStoppedAnimation<Color>(
                  isYellow ? _kYellow : _kBlueDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}