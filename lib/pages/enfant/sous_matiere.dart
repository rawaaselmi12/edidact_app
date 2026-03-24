import 'package:flutter/material.dart';
import 'package:edidact_app/widgets/menu_barre_enfant.dart';
// import 'package:edidact_app/pages/lecon_list_page.dart'; // ← page 3 (à venir)

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

// Données temporaires — sera remplacé par appel API Laravel
// GET /api/sous-matieres?matiere_id=...
const List<SousMatiere> _sousMatieres = [
  SousMatiere(
    name: '......',
    description: 'Découvrez cette matière passionnante avec nos exercices adaptés',
    progress: 0.0,
    color: _kYellowLight,
  ),
  SousMatiere(
    name: '...',
    description: 'Découvrez cette matière passionnante avec nos exercices adaptés',
    progress: 0.0,
    color: _kBlueLight,
  ),
  SousMatiere(
    name: '.....',
    description: 'Découvrez cette matière passionnante avec nos exercices adaptés',
    progress: 0.0,
    color: _kYellowLight,
  ),
  SousMatiere(
    name: '....',
    description: 'Découvrez cette matière passionnante avec nos exercices adaptés',
    progress: 0.0,
    color: _kBlueLight,
  ),
];

class SousMatierePage extends StatelessWidget {
  final String matiereNom; // reçu depuis EnfantExPage

  const SousMatierePage({super.key, required this.matiereNom});

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

              const SizedBox(height: 24),

              // ── Header : nom de la matière cliquée ────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.menu_book_rounded,
                        color: Colors.red[400], size: 20),
                    const SizedBox(width: 10),
                    Text(
                      matiereNom,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _kCyan,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── Sous-matière cards (jaune/bleu alternés) ───────
              ..._sousMatieres.map((sm) => _SousMatiereCard(sousMatiere: sm)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SousMatiereCard extends StatelessWidget {
  final SousMatiere sousMatiere;
  const _SousMatiereCard({required this.sousMatiere});

  @override
  Widget build(BuildContext context) {
    final int percent = (sousMatiere.progress * 100).round();
    final bool isYellow = sousMatiere.color == _kYellowLight;

    return GestureDetector(
      // ✅ Clic → LeconListPage (page 3 — à venir)
      onTap: () {
        // TODO: Navigator.push → LeconListPage(sousMatiereNom: sousMatiere.name)
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        decoration: BoxDecoration(
          color: sousMatiere.color,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isYellow
                ? _kYellow.withOpacity(0.6)
                : _kCyan.withOpacity(0.4),
            width: 1.2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sousMatiere.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              sousMatiere.description,
              style: TextStyle(fontSize: 11.5, color: Colors.grey[600]),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Progression:',
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
                value: sousMatiere.progress,
                minHeight: 7,
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