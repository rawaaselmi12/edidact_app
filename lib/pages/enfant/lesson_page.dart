import 'package:flutter/material.dart';
import 'package:edidact_app/widgets/menu_barre_enfant.dart';
import 'package:edidact_app/pages/enfant/exercice_page.dart';

const _kCyan        = Color(0xFF00BCD4);
const _kYellow      = Color(0xFFFCB317);
const _kYellowLight = Color(0xFFFFF0C2);
const _kBlueLight   = Color(0xFFB2EBF2);

class Exercise {
  final String name;
  final String description;
  final double progress;
  final Color color;

  const Exercise({
    required this.name,
    required this.description,
    required this.progress,
    required this.color,
  });
}

const List<Exercise> _exercises = [
  Exercise(
    name: 'Exercice 1',
    description: 'Découvrez cet exercice passionnant avec nos activités adaptées',
    progress: 0.0,
    color: _kYellowLight,
  ),
  Exercise(
    name: 'Exercice 2',
    description: 'Découvrez cet exercice passionnant avec nos activités adaptées',
    progress: 0.0,
    color: _kBlueLight,
  ),
  Exercise(
    name: 'Exercice 3',
    description: 'Découvrez cet exercice passionnant avec nos activités adaptées',
    progress: 0.0,
    color: _kYellowLight,
  ),
];

class LessonPage extends StatelessWidget {
  final String titre;
  final String description;

  const LessonPage({
    super.key,
    required this.titre,
    required this.description,
  });

  Widget _buildGrid(List<Exercise> items, {required int cols, required bool isTablet}) {
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
                    ? _ExerciseCard(exercise: rowItems[j], isTablet: isTablet)
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

    // Mobile portrait  → 1 col
    // Tablette portrait → 2 cols
    // Paysage (tous)   → 3 cols
    final int cols = isLandscape ? 3 : (isTablet ? 2 : 1);

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
                        color: Colors.red[400],
                        size: isTablet ? 22 : 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        titre,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: isTablet ? 18 : 16,
                          fontWeight: FontWeight.w600,
                          color: _kCyan,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: isTablet ? 24 : 16),

              cols == 1
                  ? Column(
                      children: _exercises
                          .map((e) => _ExerciseCard(exercise: e, isTablet: false))
                          .toList(),
                    )
                  : _buildGrid(_exercises, cols: cols, isTablet: isTablet),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final bool     isTablet;

  const _ExerciseCard({
    required this.exercise,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    final int percent   = (exercise.progress * 100).round();
    final bool isYellow = exercise.color == _kYellowLight;

    final double cardPaddingV  = isTablet ? 18 : 14;
    final double cardPaddingH  = isTablet ? 22 : 16;
    final double cardMarginBot = isTablet ? 16 : 10;
    final double nameFontSize  = isTablet ? 17 : 16;
    final double descFontSize  = isTablet ? 13 : 12;
    final double labelFontSize = isTablet ? 13 : 12;
    final double barHeight     = isTablet ? 9  : 6;
    final double borderRadius  = isTablet ? 18 : 16;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ExercicePage(exerciceNom: exercise.name),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: cardMarginBot),
        padding: EdgeInsets.symmetric(
          horizontal: cardPaddingH,
          vertical:   cardPaddingV,
        ),
        decoration: BoxDecoration(
          color: exercise.color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              exercise.name,
              style: TextStyle(
                fontSize: nameFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: isTablet ? 6 : 5),
            Text(
              exercise.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: descFontSize, color: Colors.grey[700]),
            ),
            SizedBox(height: isTablet ? 12 : 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progression:',
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
            SizedBox(height: isTablet ? 8 : 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: exercise.progress,
                minHeight: barHeight,
                backgroundColor: Colors.white.withOpacity(0.6),
                valueColor: AlwaysStoppedAnimation<Color>(
                  isYellow ? _kYellow : _kCyan,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}