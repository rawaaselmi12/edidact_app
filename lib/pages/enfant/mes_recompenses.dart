import 'package:flutter/material.dart';
import 'package:edidact_app/widgets/menu_barre_enfant.dart';

const _kCyan = Color(0xFF00BCD4);
const _kPurple = Color(0xFF9C27B0);

class MesRecompensePage extends StatefulWidget {
  const MesRecompensePage({super.key});

  @override
  State<MesRecompensePage> createState() => _MesRecompensePageState();
}

class _MesRecompensePageState extends State<MesRecompensePage> {
  int _selectedTab = 0;

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

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: _kPurple,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.emoji_events_rounded,
                          color: Colors.white, size: 32),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mes Récompenses',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Découvre toutes les récompenses et utilise tes coins pour en obtenir de nouvelles !',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _TabButton(
                      label: 'Cagnotte',
                      selected: _selectedTab == 0,
                      onTap: () => setState(() => _selectedTab = 0),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _TabButton(
                      label: 'Disponibles',
                      selected: _selectedTab == 1,
                      onTap: () => setState(() => _selectedTab = 1),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _TabButton(
                      label: 'Utilisées',
                      selected: _selectedTab == 2,
                      onTap: () => setState(() => _selectedTab = 2),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              if (_selectedTab == 0) _buildCagnotte(),
              if (_selectedTab == 1) _buildDisponibles(),
              if (_selectedTab == 2) _buildUtilisees(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCagnotte() {
    return Column(
      children: [
        const Center(
          child: Text(
            'Tes accomplissements et tes réussites',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: 32),

        Center(
          child: SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: 0.65,
                    strokeWidth: 15,
                    strokeCap: StrokeCap.round,
                    backgroundColor: const Color(0xFFB2EBF2),
                    valueColor: const AlwaysStoppedAnimation<Color>(_kCyan),
                  ),
                ),
                Image.asset(
                  'assets/images/image1.png',
                  width: 120,
                  height: 120,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 40),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatItem('🏆', '5 Coupes'),
            const SizedBox(width: 40),
            _buildStatItem('🪙', '9 Coins'),
          ],
        ),

        const SizedBox(height: 40),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Bravo continue comme ça !',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFCB317),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String emoji, String label) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 40)),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildDisponibles() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(top: 60),
        child: Text('Aucune récompense disponible',
            style: TextStyle(fontSize: 15, color: Colors.grey)),
      ),
    );
  }

  Widget _buildUtilisees() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(top: 60),
        child: Text('Aucune récompense utilisée',
            style: TextStyle(fontSize: 15, color: Colors.grey)),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: selected
          ? Container(
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _kCyan,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _kCyan.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          
          : Container(
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _kCyan,
                  width: 2,
                ),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _kCyan,
                ),
              ),
            ),
    );
  }
}