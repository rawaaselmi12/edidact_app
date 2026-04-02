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
    final isLandscape  = _isLandscape(context);
    final screenWidth  = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth >= 600;
    final double hPad  = isTablet ? 24 : 16;

  
    final int cols = isLandscape ? 3 : (screenWidth >= 600 ? 2 : 1);

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

           
              isLandscape
                  ? _buildSearchAndButtonRow(context, isTablet)
                  : _buildSearchAndButtonColumn(context, isTablet),

              SizedBox(height: isTablet ? 24 : 20),

              
              cols == 1
                  ? Column(
                      children: _filtered
                          .map((c) => _ChildCard(child: c, isTablet: false))
                          .toList(),
                    )
                  : _buildGrid(_filtered, cols: cols, isTablet: isTablet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(List<Child> children, {required int cols, required bool isTablet}) {
    final rows = <Widget>[];
    for (int i = 0; i < children.length; i += cols) {
      final rowItems = children.sublist(i, (i + cols).clamp(0, children.length));
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(cols, (j) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left:   j == 0        ? 0 : 8,
                  right:  j == cols - 1 ? 0 : 8,
                  bottom: 16,
                ),
                child: j < rowItems.length
                    ? _ChildCard(child: rowItems[j], isTablet: isTablet)
                    : const SizedBox(),
              ),
            );
          }),
        ),
      );
    }
    return Column(children: rows);
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
}


class _ChildCard extends StatelessWidget {
  final Child child;
  final bool  isTablet;
  const _ChildCard({required this.child, this.isTablet = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isTablet ? 16 : 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
        border: Border.all(color: _kCyan, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(isTablet ? 18 : 14),
            child: Column(
              children: [
                // Avatar centré
                Container(
                  width: isTablet ? 72 : 60,
                  height: isTablet ? 72 : 60,
                  decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
                  child: Icon(Icons.person, color: Colors.white, size: isTablet ? 42 : 34),
                ),
                SizedBox(height: isTablet ? 10 : 8),

                // Nom + niveau
                Text(
                  child.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  child.level,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: isTablet ? 13 : 11, color: Colors.grey[500]),
                ),

                SizedBox(height: isTablet ? 12 : 10),

                // Pseudo + mot de passe
                _infoRow('PSEUDO', child.pseudo, isTablet),
                SizedBox(height: isTablet ? 6 : 4),
                _infoRow('MOT DE PASSE', child.password, isTablet),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(
              isTablet ? 18 : 14, 0,
              isTablet ? 18 : 14,
              isTablet ? 18 : 14,
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
                      padding: EdgeInsets.symmetric(vertical: isTablet ? 13 : 10),
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      'Modifier',
                      style: TextStyle(
                        color: _kCyan,
                        fontSize: isTablet ? 14 : 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
MaterialPageRoute(builder: (_) => EnfantExPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _kCyan,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.symmetric(vertical: isTablet ? 13 : 10),
                      elevation: 0,
                    ),
                    child: Text(
                      'Connecter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isTablet ? 14 : 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 10 : 8,
        vertical:   isTablet ? 6  : 4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F7FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: isTablet ? 13 : 11.5),
          children: [
            TextSpan(
              text: '$label : ',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}