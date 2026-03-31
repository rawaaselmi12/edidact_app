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
    final isTablet = screenWidth > 600;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 32 : 16,
            vertical: isTablet ? 20 : 12,
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
                    pageBuilder: (_, __, ___) =>
                        const MenuBarreEnfant(),
                  ),
                ),
                child: Icon(
                  Icons.menu,
                  size: isTablet ? 40 : 34,
                  color: _kCyan,
                ),
              ),

              SizedBox(height: isTablet ? 24 : 16),

              /// HEADER
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 28 : 20,
                  vertical: isTablet ? 26 : 20,
                ),
                decoration: BoxDecoration(
                  color: _kPurple,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Container(
                      width: isTablet ? 70 : 56,
                      height: isTablet ? 70 : 56,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: isTablet ? 38 : 32,
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
                            fontSize: isTablet ? 24 : 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Choisis une matière pour commencer',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: isTablet ? 15 : 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: isTablet ? 24 : 16),

              /// TABLE DES MATIERES
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 20 : 16,
                  vertical: isTablet ? 14 : 10,
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
                      size: isTablet ? 22 : 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Table des matières',
                      style: TextStyle(
                        fontSize: isTablet ? 15 : 13,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: isTablet ? 24 : 16),

              /// GRID ou LIST
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

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SousMatierePage(matiereNom: subject.name),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(
          bottom: isTablet && !isLandscape ? 0 : (isLandscape ? 0 : 14),
        ),
        padding: EdgeInsets.fromLTRB(
          16,
          isLandscape ? 4 : 10,  
          16,
          isLandscape ? 6 : 10,
        ),
        decoration: BoxDecoration(
          color: subject.color,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start, 
          mainAxisSize: MainAxisSize.min,
          children: [
            // NOM DE LA MATIÈRE
            Text(
              subject.name,
              style: TextStyle(
                fontSize: isTablet ? 15 : 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: isLandscape ? 6 : 4), 

            // DESCRIPTION
            Text(
              subject.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: isTablet ? 11 : 11.5,
                color: Colors.grey[600],
              ),
            ),

            SizedBox(height: isLandscape ? 13 : 6), 

            // LIGNE PROGRESSION + %
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progression',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$percent%',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            SizedBox(height: isLandscape ? 14 : 9), // ← espace label → barre

            // BARRE DE PROGRESSION
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: subject.progress,
                minHeight: isLandscape ? 9 : 6, // ← barre plus épaisse en paysage
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