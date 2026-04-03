import 'package:flutter/material.dart';
import 'package:edidact_app/widgets/menu_barre.dart';

const _kPurple    = Color(0xFF9C27B0);
const _kCyan      = Color(0xFF00BCD4);
const _kCyanLight = Color(0xFF26C6DA);

class Enfant {
  final String nom;
  final int niveau;
  final int activites;
  final int recompenses;
  final List<HistoriqueItem> historique;

  const Enfant({
    required this.nom,
    required this.niveau,
    required this.activites,
    required this.recompenses,
    required this.historique,
  });
}

class HistoriqueItem {
  final String date;
  final String heure;
  final String message;

  const HistoriqueItem({
    required this.date,
    required this.heure,
    required this.message,
  });
}

final List<Enfant> _enfants = [
  const Enfant(nom: 'enfant 1', niveau: 0, activites: 0, recompenses: 0, historique: []),
  Enfant(
    nom: 'enfant 2',
    niveau: 5,
    activites: 8,
    recompenses: 5,
    historique: [
      HistoriqueItem(date: '04/06/2025', heure: '6:00',
          message: 'enfant2 a réussi l\'activité « L\'infinitif du verbe »'),
      HistoriqueItem(date: '02/06/2025', heure: '6:00',
          message: 'enfant2 a réussi l\'activité « addition des nombres »'),
      HistoriqueItem(date: '04/06/2025', heure: '6:00',
          message: 'enfant2 a utilisé la récompense « récompense anglais »'),
    ],
  ),
];

class HistoriquePage extends StatefulWidget {
  const HistoriquePage({super.key});

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  int _selectedIndex = 0;

  bool _isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.longestSide >= 900 || size.shortestSide >= 600;
  }

  void _openMenu() {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black45,
        pageBuilder: (_, __, ___) => const MenuBarre(),
        transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
              .animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final enfant   = _enfants[_selectedIndex];
    final isTablet = _isTablet(context);

    final size        = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    final double scale = (isTablet && isLandscape)
        ? 1.5
        : (isTablet && !isLandscape)
            ? 1.4
            : 1.0;

    final double cardScale = (isTablet && isLandscape)
        ? 1.05
        : (isTablet && !isLandscape)
            ? 1.0
            : 0.82;

    double s(double value) => value * scale;
    double c(double value) => value * cardScale;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: s(16), vertical: s(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              GestureDetector(
                onTap: _openMenu,
                child: Icon(Icons.menu, size: s(34), color: _kCyan),
              ),
              SizedBox(height: s(16)),

              // ── HEADER violet ──
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 26 : 20,
                  vertical:   isTablet ? 24 : 20,
                ),
                decoration: BoxDecoration(
                  color: _kPurple,
                  borderRadius: BorderRadius.circular(isTablet ? 22 : 18),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('🏆', style: TextStyle(fontSize: isTablet ? 44 : 32)),
                    SizedBox(width: isTablet ? 18 : 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Historique',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isTablet ? 21 : 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: isTablet ? 10 : 8),
                          Text(
                            'Suivez l\'évolution et les récompenses obtenues par vos enfants',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: isTablet ? 16 : 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: s(16)),

              // ── Sélecteur enfants ──
              Row(
                children: List.generate(_enfants.length, (index) {
                  final isSelected = _selectedIndex == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedIndex = index),
                      child: Container(
                        margin: EdgeInsets.only(
                          right: index == 0 ? (isTablet ? 12 : 8) : 0,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: isTablet ? 15 : 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? _kCyan : Colors.white,
                          borderRadius: BorderRadius.circular(isTablet ? 14 : 10),
                          border: Border.all(color: _kCyan, width: 1.5),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _enfants[index].nom,
                          style: TextStyle(
                            color: isSelected ? Colors.white : _kCyan,
                            fontWeight: FontWeight.w600,
                            fontSize: isTablet ? 18 : 15,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: s(22)),

              // ── Boîte bleue : même largeur que le header (width: double.infinity) ──
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(c(20)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: _kCyanLight, width: 1.5),
                  borderRadius: BorderRadius.circular(c(18)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar + nom + badges
                    Row(
                      children: [
                        CircleAvatar(
                          radius: c(26),
                          backgroundColor: Colors.grey.shade300,
                          child: Icon(Icons.person,
                              color: Colors.grey.shade500,
                              size: c(28)),
                        ),
                        SizedBox(width: c(12)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                enfant.nom,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: c(15),
                                ),
                              ),
                              SizedBox(height: c(5)),
                              Wrap(
                                spacing: c(5),
                                runSpacing: c(3),
                                children: [
                                  _Badge(label: '${enfant.niveau} 🪙',
                                      bg: Colors.orange.shade100,
                                      fg: Colors.orange.shade800,
                                      scale: cardScale),
                                  _Badge(label: '${enfant.activites} activité',
                                      bg: _kCyan.withOpacity(0.15),
                                      fg: _kCyan,
                                      scale: cardScale),
                                  _Badge(label: '${enfant.recompenses} Récompense',
                                      bg: _kPurple.withOpacity(0.12),
                                      fg: _kPurple,
                                      scale: cardScale),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: c(14)),
                    Divider(color: _kCyanLight, thickness: 1.2),
                    SizedBox(height: c(14)),

                    enfant.historique.isEmpty
                        ? _EmptyState(scale: cardScale)
                        : Column(
                            children: enfant.historique
                                .map((item) => _HistoriqueRow(item: item, scale: cardScale))
                                .toList(),
                          ),
                  ],
                ),
              ),

              SizedBox(height: s(24)),
            ],
          ),
        ),
      ),
    );
  }
}


class _EmptyState extends StatelessWidget {
  final double scale;
  const _EmptyState({this.scale = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 28 * scale),
      decoration: BoxDecoration(
        color: _kCyan.withOpacity(0.07),
        borderRadius: BorderRadius.circular(10 * scale),
        border: Border.all(color: _kCyanLight),
      ),
      child: Column(
        children: [
          Text(
            'Aucune activité',
            style: TextStyle(
              color: _kCyan,
              fontWeight: FontWeight.w600,
              fontSize: 14 * scale,
            ),
          ),
          SizedBox(height: 6 * scale),
          Text(
            'Aucun historique est disponible pour enfant !',
            style: TextStyle(color: Colors.grey, fontSize: 13 * scale),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}


class _HistoriqueRow extends StatelessWidget {
  final HistoriqueItem item;
  final double scale;
  const _HistoriqueRow({required this.item, this.scale = 1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12 * scale),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 12 * scale),
        decoration: BoxDecoration(
          color: _kCyan.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(color: _kCyanLight),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20 * scale,
              backgroundColor: _kCyan.withOpacity(0.15),
              child: Icon(Icons.person, color: _kCyan, size: 22 * scale),
            ),
            SizedBox(width: 10 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item.date} · ${item.heure}',
                    style: TextStyle(fontSize: 11 * scale, color: _kCyan),
                  ),
                  SizedBox(height: 4 * scale),
                  Text(
                    item.message,
                    style: TextStyle(fontSize: 13 * scale),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;
  final double scale;

  const _Badge({
    required this.label,
    required this.bg,
    required this.fg,
    this.scale = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9 * scale, vertical: 3 * scale),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16 * scale),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11 * scale,
          color: fg,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}