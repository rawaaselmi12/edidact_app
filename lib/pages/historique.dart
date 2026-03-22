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
          message: 'enfant2 a réussi l\'activité «\u202fL\'infinitif du verbe\u202f»'),
      HistoriqueItem(date: '02/06/2025', heure: '6:00',
          message: 'enfant2 a réussi l\'activité «\u202faddition des nombres\u202f»'),
      HistoriqueItem(date: '04/06/2025', heure: '6:00',
          message: 'enfant2 a utilisé la récompense «\u202frécompense anglais\u202f»'),
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Hamburger ─────────────────────────────────────────
              GestureDetector(
                onTap: _openMenu,
                child: const Icon(Icons.menu, size: 34, color: _kCyan),
              ),

              const SizedBox(height: 16),

              // ── Bannière violette standard ─────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: _kPurple,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text('🏆', style: TextStyle(fontSize: 32)),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Historique',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Suivez l\'évolution et les récompenses\nobtenues par vos enfants',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Onglets enfants ────────────────────────────────────
              Row(
                children: List.generate(_enfants.length, (index) {
                  final isSelected = _selectedIndex == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedIndex = index),
                      child: Container(
                        margin: EdgeInsets.only(right: index == 0 ? 8 : 0),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? _kCyan : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: _kCyan, width: 1.5),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _enfants[index].nom,
                          style: TextStyle(
                            color: isSelected ? Colors.white : _kCyan,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 22),

              Center(
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 340),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: _kCyanLight, width: 1.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.grey.shade300,
                            child: Icon(Icons.person, color: Colors.grey.shade500, size: 24),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(enfant.nom,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                                const SizedBox(height: 4),
                                Wrap(
                                  spacing: 4,
                                  children: [
                                    _Badge(label: '${enfant.niveau} 🪙',
                                        bg: Colors.orange.shade100, fg: Colors.orange.shade800),
                                    _Badge(label: '${enfant.activites} activité',
                                        bg: _kCyan.withOpacity(0.15), fg: _kCyan),
                                    _Badge(label: '${enfant.recompenses} Récompense',
                                        bg: _kPurple.withOpacity(0.12), fg: _kPurple),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Divider(height: 1, color: _kCyanLight),
                      const SizedBox(height: 12),
                      enfant.historique.isEmpty
                          ? _EmptyState()
                          : Column(
                              children: enfant.historique
                                  .map((item) => _HistoriqueRow(item: item))
                                  .toList(),
                            ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        color: _kCyan.withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kCyanLight, width: 1),
      ),
      child: const Column(
        children: [
          Text('Aucune activité',
              style: TextStyle(color: _kCyan, fontWeight: FontWeight.w600, fontSize: 14)),
          SizedBox(height: 6),
          Text('Aucun historique est disponible pour enfant !',
              style: TextStyle(color: Colors.grey, fontSize: 12), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _HistoriqueRow extends StatelessWidget {
  final HistoriqueItem item;
  const _HistoriqueRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: _kCyan.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _kCyanLight, width: 1.2),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: _kCyan.withOpacity(0.15),
              child: const Icon(Icons.person, size: 20, color: _kCyan),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${item.date} · ${item.heure}',
                      style: const TextStyle(fontSize: 10, color: _kCyan)),
                  const SizedBox(height: 4),
                  Text(item.message,
                      style: const TextStyle(fontSize: 12, color: Colors.black87)),
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
  const _Badge({required this.label, required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(label,
          style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
    );
  }
}