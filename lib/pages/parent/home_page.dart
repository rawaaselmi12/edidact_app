import 'package:flutter/material.dart';
import 'package:edidact_app/widgets/menu_barre.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedChild = 0;

  final List<Map<String, dynamic>> _children = [
    {
      'name': 'enfant 1',
      'coins': 10,
      'progression': 50,
      'coupes': 15,
      'matieres': 6,
      'subjects': [
        {'name': 'Français', 'progression': 0.10, 'or': 0, 'argent': 0, 'bronze': 0},
        {'name': 'Science', 'progression': 0.40, 'or': 4, 'argent': 0, 'bronze': 0},
        {'name': 'Anglais', 'progression': 0.70, 'or': 2, 'argent': 1, 'bronze': 0},
        {'name': 'Maths', 'progression': 0.55, 'or': 1, 'argent': 3, 'bronze': 1},
        {'name': 'Culture Générale', 'progression': 0.30, 'or': 0, 'argent': 1, 'bronze': 2},
        {'name': 'Allemand', 'progression': 0.20, 'or': 0, 'argent': 0, 'bronze': 1},
      ],
    },
    {
      'name': 'enfant 2',
      'coins': 8,
      'progression': 35,
      'coupes': 6,
      'matieres': 6,
      'subjects': [
        {'name': 'Maths', 'progression': 0.60, 'or': 1, 'argent': 2, 'bronze': 1},
        {'name': 'Science', 'progression': 0.25, 'or': 0, 'argent': 1, 'bronze': 2},
        {'name': 'Anglais', 'progression': 0.45, 'or': 0, 'argent': 2, 'bronze': 1},
        {'name': 'Français', 'progression': 0.35, 'or': 0, 'argent': 0, 'bronze': 3},
        {'name': 'Culture Générale', 'progression': 0.50, 'or': 1, 'argent': 1, 'bronze': 0},
        {'name': 'Allemand', 'progression': 0.15, 'or': 0, 'argent': 0, 'bronze': 0},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final child = _children[_selectedChild];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Menu icon 
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    opaque: false,
                    barrierColor: Colors.black45,
                    pageBuilder: (_, __, ___) => const MenuBarre(),
                  ),
                ),
                child: const Icon(Icons.menu, size: 34, color: Color(0xFF00BCD4)),
              ),

              const SizedBox(height: 18),

              //card purple
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF9C27B0),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text('📊', style: TextStyle(fontSize: 32)),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Statistiques de mes enfants',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Suivez les progrès et les réussites de vos enfants pour toutes les matières',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              
              Row(
                children: List.generate(_children.length, (index) {
                  final isSelected = _selectedChild == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedChild = index),
                      child: Container(
                        margin: EdgeInsets.only(right: index == 0 ? 8 : 0),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF00BCD4) : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF00BCD4), width: 1.5),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _children[index]['name'],
                          style: TextStyle(
                            color: isSelected ? Colors.white : const Color(0xFF00BCD4),
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

              const Text(
                'Résumé pour enfant',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
              ),

              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFB2EBF2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    _summaryRow('🪙', '${child['coins']}', 'coins totaux'),
                    const SizedBox(height: 6),
                    _summaryRow('🏆', '${child['progression']}%', 'progression moyenne'),
                    const SizedBox(height: 6),
                    _summaryRow('🥇', '${child['coupes']}', 'coupes gagnées'),
                    const SizedBox(height: 6),
                    _summaryRow('📚', '${child['matieres']}', 'matières étudiées'),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Détails pour matière',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
              ),

              const SizedBox(height: 12),

              ...(child['subjects'] as List<Map<String, dynamic>>).map((s) => _subjectCard(s)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryRow(String emoji, String value, String label) {
    return Row(
      children: [
        SizedBox(width: 28, child: Text(emoji, style: const TextStyle(fontSize: 17))),
        const SizedBox(width: 12),
        SizedBox(
          width: 46,
          child: Text(value,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
        ),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }

  Widget _subjectCard(Map<String, dynamic> subject) {
    final double prog = subject['progression'];
    final int pct = (prog * 100).round();

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFFCC80), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subject['name'],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Progression', style: TextStyle(fontSize: 13, color: Colors.black54)),
              const Spacer(),
              Text('$pct%',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: prog,
              minHeight: 8,
              backgroundColor: const Color(0xFFE0E0E0),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFA726)),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Réussite', style: TextStyle(fontSize: 13, color: Colors.black54)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _trophy(subject['or'], 'Or', const Color(0xFFFFD700))),
              const SizedBox(width: 8),
              Expanded(child: _trophy(subject['argent'], 'Argent', const Color(0xFFB0BEC5))),
              const SizedBox(width: 8),
              Expanded(child: _trophy(subject['bronze'], 'Bronze', const Color(0xFFCD7F32))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _trophy(int count, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.emoji_events, color: color, size: 28),
          const SizedBox(height: 4),
          Text('$count $label',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}