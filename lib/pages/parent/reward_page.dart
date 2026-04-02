import 'package:flutter/material.dart';
import 'package:edidact_app/widgets/menu_barre.dart';
import 'package:edidact_app/pages/parent/reward_creation_page.dart';

const _kPurple    = Color(0xFF9C27B0);
const _kCyan      = Color(0xFF00BCD4);
const _kCyanLight = Color(0xFF26C6DA);

class Reward {
  final String name;
  final String category;
  final int coins;
  final String child;
  final bool used;

  const Reward({
    required this.name,
    required this.category,
    required this.coins,
    required this.child,
    required this.used,
  });
}

const List<Reward> _rewards = [
  Reward(name: 'récompense 1', category: 'jouet',           coins: 4, child: 'Pour enfant 2', used: false),
  Reward(name: 'récompense 2', category: 'journée au parc', coins: 6, child: 'Pour enfant 1', used: true),
];

class RewardPage extends StatelessWidget {
  const RewardPage({super.key});

  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  bool _isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  @override
  Widget build(BuildContext context) {
    final isTablet    = _isTablet(context);
    final isLandscape = _isLandscape(context);
    final double hPad = isTablet ? 28 : 16;

  
    final int cols = isLandscape ? 3 : (isTablet ? 2 : 1);

    return Scaffold(
      backgroundColor: Colors.white,
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
                child: Icon(
                  Icons.menu,
                  size: isTablet ? 40 : 34,
                  color: _kCyan,
                ),
              ),

              SizedBox(height: isTablet ? 22 : 16),

              _buildHeaderCard(isTablet),

              SizedBox(height: isTablet ? 18 : 12),

              
              Text(
                'Les récompenses',
                style: TextStyle(
                  fontSize: isTablet ? 22 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: isTablet ? 14 : 8),

              _buildAddButton(context, isTablet),

              SizedBox(height: isTablet ? 14 : 8),

              cols == 1
                  ? Column(
                      children: _rewards
                          .map((r) => _RewardCard(reward: r, isTablet: false))
                          .toList(),
                    )
                  : _buildGrid(_rewards, cols: cols, isTablet: isTablet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(
    List<Reward> rewards, {
    required int cols,
    required bool isTablet,
  }) {
    final rows = <Widget>[];
    for (int i = 0; i < rewards.length; i += cols) {
      final rowItems = rewards.sublist(i, (i + cols).clamp(0, rewards.length));
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
                    ? _RewardCard(reward: rowItems[j], isTablet: isTablet)
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
          Text('🏆', style: TextStyle(fontSize: isTablet ? 40 : 32)),
          SizedBox(width: isTablet ? 18 : 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Catalogue de récompenses',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 19 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: isTablet ? 10 : 8),
                Text(
                  'Créez et gérez les récompenses pour motiver vos enfants',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isTablet ? 14 : 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context, bool isTablet) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          barrierColor: Colors.black45,
          builder: (_) => const RewardCreationPage(),
        );
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: isTablet ? 6 : 8),
        padding: EdgeInsets.symmetric(vertical: isTablet ? 15 : 12),
        decoration: BoxDecoration(
          color: _kCyanLight,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.white, size: isTablet ? 24 : 20),
            SizedBox(width: isTablet ? 10 : 8),
            Text(
              'ajouter récompense',
              style: TextStyle(
                color: Colors.white,
                fontSize: isTablet ? 17 : 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  final Reward reward;
  final bool isTablet;
  const _RewardCard({required this.reward, this.isTablet = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isTablet ? EdgeInsets.zero : const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFECFAFD),
        borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
        border: Border.all(color: const Color(0xFF4DD0E1), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4DD0E1).withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  'assets/images/reward_illustration.png.png',
                  height: isTablet ? 160 : 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: isTablet ? 160 : 140,
                    width: double.infinity,
                    color: _kCyan,
                    child: Icon(
                      Icons.image_not_supported,
                      size: isTablet ? 70 : 60,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8, right: 8,
                child: GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.more_vert, color: Colors.white, size: 20),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(isTablet ? 16 : 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reward.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isTablet ? 16 : 14,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: isTablet ? 10 : 8),
                Row(
                  children: [
                    _CategoryChip(label: reward.category, isTablet: isTablet),
                    const Spacer(),
                    _CoinsChip(count: reward.coins, isTablet: isTablet),
                  ],
                ),
                SizedBox(height: isTablet ? 10 : 8),
                _InfoRow(
                  icon:      Icons.person_outline,
                  iconColor: _kCyan,
                  label:     reward.child,
                  bgColor:   const Color(0xFFB2EBF2),
                  isTablet:  isTablet,
                ),
                SizedBox(height: isTablet ? 8 : 6),
                _StatusRow(used: reward.used, isTablet: isTablet),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isTablet;
  const _CategoryChip({required this.label, this.isTablet = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 14 : 10,
        vertical:   isTablet ? 6  : 4,
      ),
      decoration: BoxDecoration(
        color: _kPurple,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: isTablet ? 13 : 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _CoinsChip extends StatelessWidget {
  final int count;
  final bool isTablet;
  const _CoinsChip({required this.count, this.isTablet = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 14 : 10,
        vertical:   isTablet ? 6  : 4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9C4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFDD835), width: 1),
      ),
      child: Row(
        children: [
          Text(
            '$count',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isTablet ? 14 : 13,
              color: Colors.black87,
            ),
          ),
          SizedBox(width: isTablet ? 6 : 4),
          Icon(Icons.monetization_on,
              color: const Color(0xFFFDD835),
              size: isTablet ? 18 : 16),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final Color    iconColor;
  final String   label;
  final Color    bgColor;
  final bool     isTablet;

  const _InfoRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.bgColor,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 12 : 10,
        vertical:   isTablet ? 8  : 6,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: isTablet ? 18 : 16),
          SizedBox(width: isTablet ? 8 : 6),
          Text(
            label,
            style: TextStyle(
              fontSize: isTablet ? 14 : 13,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  final bool used;
  final bool isTablet;
  const _StatusRow({required this.used, this.isTablet = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 12 : 10,
        vertical:   isTablet ? 8  : 6,
      ),
      decoration: BoxDecoration(
        color: used ? const Color(0xFFF1F8E9) : const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            used ? Icons.check_circle_outline : Icons.cancel_outlined,
            color: used ? Colors.green : Colors.orange,
            size: isTablet ? 18 : 16,
          ),
          SizedBox(width: isTablet ? 8 : 6),
          Text(
            'Statut : ',
            style: TextStyle(
              fontSize: isTablet ? 14 : 13,
              color: Colors.grey[700],
            ),
          ),
          Text(
            used ? 'utilisée' : 'non utilisée',
            style: TextStyle(
              fontSize: isTablet ? 14 : 13,
              fontWeight: FontWeight.bold,
              color: used ? Colors.green : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}