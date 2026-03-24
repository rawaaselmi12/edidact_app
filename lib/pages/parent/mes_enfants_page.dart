import 'package:flutter/material.dart';
import 'package:edidact_app/widgets/menu_barre.dart';
import 'package:edidact_app/pages/parent/ajout_enfant.dart';
import 'package:edidact_app/pages/parent/edit_enfant.dart';
import 'package:edidact_app/pages/enfant/enfant_ex.dart'; // ← import ajouté

const _kPurple    = Color(0xFF9C27B0);
const _kCyan      = Color(0xFF00BCD4);
const _kCyanLight = Color(0xFF26C6DA);

class Child {
  final String name;
  final String level;
  final String pseudo;
  final String password;

  const Child({
    required this.name,
    required this.level,
    required this.pseudo,
    required this.password,
  });
}

const List<Child> _children = [
  Child(name: 'Nom enfant', level: '4e-5e Harmos', pseudo: 'kskdsd', password: 'kakdsd'),
  Child(name: 'Nom enfant', level: '1e-2e Harmos', pseudo: 'behg', password: 'hsj'),
];

class MesEnfantsPage extends StatefulWidget {
  const MesEnfantsPage({super.key});

  @override
  State<MesEnfantsPage> createState() => _MesEnfantsPageState();
}

class _MesEnfantsPageState extends State<MesEnfantsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Child> _filtered = _children;

  void _onSearch(String query) {
    setState(() {
      _filtered = _children
          .where((c) =>
              c.name.toLowerCase().contains(query.toLowerCase()) ||
              c.pseudo.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
              // ── Menu icon ─────────────────────────────────────────
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    opaque: false,
                    barrierColor: Colors.black45,
                    pageBuilder: (_, __, ___) => const MenuBarre(),
                  ),
                ),
                child: const Icon(Icons.menu, size: 34, color: _kCyan),
              ),

              const SizedBox(height: 16),

              // ── Header card ────────────────────────────────────────
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
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.people_alt_rounded, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mes enfants :',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Gérez les comptes de vos enfants et\nsuivez leur progression',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ── Search bar ─────────────────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: _onSearch,
                        style: const TextStyle(fontSize: 13),
                        decoration: const InputDecoration(
                          hintText: 'Rechercher un enfant...',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    const Icon(Icons.search, color: Colors.grey, size: 20),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ── Add button ─────────────────────────────────────────
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.black45,
                    builder: (_) => const AjoutEnfantPage(),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                    color: _kCyanLight,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'ajouter enfant',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ..._filtered.map((child) => _ChildCard(child: child)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChildCard extends StatelessWidget {
  final Child child;
  const _ChildCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 36),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kCyan, width: 1.5),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
                  child: const Icon(Icons.person, color: Colors.white, size: 36),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(child.name,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87)),
                      Text(child.level,
                          style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 12.5),
                          children: [
                            TextSpan(text: 'PSEUDO : ',
                                style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600)),
                            TextSpan(text: child.pseudo,
                                style: const TextStyle(color: Colors.black87)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 12.5),
                          children: [
                            TextSpan(text: 'Mot DE PASSE : ',
                                style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600)),
                            TextSpan(text: child.password,
                                style: const TextStyle(color: Colors.black87)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.black45,
                        builder: (_) => EditEnfantPage(
                          nom: child.name,
                          classe: child.level,
                          identifiant: child.pseudo,
                          motDePasse: child.password,
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: _kCyan, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text('Modifier',
                        style: TextStyle(color: _kCyan, fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    // ── Navigation vers EnfantExPage ──────────────────
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EnfantExPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _kCyan,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      elevation: 0,
                    ),
                    child: const Text('se connecter',
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}