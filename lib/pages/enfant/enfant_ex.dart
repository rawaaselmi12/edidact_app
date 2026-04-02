import 'package:flutter/material.dart';
import 'package:edidact_app/widgets/menu_barre_enfant.dart';
import 'package:edidact_app/pages/enfant/sous_matiere.dart';

const _kPurple      = Color(0xFF9C27B0);
const _kCyan        = Color(0xFF00BCD4);
const _kYellow      = Color(0xFFFCB317);
const _kYellowLight = Color(0xFFFFF0C2);
const _kBlueDark    = Color.fromARGB(255, 8, 153, 189);

class Subject {
  final String name;
  final String description;
  final double progress;
  final Color color;

  const Subject({
    required this.name,
    required this.description,
    required this.progress,
    required this.color,
  });
}

const List<Subject> _subjects = [
  Subject(
    name: 'Anglais',
    description: 'Apprenez la langue anglaise avec des méthodes modernes',
    progress: 0.0,
    color: _kYellowLight,
     ),
  Subject(
    name: 'Maths',
    description: 'Découvrez cette matière passionnante avec nos exercices adaptés',
    progress: 0.0,
    color: Color(0xFFB2EBF2),
  ),
  Subject(
    name: 'Français',
    description: 'Apprenez la langue française avec des méthodes modernes',
    progress: 0.0,
    color: _kYellowLight,
  ),
  Subject(
    name: 'Culture générale',
    description: 'Découvrez cette matière passionnante avec nos exercices adaptés',
    progress: 0.0,
    color: Color(0xFFB2EBF2),
  ),
  Subject(
    name: 'Sciences',
    description: 'Explorez le monde naturel avec des expériences passionnantes',
    progress: 0.0,
    color: _kYellowLight,
  ),
  Subject(
    name: 'Allemand',
    description: 'Découvrez la langue allemande avec des méthodes modernes',
    progress: 0.0,
    color: Color(0xFFB2EBF2),
  ),
];

class EnfantExPage extends StatelessWidget {
  const EnfantExPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

   
    final int cols = isLandscape ? 3 : (screenWidth >= 600 ? 2 : 1);
    final bool isTablet = screenWidth >= 600;

    final double titleFontSize     = isTablet ? 24 : 20;
    final double subtitleFontSize  = isTablet ? 15 : 13;
    final double tableMenuFontSize = isTablet ? 15 : 13;
    final double tableMenuIconSize = isTablet ? 22 : 18;
    final double avatarSize        = isTablet ? 70 : 56;
    final double avatarIconSize    = isTablet ? 38 : 32;

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
                child: Icon(Icons.menu, size: isTablet ? 40 : 34, color: _kCyan),
              ),

              SizedBox(height: isTablet ? 24 : 16),              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 28 : 20,
                  vertical:   isTablet ? 26 : 20,
                ),
                decoration: BoxDecoration(
                  color: _kPurple,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
  children: [
    Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.person, color: Colors.white, size: avatarIconSize),
    ),
    SizedBox(width: isTablet ? 20 : 16),
    Expanded( // <- ajouter Expanded ici
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bonjour Enfant',
            style: TextStyle(
              color: Colors.white,
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Choisis une matière pour commencer',
            style: TextStyle(color: Colors.white70, fontSize: subtitleFontSize),
            overflow: TextOverflow.ellipsis, // coupe le texte si trop long
          ),
        ],
      ),
    ),
  ],
),
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
                    Icon(Icons.menu_book_rounded, color: Colors.red[400], size: tableMenuIconSize),
                    const SizedBox(width: 8),
                    Text(
                      'Table des matières',
                      style: TextStyle(fontSize: tableMenuFontSize, color: Colors.black87),
                    ),
                  ],
                ),
              ),

              SizedBox(height: isTablet ? 24 : 16),

             
              cols == 1
                  ? Column(
                      children: _subjects
                          .map((s) => _SubjectCard(subject: s, isTablet: false))
                          .toList(),
                    )
                  : _buildGrid(_subjects, cols: cols, isTablet: isTablet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(
    List<Subject> subjects, {
    required int cols,
    required bool isTablet,
  }) {
    final rows = <Widget>[];
    for (int i = 0; i < subjects.length; i += cols) {
      final rowItems = subjects.sublist(i, (i + cols).clamp(0, subjects.length));
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
                    ? _SubjectCard(subject: rowItems[j], isTablet: isTablet)
                    : const SizedBox(),
              ),
            );
          }),
        ),
      );
    }
    return Column(children: rows);
  }
}

class _SubjectCard extends StatelessWidget {
  final Subject subject;
  final bool    isTablet;

  const _SubjectCard({required this.subject, this.isTablet = false});

  @override
  Widget build(BuildContext context) {
    final int percent = (subject.progress * 100).round();

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
          builder: (_) => SousMatierePage(matiereNom: subject.name),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: cardMarginBot),
        padding: EdgeInsets.fromLTRB(
          cardPaddingH,
          cardPaddingV,
          cardPaddingH,
          cardPaddingV,
        ),
        decoration: BoxDecoration(
          color: subject.color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Nom
            Text(
              subject.name,
              style: TextStyle(
                fontSize: nameFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: isTablet ? 6 : 6),

            // Description
            Text(
              subject.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: descFontSize, color: Colors.grey[600]),
            ),

            SizedBox(height: isTablet ? 12 : 8),

            // Progression + %
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progression',
                  style: TextStyle(fontSize: labelFontSize, fontWeight: FontWeight.w600),
                ),
                Text(
                  '$percent%',
                  style: TextStyle(fontSize: labelFontSize, fontWeight: FontWeight.w600),
                ),
              ],
            ),

            SizedBox(height: isTablet ? 10 : 9),

            // Barre
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: subject.progress,
                minHeight: barHeight,
                backgroundColor: Colors.white.withOpacity(0.6),
                valueColor: AlwaysStoppedAnimation<Color>(
                  subject.color == _kYellowLight ? _kYellow : _kBlueDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}