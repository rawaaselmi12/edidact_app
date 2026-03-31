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

  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  bool _isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  @override
  Widget build(BuildContext context) {
    final child      = _children[_selectedChild];
    final isTablet   = _isTablet(context);
    final isLandscape = _isLandscape(context);
    final double hPad = isTablet ? 28 : 16;

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
                  color: const Color(0xFF00BCD4),
                ),
              ),

              SizedBox(height: isTablet ? 22 : 18),

              _buildHeaderCard(isTablet),

              SizedBox(height: isTablet ? 20 : 16),

              _buildChildSelector(isTablet),

              SizedBox(height: isTablet ? 26 : 22),

              Text(
                'Résumé pour enfant',
                style: TextStyle(
                  fontSize: isTablet ? 19 : 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: isTablet ? 14 : 10),

              
              isTablet && isLandscape
                  ? _buildSummaryRow4(child)
                  : isTablet
                      ? _buildSummaryGrid2x2(child)
                      : _buildSummaryCardMobile(child),

              SizedBox(height: isTablet ? 20 : 16),

              Text(
                'Détails pour matière',
                style: TextStyle(
                  fontSize: isTablet ? 19 : 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: isTablet ? 14 : 12),

              isTablet
                  ? _buildSubjectsGrid2Col(
                      child['subjects'] as List<Map<String, dynamic>>,
                    )
                  : Column(
                      children: (child['subjects'] as List<Map<String, dynamic>>)
                          .map((s) => _subjectCard(s, isTablet: false))
                          .toList(),
                    ),
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
        horizontal: isTablet ? 26 : 20,
        vertical:   isTablet ? 24 : 20,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF9C27B0),
        borderRadius: BorderRadius.circular(isTablet ? 22 : 18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('📊', style: TextStyle(fontSize: isTablet ? 40 : 32)),
          SizedBox(width: isTablet ? 18 : 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Statistiques de mes enfants',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 19 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: isTablet ? 10 : 8),
                Text(
                  'Suivez les progrès et les réussites de vos enfants pour toutes les matières',
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

  Widget _buildChildSelector(bool isTablet) {
    return Row(
      children: List.generate(_children.length, (index) {
        final isSelected = _selectedChild == index;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedChild = index),
            child: Container(
              margin: EdgeInsets.only(right: index == 0 ? (isTablet ? 12 : 8) : 0),
              padding: EdgeInsets.symmetric(vertical: isTablet ? 13 : 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF00BCD4) : Colors.white,
                borderRadius: BorderRadius.circular(isTablet ? 12 : 10),
                border: Border.all(color: const Color(0xFF00BCD4), width: 1.5),
              ),
              alignment: Alignment.center,
              child: Text(
                _children[index]['name'],
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF00BCD4),
                  fontWeight: FontWeight.w600,
                  fontSize: isTablet ? 16 : 15,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSummaryCardMobile(Map<String, dynamic> child) {
    return Container(
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
          _summaryRow('📈', '${child['progression']}%', 'progression moyenne'),
          const SizedBox(height: 6),
          _summaryRow('🏆', '${child['coupes']}', 'coupes gagnées'),
          const SizedBox(height: 6),
          _summaryRow('📚', '${child['matieres']}', 'matières étudiées'),
        ],
      ),
    );
  }

//portrait
  Widget _buildSummaryGrid2x2(Map<String, dynamic> child) {
    final stats = [
      {'emoji': '🪙', 'value': '${child['coins']}',          'label': 'coins totaux'},
      {'emoji': '📈', 'value': '${child['progression']}%',   'label': 'progression moyenne'},
      {'emoji': '🏆', 'value': '${child['coupes']}',         'label': 'coupes gagnées'},
      {'emoji': '📚', 'value': '${child['matieres']}',       'label': 'matières étudiées'},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFB2EBF2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _summaryTile(stats[0])),
              const SizedBox(width: 12),
              Expanded(child: _summaryTile(stats[1])),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _summaryTile(stats[2])),
              const SizedBox(width: 12),
              Expanded(child: _summaryTile(stats[3])),
            ],
          ),
        ],
      ),
    );
  }

//paysage 
  Widget _buildSummaryRow4(Map<String, dynamic> child) {
    final stats = [
      {'emoji': '🪙', 'value': '${child['coins']}',          'label': 'coins totaux'},
      {'emoji': '📈', 'value': '${child['progression']}%',   'label': 'progression moyenne'},
      {'emoji': '🏆', 'value': '${child['coupes']}',         'label': 'coupes gagnées'},
      {'emoji': '📚', 'value': '${child['matieres']}',       'label': 'matières étudiées'},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFB2EBF2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: stats.map((s) {
          return Expanded(
            child: _summaryTile(s),
          );
        }).toList(),
      ),
    );
  }

  Widget _summaryTile(Map<String, String> stat) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(stat['emoji']!, style: const TextStyle(fontSize: 22)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stat['value']!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                stat['label']!,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubjectsGrid2Col(List<Map<String, dynamic>> subjects) {
    final rows = <Widget>[];
    for (int i = 0; i < subjects.length; i += 2) {
      final left  = subjects[i];
      final right = i + 1 < subjects.length ? subjects[i + 1] : null;
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 14),
                child: _subjectCard(left, isTablet: true),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 14),
                child: right != null
                    ? _subjectCard(right, isTablet: true)
                    : const SizedBox(),
              ),
            ),
          ],
        ),
      );
    }
    return Column(children: rows);
  }

//mobile
  Widget _summaryRow(String emoji, String value, String label) {
    return Row(
      children: [
        SizedBox(width: 28, child: Text(emoji, style: const TextStyle(fontSize: 17))),
        const SizedBox(width: 12),
        SizedBox(
          width: 46,
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }

  Widget _subjectCard(Map<String, dynamic> subject, {required bool isTablet}) {
    final double prog = subject['progression'];
    final int pct = (prog * 100).round();

    return Container(
      margin: isTablet ? EdgeInsets.zero : const EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(isTablet ? 16 : 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isTablet ? 16 : 14),
        border: Border.all(color: const Color(0xFFFFCC80), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subject['name'],
                style: TextStyle(
                  fontSize: isTablet ? 17 : 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$pct%',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFA726),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: isTablet ? 10 : 8),

          Text(
            'Progression',
            style: TextStyle(
              fontSize: isTablet ? 13 : 12,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: prog,
              minHeight: isTablet ? 9 : 8,
              backgroundColor: const Color(0xFFE0E0E0),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFA726)),
            ),
          ),

          SizedBox(height: isTablet ? 14 : 12),

          Text(
            'Réussite',
            style: TextStyle(
              fontSize: isTablet ? 13 : 12,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: isTablet ? 10 : 8),
          Row(
            children: [
              Expanded(
                child: _trophy(subject['or'],     'Or',     const Color(0xFFFFD700), isTablet: isTablet),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _trophy(subject['argent'], 'Argent', const Color(0xFFB0BEC5), isTablet: isTablet),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _trophy(subject['bronze'], 'Bronze', const Color(0xFFCD7F32), isTablet: isTablet),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _trophy(int count, String label, Color color, {bool isTablet = false}) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical:   isTablet ? 10 : 8,
        horizontal: isTablet ? 6  : 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isTablet ? 12 : 10),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.emoji_events, color: color, size: isTablet ? 32 : 28),
          SizedBox(height: isTablet ? 5 : 4),
          Text(
            '$count\n$label',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isTablet ? 12 : 11,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}