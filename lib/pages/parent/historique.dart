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
    final enfant = _enfants[_selectedIndex];

    final size        = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;
    final isTablet    = size.shortestSide >= 600;

    final double scale = (isTablet && isLandscape)
        ? 1.5
        : (isTablet && !isLandscape)
            ? 1.4
            : 1.0;

    double s(double value) => value * scale;

    final bool isTabletLandscape = isTablet && isLandscape;

  
    final double btnVerticalPadding = isLandscape ? s(22) : s(10);
    final double btnFontSize        = isLandscape ? s(18) : s(14);

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

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: s(20), vertical: s(20)),
                decoration: BoxDecoration(
                  color: _kPurple,
                  borderRadius: BorderRadius.circular(s(18)),
                ),
                child: Row(
                  children: [
                    Text('🏆', style: TextStyle(fontSize: s(32))),
                    SizedBox(width: s(14)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Historique',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: s(16),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: s(8)),
                          Text(
                            'Suivez l\'évolution et les récompenses obtenues par vos enfants',
                            style: TextStyle(color: Colors.white70, fontSize: s(13)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: s(16)),

//bouttons 
              Row(
                children: List.generate(_enfants.length, (index) {
                  final isSelected = _selectedIndex == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedIndex = index),
                      child: Container(
                        margin: EdgeInsets.only(right: index == 0 ? s(8) : 0),
                        padding: EdgeInsets.symmetric(vertical: btnVerticalPadding),
                        decoration: BoxDecoration(
                          color: isSelected ? _kCyan : Colors.white,
                          borderRadius: BorderRadius.circular(s(12)),
                          border: Border.all(color: _kCyan, width: 1.5),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _enfants[index].nom,
                          style: TextStyle(
                            color: isSelected ? Colors.white : _kCyan,
                            fontWeight: FontWeight.w600,
                            fontSize: btnFontSize,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: s(22)),

              Center(
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: isTabletLandscape ? size.width * 0.8 : double.infinity,
                  ),
                  padding: EdgeInsets.all(s(24)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: _kCyanLight, width: 1.5),
                    borderRadius: BorderRadius.circular(s(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar + nom + badges
                      Row(
                        children: [
                          CircleAvatar(
                            radius: s(30),
                            backgroundColor: Colors.grey.shade300,
                            child: Icon(Icons.person,
                                color: Colors.grey.shade500,
                                size: s(32)),
                          ),
                          SizedBox(width: s(14)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  enfant.nom,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: s(18),
                                  ),
                                ),
                                SizedBox(height: s(6)),
                                Wrap(
                                  spacing: s(6),
                                  runSpacing: s(4),
                                  children: [
                                    _Badge(label: '${enfant.niveau} 🪙',
                                        bg: Colors.orange.shade100,
                                        fg: Colors.orange.shade800,
                                        scale: scale),
                                    _Badge(label: '${enfant.activites} activité',
                                        bg: _kCyan.withOpacity(0.15),
                                        fg: _kCyan,
                                        scale: scale),
                                    _Badge(label: '${enfant.recompenses} Récompense',
                                        bg: _kPurple.withOpacity(0.12),
                                        fg: _kPurple,
                                        scale: scale),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: s(16)),
                      Divider(color: _kCyanLight, thickness: 1.2),
                      SizedBox(height: s(16)),

                      enfant.historique.isEmpty
                          ? _EmptyState(scale: scale)
                          : Column(
                              children: enfant.historique
                                  .map((item) => _HistoriqueRow(item: item, scale: scale))
                                  .toList(),
                            ),
                    ],
                  ),
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
      padding: EdgeInsets.symmetric(vertical: 36 * scale),
      decoration: BoxDecoration(
        color: _kCyan.withOpacity(0.07),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: _kCyanLight),
      ),
      child: Column(
        children: [
          Text(
            'Aucune activité',
            style: TextStyle(
              color: _kCyan,
              fontWeight: FontWeight.w600,
              fontSize: 16 * scale,
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'Aucun historique est disponible pour enfant !',
            style: TextStyle(color: Colors.grey, fontSize: 15 * scale),
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
      padding: EdgeInsets.only(bottom: 14 * scale),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
        decoration: BoxDecoration(
          color: _kCyan.withOpacity(0.04),
          borderRadius: BorderRadius.circular(14 * scale),
          border: Border.all(color: _kCyanLight),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24 * scale,
              backgroundColor: _kCyan.withOpacity(0.15),
              child: Icon(Icons.person, color: _kCyan, size: 26 * scale),
            ),
            SizedBox(width: 12 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item.date} · ${item.heure}',
                    style: TextStyle(fontSize: 12 * scale, color: _kCyan),
                  ),
                  SizedBox(height: 5 * scale),
                  Text(
                    item.message,
                    style: TextStyle(fontSize: 15 * scale),
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
      padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20 * scale),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13 * scale,
          color: fg,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}