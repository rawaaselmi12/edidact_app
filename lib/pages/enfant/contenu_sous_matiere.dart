import 'package:flutter/material.dart';
import 'package:edidact_app/widgets/menu_barre_enfant.dart';

const _kCyan        = Color(0xFF00BCD4);
const _kYellow      = Color(0xFFFCB317);
const _kYellowLight = Color(0xFFFFF0C2);
const _kBlueLight   = Color(0xFFB2EBF2);
const _kBlueDark    = Color.fromARGB(255, 8, 153, 189);

class Lecon {
  final String name;
  final String description;
  final double progress;
  final Color color;

  const Lecon({
    required this.name,
    required this.description,
    required this.progress,
    required this.color,
  });
}

const List<Lecon> _lecons = [
  Lecon(
    name: '......',
    description: 'Découvrez cette matière passionnante avec nos exercices adaptés',
    progress: 0.0,
    color: _kYellowLight,
  ),
  Lecon(
    name: '...',
    description: 'Découvrez cette matière passionnante avec nos exercices adaptés',
    progress: 0.0,
    color: _kBlueLight,
  ),
  Lecon(
    name: '.....',
    description: 'Découvrez cette matière passionnante avec nos exercices adaptés',
    progress: 0.0,
    color: _kYellowLight,
  ),
];

class ContenuSousMatierePage extends StatelessWidget {
  final String sousMatiereNom;
  const ContenuSousMatierePage({super.key, required this.sousMatiereNom});

  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  bool _isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  @override
  Widget build(BuildContext context) {
    final isTablet    = _isTablet(context);
    final isLandscape = _isLandscape(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 24 : 16,
            vertical:   isTablet ? 18 : 12,
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
                    size: isTablet ? 38 : 34, color: _kCyan),
              ),

              SizedBox(height: isTablet ? 28 : 24),

              Container(
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
                    Icon(Icons.menu_book_rounded,
                        color: Colors.red[400],
                        size: isTablet ? 24 : 20),
                    SizedBox(width: isTablet ? 12 : 10),
                    Text(
                      sousMatiereNom,
                      style: TextStyle(
                        fontSize: isTablet ? 18 : 16,
                        fontWeight: FontWeight.w600,
                        color: _kCyan,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: isTablet ? 20 : 16),

              if (isTablet && isLandscape)
                _buildGrid2Col(context)
              else
                _buildList(isTablet: isTablet),
            ],
          ),
        ),
      ),
    );
  }

  // Portrait (phone + tablet) : liste 1 colonne
  Widget _buildList({required bool isTablet}) {
    return Column(
      children: _lecons
          .map((l) => _LeconCard(lecon: l, isTablet: isTablet, isLandscape: false))
          .toList(),
    );
  }

  Widget _buildGrid2Col(BuildContext context) {
    final rows = <Widget>[];
    for (int i = 0; i < _lecons.length; i += 2) {
      final left  = _lecons[i];
      final right = i + 1 < _lecons.length ? _lecons[i + 1] : null;
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 14),
                child: _LeconCard(
                    lecon: left, isTablet: true, isLandscape: true),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 14),
                child: right != null
                    ? _LeconCard(
                        lecon: right, isTablet: true, isLandscape: true)
                    : const SizedBox(),
              ),
            ),
          ],
        ),
      );
    }
    return Column(children: rows);
  }
}

class _LeconCard extends StatelessWidget {
  final Lecon lecon;
  final bool isTablet;
  final bool isLandscape;

  const _LeconCard({
    required this.lecon,
    required this.isTablet,
    required this.isLandscape,
  });

  @override
  Widget build(BuildContext context) {
    final int percent   = (lecon.progress * 100).round();
    final bool isYellow = lecon.color == _kYellowLight;

    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: isTablet ? 14 : 8),
        padding: EdgeInsets.fromLTRB(
          isTablet ? 18 : 16,
          isTablet ? 16 : 14,
          isTablet ? 18 : 16,
          isTablet ? 16 : 14,
        ),
        decoration: BoxDecoration(
          color: lecon.color,
          borderRadius: BorderRadius.circular(isTablet ? 18 : 14),
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
              lecon.name,
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: isTablet ? 5 : 3),
            Text(
              lecon.description,
              style: TextStyle(
                fontSize: isTablet ? 13 : 11.5,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: isTablet ? 12 : 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progression:',
                  style: TextStyle(
                    fontSize: isTablet ? 13 : 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '$percent%',
                  style: TextStyle(
                    fontSize: isTablet ? 14 : 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(height: isTablet ? 7 : 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: lecon.progress,
                minHeight: isTablet ? 8 : 7,
                backgroundColor: Colors.white.withOpacity(0.6),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.cyanAccent)
                ),
              ),
          
          ],
        ),
      ),
    );
  }
}