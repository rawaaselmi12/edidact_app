import 'package:flutter/material.dart';
import 'package:edidact_app/widgets/menu_barre.dart';
import 'package:edidact_app/pages/parent/ajout_enfant.dart';
import 'package:edidact_app/pages/parent/edit_enfant.dart';
import 'package:edidact_app/pages/enfant/enfant_ex.dart';

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
  Child(name: 'Nom enfant', level: '1e-2e Harmos', pseudo: 'behg',   password: 'hsj'),
];

class MesEnfantsPage extends StatefulWidget {
  const MesEnfantsPage({super.key});

  @override
  State<MesEnfantsPage> createState() => _MesEnfantsPageState();
}

class _MesEnfantsPageState extends State<MesEnfantsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Child> _filtered = _children;

  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  bool _isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

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
    final isTablet    = _isTablet(context);
    final isLandscape = _isLandscape(context);
    final double hPad = isTablet ? 24 : 16;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    opaque: false,
                    barrierColor: Colors.black45,
                    pageBuilder: (_, __, ___) => const MenuBarre(),
                  ),
                ),
                child: Icon(Icons.menu, size: isTablet ? 40 : 34, color: _kCyan),
              ),

              SizedBox(height: isTablet ? 20 : 16),

              _buildHeaderCard(isTablet),

              SizedBox(height: isTablet ? 18 : 14),

              isLandscape && isTablet
                  ? _buildSearchAndButtonRow(context, isTablet)
                  : _buildSearchAndButtonColumn(context, isTablet),

              SizedBox(height: isTablet ? 24 : 20),

              isLandscape && isTablet
                  ? _buildChildrenGrid()
                  : _buildChildrenList(isTablet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 24 : 20,
        vertical:   isTablet ? 22 : 20,
      ),
      decoration: BoxDecoration(
        color: _kPurple,
        borderRadius: BorderRadius.circular(isTablet ? 20 : 18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: isTablet ? 52 : 44,
            height: isTablet ? 52 : 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.people_alt_rounded, color: Colors.white, size: isTablet ? 28 : 24),
          ),
          SizedBox(width: isTablet ? 16 : 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mes enfants :',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 20 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: isTablet ? 10 : 8),
                Text(
                  'Gérez les comptes de vos enfants et suivez leur progression',
                  style: TextStyle(color: Colors.white70, fontSize: isTablet ? 14 : 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndButtonRow(BuildContext context, bool isTablet) {
    return Row(
      children: [
        Expanded(child: _buildSearchBar(isTablet)),
        const SizedBox(width: 14),
        _buildAddButton(context, isTablet),
      ],
    );
  }

  Widget _buildSearchAndButtonColumn(BuildContext context, bool isTablet) {
    return Column(
      children: [
        _buildSearchBar(isTablet),
        SizedBox(height: isTablet ? 14 : 12),
        _buildAddButton(context, isTablet, fullWidth: true),
      ],
    );
  }

  Widget _buildSearchBar(bool isTablet) {
    return Container(
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
              style: TextStyle(fontSize: isTablet ? 15 : 13),
              decoration: InputDecoration(
                hintText: 'Rechercher un enfant...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: isTablet ? 15 : 13),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: isTablet ? 14 : 10),
              ),
            ),
          ),
          Icon(Icons.search, color: Colors.grey, size: isTablet ? 24 : 20),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context, bool isTablet, {bool fullWidth = false}) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          barrierColor: Colors.black45,
          builder: (_) => const AjoutEnfantPage(),
        );
      },
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 28 : 0,
          vertical:   isTablet ? 14 : 13,
        ),
        decoration: BoxDecoration(
          color: _kCyanLight,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          'ajouter enfant',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: isTablet ? 16 : 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildChildrenGrid() {
    final rows = <Widget>[];
    for (int i = 0; i < _filtered.length; i += 2) {
      final first  = _filtered[i];
      final second = i + 1 < _filtered.length ? _filtered[i + 1] : null;
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _ChildCardLandscape(child: first)),
            const SizedBox(width: 16),
            Expanded(
              child: second != null
                  ? _ChildCardLandscape(child: second)
                  : const SizedBox(),
            ),
          ],
        ),
      );
      rows.add(const SizedBox(height: 16));
    }
    return Column(children: rows);
  }

  Widget _buildChildrenList(bool isTablet) {
    return Column(
      children: _filtered
          .map((child) => _ChildCardPortrait(child: child, isTablet: isTablet))
          .toList(),
    );
  }
}

class _ChildCardLandscape extends StatelessWidget {
  final Child child;
  const _ChildCardLandscape({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kCyan, width: 1.5),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
            child: const Icon(Icons.person, color: Colors.white, size: 42),
          ),
          const SizedBox(height: 10),

          // Nom
          Text(
            child.name,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          Text(
            child.level,
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),

          const SizedBox(height: 14),

          // Chips pseudo + mot de passe
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _InfoChip(label: 'PSEUDO', value: child.pseudo, color: _kCyanLight),
              const SizedBox(width: 8),
              _InfoChip(label: 'Mot DE PASSE', value: child.password, color: _kCyan),
            ],
          ),

          const SizedBox(height: 16),

          // Boutons
          Row(
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EnfantExPage()),
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
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  final Color  color;
  const _InfoChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Text(label,
              style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.bold)),
          Text(value,
              style: const TextStyle(fontSize: 11, color: Colors.black87, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _ChildCardPortrait extends StatelessWidget {
  final Child child;
  final bool  isTablet;
  const _ChildCardPortrait({required this.child, this.isTablet = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isTablet ? 24 : 36),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
        border: Border.all(color: _kCyan, width: 1.5),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              isTablet ? 20 : 14,
              isTablet ? 20 : 16,
              isTablet ? 20 : 14,
              isTablet ? 20 : 16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: isTablet ? 80 : 64,
                  height: isTablet ? 80 : 64,
                  decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
                  child: Icon(Icons.person, color: Colors.white, size: isTablet ? 46 : 36),
                ),
                SizedBox(width: isTablet ? 18 : 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(child.name,
                          style: TextStyle(
                            fontSize: isTablet ? 20 : 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          )),
                      Text(child.level,
                          style: TextStyle(fontSize: isTablet ? 14 : 12, color: Colors.grey[500])),
                      SizedBox(height: isTablet ? 10 : 8),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: isTablet ? 14 : 12.5),
                          children: [
                            TextSpan(
                              text: 'PSEUDO : ',
                              style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600),
                            ),
                            TextSpan(text: child.pseudo, style: const TextStyle(color: Colors.black87)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: isTablet ? 14 : 12.5),
                          children: [
                            TextSpan(
                              text: 'Mot DE PASSE : ',
                              style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600),
                            ),
                            TextSpan(text: child.password, style: const TextStyle(color: Colors.black87)),
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
            padding: EdgeInsets.fromLTRB(
              isTablet ? 20 : 14, 0,
              isTablet ? 20 : 14,
              isTablet ? 20 : 14,
            ),
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
                      padding: EdgeInsets.symmetric(vertical: isTablet ? 14 : 11),
                      backgroundColor: Colors.white,
                    ),
                    child: Text('Modifier',
                        style: TextStyle(color: _kCyan, fontSize: isTablet ? 16 : 14, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const EnfantExPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _kCyan,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.symmetric(vertical: isTablet ? 14 : 11),
                      elevation: 0,
                    ),
                    child: Text('se connecter',
                        style: TextStyle(color: Colors.white, fontSize: isTablet ? 16 : 14, fontWeight: FontWeight.w600)),
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