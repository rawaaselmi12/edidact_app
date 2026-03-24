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
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Menu icon → MenuBarreEnfant ────────────────────
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    opaque: false,
                    barrierColor: Colors.black45,
                    pageBuilder: (_, __, ___) => const MenuBarreEnfant(),
                  ),
                ),
                child: const Icon(Icons.menu, size: 34, color: _kCyan),
              ),

              const SizedBox(height: 16),

              // ── Header card ────────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: _kPurple,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person,
                          color: Colors.white, size: 32),
                    ),
                    const SizedBox(width: 16),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bonjour Enfant',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Choisis une matière pour commencer',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Table des matières label ───────────────────────
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.menu_book_rounded,
                        color: Colors.red[400], size: 18),
                    const SizedBox(width: 8),
                    const Text(
                      'Table des matières',
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Subject cards ──────────────────────────────────
              ..._subjects.map((subject) => _SubjectCard(subject: subject)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final Subject subject;
  const _SubjectCard({required this.subject});

  @override
  Widget build(BuildContext context) {
    final int percent = (subject.progress * 100).round();

    return GestureDetector(
      // ✅ Clic carte → SousMatierePage avec nom de la matière
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SousMatierePage(matiereNom: subject.name),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        decoration: BoxDecoration(
          color: subject.color,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subject.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subject.description,
              style: TextStyle(fontSize: 11.5, color: Colors.grey[600]),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Progression',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '$percent%',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: subject.progress,
                minHeight: 7,
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