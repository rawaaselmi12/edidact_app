import 'package:flutter/material.dart';
import 'package:edidact_app/widgets/menu_barre.dart';
import 'package:edidact_app/pages/reward_creation_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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

              // ── Header card standard ───────────────────────────────
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
                            'Catalogue de récompenses',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Créez et gérez les récompenses pour\nmotiver vos enfants',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
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
                    builder: (_) => const RewardCreationPage(),
                  );
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _kCyanLight,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text('ajouter récompense',
                          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Les récompenses',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),

              const SizedBox(height: 8),

              ..._rewards.map((r) => _RewardCard(reward: r)),
            ],
          ),
        ),
      ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  final Reward reward;
  const _RewardCard({required this.reward});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
color: const Color(0xFFECFAFD),        
borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  color: _kCyan,
                  child: const _RewardIllustration(),
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
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reward.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _CategoryChip(label: reward.category),
                    const Spacer(),
                    _CoinsChip(count: reward.coins),
                  ],
                ),
                const SizedBox(height: 8),
                _InfoRow(
  icon: Icons.person_outline,
  iconColor: _kCyan,
  label: reward.child,
  bgColor: const Color(0xFFB2EBF2),
),
                const SizedBox(height: 6),
                _StatusRow(used: reward.used),
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
  const _CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: _kPurple.withOpacity(0.5), borderRadius: BorderRadius.circular(20)),
      child: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
    );
  }
}

class _CoinsChip extends StatelessWidget {
  final int count;
  const _CoinsChip({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9C4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFDD835), width: 1),
      ),
      child: Row(
        children: [
          Text('$count',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
          const SizedBox(width: 4),
          const Icon(Icons.monetization_on, color: Color(0xFFFDD835), size: 16),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final Color bgColor;
  const _InfoRow({required this.icon, required this.iconColor,
      required this.label, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 16),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.black87)),
        ],
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  final bool used;
  const _StatusRow({required this.used});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: used ? const Color(0xFFF1F8E9) : const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            used ? Icons.check_circle_outline : Icons.cancel_outlined,
            color: used ? Colors.green : Colors.orange, size: 16,
          ),
          const SizedBox(width: 6),
          Text('Statut : ', style: TextStyle(fontSize: 13, color: Colors.grey[700])),
          Text(
            used ? 'utilisée' : 'non utilisée',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,
                color: used ? Colors.green : Colors.orange),
          ),
        ],
      ),
    );
  }
}

class _RewardIllustration extends StatelessWidget {
  const _RewardIllustration();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          right: 40, top: 20,
          child: Container(
            width: 100, height: 100,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15), shape: BoxShape.circle),
          ),
        ),
        const Positioned(
          left: 30, bottom: 10,
          child: Icon(Icons.emoji_events, color: Color(0xFFFDD835), size: 54),
        ),
        ...List.generate(6, (i) => Positioned(
          top: 10.0 + (i * 18) % 100,
          left: 10.0 + (i * 25) % 80,
          child: Container(
            width: 6, height: 6,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4), shape: BoxShape.circle),
          ),
        )),
      ],
    );
  }
}