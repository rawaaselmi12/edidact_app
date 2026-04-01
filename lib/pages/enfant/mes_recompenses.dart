import 'package:flutter/material.dart';
import 'package:edidact_app/widgets/menu_barre_enfant.dart';

const _kCyan = Color(0xFF00BCD4);
const _kPurple = Color(0xFF9C27B0);
const double _kTabletBreakpoint = 600;

class MesRecompensePage extends StatefulWidget {
  const MesRecompensePage({super.key});

  @override
  State<MesRecompensePage> createState() => _MesRecompensePageState();
}

class _MesRecompensePageState extends State<MesRecompensePage> {
  int _selectedTab = 0;

  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= _kTabletBreakpoint;

  @override
  Widget build(BuildContext context) {
    final isTablet = _isTablet(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: SafeArea(
        child: _buildLayout(context, isTablet),
      ),
    );
  }

  Widget _buildLayout(BuildContext context, bool isTablet) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final hPad = isLandscape && isTablet ? 40.0 : (isTablet ? 20.0 : 16.0);

    return SingleChildScrollView(
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
                pageBuilder: (_, __, ___) => const MenuBarreEnfant(),
              ),
            ),
            child: const Icon(Icons.menu, size: 34, color: _kCyan),
          ),
          const SizedBox(height: 14),

          _buildHeaderCard(),
          const SizedBox(height: 14),

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
          const SizedBox(height: 24),

          if (_selectedTab == 0)
            _buildCagnotte(isTablet: isTablet, isLandscape: isLandscape),
          if (_selectedTab == 1)
            _buildDisponibles(isTablet: isTablet, isLandscape: isLandscape),
          if (_selectedTab == 2)
            _buildUtilisees(isTablet: isTablet, isLandscape: isLandscape),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: _kPurple,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.emoji_events_rounded,
                color: Colors.white, size: 28),
          ),
          const SizedBox(width: 14),
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
    );
  }

 
  Widget _buildCagnotte({bool isTablet = false, bool isLandscape = false}) {
    final bool isTabletPortrait = isTablet && !isLandscape;

    final double circleSize  = isTabletPortrait ? 260.0 : 200.0;
    final double imageSize   = isTabletPortrait ? 160.0 : 120.0;
    final double strokeWidth = isTabletPortrait ? 20.0  : 15.0;
    final double emojiSize   = isTabletPortrait ? 34.0  : 24.0;
    final double statFontSz  = isTabletPortrait ? 20.0  : 15.0;
    final double titleFontSz = isTabletPortrait ? 17.0  : 15.0;
    final double bravFontSz  = isTabletPortrait ? 21.0  : 17.0;
    final double statSpacing = isTabletPortrait ? 64.0  : 48.0;
    final double topSpacing  = isTabletPortrait ? 36.0  : 28.0;
    final double midSpacing  = isTabletPortrait ? 40.0  : 32.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            'Tes accomplissements et tes réussites',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: titleFontSz,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(height: topSpacing),

        Center(
          child: SizedBox(
            width: circleSize,
            height: circleSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: circleSize,
                  height: circleSize,
                  child: CircularProgressIndicator(
                    value: 0.65,
                    strokeWidth: strokeWidth,
                    strokeCap: StrokeCap.round,
                    backgroundColor: const Color(0xFFB2EBF2),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(_kCyan),
                  ),
                ),
                Image.asset(
                  'assets/images/image1.png',
                  width: imageSize,
                  height: imageSize,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: midSpacing),

        // Stats
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatItem('🏆', '5 Coupes',
                emojiSize: emojiSize, fontSize: statFontSz),
            SizedBox(width: statSpacing),
            _buildStatItem('🪙', '9 Coins',
                emojiSize: emojiSize, fontSize: statFontSz),
          ],
        ),
        SizedBox(height: midSpacing),

        Center(
          child: Text(
            'Bravo continue comme ça !',
            style: TextStyle(
              fontSize: bravFontSz,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFFCB317),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildStatItem(String emoji, String label,
      {double emojiSize = 24, double fontSize = 15}) {
    return Row(
      children: [
        Text(emoji, style: TextStyle(fontSize: emojiSize)),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

 
  Widget _buildDisponibles({bool isTablet = false, bool isLandscape = false}) {
    final List<Map<String, dynamic>> recompenses = [
      {'titre': 'récompense 1', 'categorie': 'jouet', 'coins': 4},
      {'titre': 'récompense 2', 'categorie': 'livre', 'coins': 6},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            'Boutique des récompenses',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 14),

       
        if (isTablet && isLandscape)
          _buildTwoColumnGrid(
            recompenses
                .map((r) => _RecompenseCard(
                      titre: r['titre'],
                      categorie: r['categorie'],
                      coins: r['coins'],
                      isTablet: true,
                    ))
                .toList(),
          )
        else
          Column(
            children: recompenses
                .map((r) => _RecompenseCard(
                      titre: r['titre'],
                      categorie: r['categorie'],
                      coins: r['coins'],
                      isTablet: false, 
                    ))
                .toList(),
          ),
      ],
    );
  }

 
  Widget _buildUtilisees({bool isTablet = false, bool isLandscape = false}) {
    final List<Map<String, dynamic>> utilisees = [
      {
        'titre': 'récompense 1',
        'categorie': 'plat spécial',
        'coins': 8,
        'date': '24/01/2026',
      },
      {
        'titre': 'récompense 2',
        'categorie': 'sortie',
        'coins': 10,
        'date': '10/02/2026',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            'Mes trophées',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Center(
          child: Text(
            'Bravo, tu as des récompenses !',
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ),
        const SizedBox(height: 14),

         if (isTablet && isLandscape)
          _buildTwoColumnGrid(
            utilisees
                .map((r) => _RecompenseUtiliseeCard(
                      titre: r['titre'],
                      categorie: r['categorie'],
                      coins: r['coins'],
                      date: r['date'],
                      isTablet: true,
                    ))
                .toList(),
          )
        else
          Column(
            children: utilisees
                .map((r) => _RecompenseUtiliseeCard(
                      titre: r['titre'],
                      categorie: r['categorie'],
                      coins: r['coins'],
                      date: r['date'],
                      isTablet: false, 
                    ))
                .toList(),
          ),
      ],
    );
  }

//paysage
  Widget _buildTwoColumnGrid(List<Widget> cards) {
    final rows = <Widget>[];
    for (var i = 0; i < cards.length; i += 2) {
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: cards[i]),
              const SizedBox(width: 12),
              if (i + 1 < cards.length)
                Expanded(child: cards[i + 1])
              else
                const Expanded(child: SizedBox()),
            ],
          ),
        ),
      );
    }
    return Column(children: rows);
  }
}

class _RecompenseCard extends StatelessWidget {
  final String titre;
  final String categorie;
  final int coins;
  final bool isTablet;

  const _RecompenseCard({
    required this.titre,
    required this.categorie,
    required this.coins,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFB2EBF2), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(14)),
            child: Image.asset(
              'assets/images/reward_illustration.png.png',
              width: double.infinity,
              height: isTablet ? 140 : 160,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titre,
                  style: TextStyle(
                    fontSize: isTablet ? 13 : 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _CategoryBadge(categorie),
                    _CoinsBadge(coins),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('✅ "$titre" choisie !'),
                          backgroundColor: _kCyan,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _kCyan,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Choisir Cette récompense',
                      style: TextStyle(
                        fontSize: isTablet ? 12 : 14,
                        fontWeight: FontWeight.bold,
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
}

class _RecompenseUtiliseeCard extends StatelessWidget {
  final String titre;
  final String categorie;
  final int coins;
  final String date;
  final bool isTablet;

  const _RecompenseUtiliseeCard({
    required this.titre,
    required this.categorie,
    required this.coins,
    required this.date,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFB2EBF2), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(14)),
            child: Image.asset(
              'assets/images/reward_illustration.png.png',
              width: double.infinity,
              height: isTablet ? 140 : 160,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titre,
                  style: TextStyle(
                    fontSize: isTablet ? 13 : 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _CategoryBadge(categorie),
                    _CoinsBadge(coins),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.check_circle_rounded,
                        color: Colors.white, size: 17),
                    label: Text(
                      'Utilisée le $date',
                      style: TextStyle(
                        fontSize: isTablet ? 12 : 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      disabledBackgroundColor: const Color(0xFF4CAF50),
                      disabledForegroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
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
}

class _CategoryBadge extends StatelessWidget {
  final String label;
  const _CategoryBadge(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFE1BEE7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Color(0xFF9C27B0),
        ),
      ),
    );
  }
}

class _CoinsBadge extends StatelessWidget {
  final int coins;
  const _CoinsBadge(this.coins);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFCB317), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$coins',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFCB317),
            ),
          ),
          const SizedBox(width: 3),
          const Text('🪙', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool fullWidth;

  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: fullWidth ? double.infinity : null,
        height: 52,
        alignment: Alignment.center,
        decoration: selected
            ? BoxDecoration(
                color: _kCyan,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _kCyan.withOpacity(0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              )
            : BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _kCyan, width: 1.8),
              ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: selected ? Colors.white : _kCyan,
          ),
        ),
      ),
    );
  }
}