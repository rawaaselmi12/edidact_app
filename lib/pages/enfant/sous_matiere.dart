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
    final isTablet    = MediaQuery.of(context).size.width >= 600;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 20 : 12,
            vertical:   isTablet ? 16 : 10,
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
                child: Icon(Icons.menu,
                    size: isTablet ? 36 : 30, color: _kCyan),
              ),

              SizedBox(height: isTablet ? 24 : 20),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 18 : 14,
                  vertical:   isTablet ? 16 : 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.menu_book_rounded,
                        color: Colors.red[400],
                        size: isTablet ? 22 : 18),
                    const SizedBox(width: 8),
                    Text(
                      matiereNom,
                      style: TextStyle(
                        fontSize: isTablet ? 17 : 14,
                        fontWeight: FontWeight.w600,
                        color: _kCyan,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: isTablet ? 20 : 14),

              LayoutBuilder(
                builder: (context, constraints) {
        // Paysage 
                  if (isTablet && isLandscape) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _sousMatieres.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 10,
                        childAspectRatio: 4.2,
                      ),
                      itemBuilder: (context, index) {
                        return _SousMatiereCard(
                          sousMatiere: _sousMatieres[index],
                          isTablet: true,
                          isLandscape: true,
                        );
                      },
                    );
                  }

                  return Column(
                    children: _sousMatieres
                        .map((sm) => _SousMatiereCard(
                              sousMatiere: sm,
                              isTablet: isTablet,
                              isLandscape: false,
                            ))
                        .toList(),
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
  final bool isTablet;
  final bool isLandscape;

  const _SousMatiereCard({
    required this.sousMatiere,
    this.isTablet = false,
    this.isLandscape = false,
  });

  @override
  Widget build(BuildContext context) {
    final int percent = (sousMatiere.progress * 100).round();
    final bool isYellow = sousMatiere.color == _kYellowLight;

   
    final double cardMarginBot  = isLandscape ? 0 : isTablet ? 22 : 16;
    final double cardPaddingH   = isLandscape ? 6 : isTablet ? 20 : 14;
    final double cardPaddingV   = isLandscape ? 4 : isTablet ? 18 : 12;
    final double borderRadius   = isLandscape ? 8 : isTablet ? 16 : 12;
    final double nameFontSize   = isLandscape ? 15 : isTablet ? 19 : 15.5;
    final double descFontSize   = isLandscape ? 12 : isTablet ? 14 : 12;
    final double labelFontSize  = isLandscape ? 12 : isTablet ? 14 : 12;
    final double pctFontSize    = isLandscape ? 14 : isTablet ? 16 : 14;
    final double barHeight      = isLandscape ? 6  : isTablet ? 9  : 7;
    final double gapAfterName   = isLandscape ? 2  : isTablet ? 8  : 5;
    final double gapAfterDesc   = isLandscape ? 4  : isTablet ? 12 : 8;
    final double gapAfterLabel  = isLandscape ? 4  : isTablet ? 10 : 6;

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
        margin: EdgeInsets.only(bottom: cardMarginBot),
        padding: EdgeInsets.symmetric(
          horizontal: cardPaddingH,
          vertical:   cardPaddingV,
        ),
        decoration: BoxDecoration(
          color: sousMatiere.color,
          borderRadius: BorderRadius.circular(borderRadius),
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
            Text(
              sousMatiere.name,
              style: TextStyle(
                fontSize: nameFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: gapAfterName),
            Text(
              sousMatiere.description,
              style: TextStyle(
                fontSize: descFontSize,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: gapAfterDesc),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progression:',
                  style: TextStyle(
                    fontSize: labelFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$percent%',
                  style: TextStyle(
                    fontSize: pctFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: gapAfterLabel),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: sousMatiere.progress,
                minHeight: barHeight,
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