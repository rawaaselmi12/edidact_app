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

  Widget _buildGrid(
    List<SousMatiere> items, {
    required int cols,
    required bool isTablet,
  }) {
    final rows = <Widget>[];
    for (int i = 0; i < items.length; i += cols) {
      final rowItems = items.sublist(i, (i + cols).clamp(0, items.length));
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(cols, (j) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left:   j == 0        ? 0 : 8,
                  right:  j == cols - 1 ? 0 : 8,
                  bottom: 16,
                ),
                child: j < rowItems.length
                    ? _SousMatiereCard(
                        sousMatiere: rowItems[j],
                        isTablet: isTablet,
                      )
                    : const SizedBox(),
              ),
            );
          }),
        ),
      );
    }
    return Column(children: rows);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final isTablet    = screenWidth >= 600;

   
    final int cols = isLandscape ? 3 : (isTablet ? 2 : 1);

    final double tableMenuFontSize = isTablet ? 15 : 13;
    final double tableMenuIconSize = isTablet ? 22 : 18;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 32 : 16,
            vertical:   isTablet ? 20 : 12,
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
                    size: isTablet ? 40 : 34, color: _kCyan),
              ),

              SizedBox(height: isTablet ? 24 : 16),

              Container(
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
                child: Row(
                  children: [
                    Icon(Icons.menu_book_rounded,
                        color: Colors.red[400], size: tableMenuIconSize),
                    const SizedBox(width: 8),
                    Text(
                      matiereNom,
                      style: TextStyle(
                        fontSize: tableMenuFontSize,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: isTablet ? 24 : 16),

              cols == 1
                  ? Column(
                      children: _sousMatieres
                          .map((sm) => _SousMatiereCard(
                                sousMatiere: sm,
                                isTablet: false,
                              ))
                          .toList(),
                    )
                  : _buildGrid(_sousMatieres, cols: cols, isTablet: isTablet),
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

  const _SousMatiereCard({
    required this.sousMatiere,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    final int percent  = (sousMatiere.progress * 100).round();
    final bool isYellow = sousMatiere.color == _kYellowLight;

    final double cardPaddingV  = isTablet ? 18 : 14;
    final double cardPaddingH  = isTablet ? 22 : 16;
    final double cardMarginBot = isTablet ? 16 : 18;
    final double nameFontSize  = isTablet ? 17 : 16;
    final double descFontSize  = isTablet ? 13 : 11.5;
    final double labelFontSize = isTablet ? 13 : 11;
    final double barHeight     = isTablet ? 9  : 6;
    final double borderRadius  = isTablet ? 18 : 14;

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
            SizedBox(height: isTablet ? 6 : 6),
            Text(
              sousMatiere.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: descFontSize, color: Colors.grey[600]),
            ),
            SizedBox(height: isTablet ? 12 : 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progression',
                  style: TextStyle(
                      fontSize: labelFontSize, fontWeight: FontWeight.w600),
                ),
                Text(
                  '$percent%',
                  style: TextStyle(
                      fontSize: labelFontSize, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: isTablet ? 10 : 9),
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