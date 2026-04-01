
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
    final isTablet    = screenWidth > 600;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final double titleFontSize       = isTablet && !isLandscape ? 27 : isTablet ? 24 : 20;
    final double subtitleFontSize    = isTablet && !isLandscape ? 17 : isTablet ? 15 : 13;
    final double tableMenuFontSize   = isTablet && !isLandscape ? 17 : isTablet ? 15 : 13;
    final double tableMenuIconSize   = isTablet && !isLandscape ? 25 : isTablet ? 22 : 18;
    final double avatarSize          = isTablet && !isLandscape ? 78 : isTablet ? 70 : 56;
    final double avatarIconSize      = isTablet && !isLandscape ? 44 : isTablet ? 38 : 32;

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
                child: Icon(
                  Icons.menu,
                  size: isTablet ? 40 : 34,
                  color: _kCyan,
                ),
              ),

              SizedBox(height: isTablet ? 24 : 16),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 28 : 20,
                  vertical:   isTablet && !isLandscape ? 30 : isTablet ? 26 : 20,
                ),
                decoration: BoxDecoration(
                  color: _kPurple,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Container(
                      width:  avatarSize,
                      height: avatarSize,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: avatarIconSize,
                      ),
                    ),
                    SizedBox(width: isTablet ? 20 : 16),
                    Column(
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
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: subtitleFontSize,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: isTablet ? 24 : 16),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 20 : 16,
                  vertical:   isTablet && !isLandscape ? 18 : isTablet ? 14 : 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.menu_book_rounded,
                      color: Colors.red[400],
                      size: tableMenuIconSize,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Table des matières',
                      style: TextStyle(
                        fontSize: tableMenuFontSize,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: isTablet ? 24 : 16),
              if (isTablet && isLandscape)
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _subjects.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 4.2,
                  ),
                  itemBuilder: (context, index) {
                    return _SubjectCard(
                      subject: _subjects[index],
                      isTablet: true,
                      isLandscape: true,
                    );
                  },
                )
              else
                Column(
                  children: _subjects
                      .map((s) => _SubjectCard(
                            subject: s,
                            isTablet: isTablet,
                            isLandscape: false,
                          ))
                      .toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final Subject subject;
  final bool isTablet;
  final bool isLandscape;

  const _SubjectCard({
    required this.subject,
    this.isTablet = false,
    this.isLandscape = false,
  });

  @override
  Widget build(BuildContext context) {
    final int percent = (subject.progress * 100).round();

    final double cardPaddingV    = isTablet && !isLandscape ? 20  : isLandscape ? 4  : 14;
    final double cardPaddingH    = isTablet && !isLandscape ? 22  : 16;
    final double cardMarginBot   = isTablet && !isLandscape ? 22  : isLandscape ? 0  : 18;
    final double nameFontSize    = isTablet && !isLandscape ? 19  : isLandscape ? 15 : 16;
    final double descFontSize    = isTablet && !isLandscape ? 14  : 11.5;
    final double labelFontSize   = isTablet && !isLandscape ? 14  : 11;
    final double gapAfterName    = isTablet && !isLandscape ? 8   : isLandscape ? 6  : 6;
    final double gapAfterDesc    = isTablet && !isLandscape ? 14  : isLandscape ? 13 : 8;
    final double gapAfterLabel   = isTablet && !isLandscape ? 12  : isLandscape ? 14 : 9;
    final double barHeight       = isTablet && !isLandscape ? 9   : isLandscape ? 9  : 6;
    final double borderRadius    = isTablet && !isLandscape ? 18  : 14;

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
          isLandscape ? 4 : cardPaddingV,
          cardPaddingH,
          isLandscape ? 6 : cardPaddingV,
        ),
        decoration: BoxDecoration(
          color: subject.color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Nom de la matière
            Text(
              subject.name,
              style: TextStyle(
                fontSize: nameFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: gapAfterName),

            // Description
            Text(
              subject.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: descFontSize,
                color: Colors.grey[600],
              ),
            ),

            SizedBox(height: gapAfterDesc),

            // Ligne Progression + %
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progression',
                  style: TextStyle(
                    fontSize: labelFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$percent%',
                  style: TextStyle(
                    fontSize: labelFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            SizedBox(height: gapAfterLabel),

            // Barre de progression
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