import 'package:flutter/material.dart';
import 'package:edidact_app/widgets/menu_barre_enfant.dart';

const _kPurple = Color(0xFF9C27B0);
const _kCyan   = Color(0xFF00BCD4);
const _kOrange = Color(0xFFFFA726);
const _kCyanBg = Color(0xFFB2EBF2);

class ResultatsPage extends StatefulWidget {
  const ResultatsPage({super.key});
  @override
  State<ResultatsPage> createState() => _ResultatsPageState();
}

class _ResultatsPageState extends State<ResultatsPage> {
  final Map<String, dynamic> _child = {
    'name': 'Enfant 1',
    'coins': 10,
    'progression': 50,
    'coupes': 15,
    'matieres': 6,
    'subjects': [
      {'name': 'Français',         'progression': 0.10, 'coins': 0, 'or': 0, 'argent': 0, 'bronze': 0},
      {'name': 'Science',          'progression': 0.40, 'coins': 4, 'or': 4, 'argent': 0, 'bronze': 0},
      {'name': 'Anglais',          'progression': 0.70, 'coins': 2, 'or': 2, 'argent': 1, 'bronze': 0},
      {'name': 'Maths',            'progression': 0.55, 'coins': 1, 'or': 1, 'argent': 3, 'bronze': 1},
      {'name': 'Culture Générale', 'progression': 0.30, 'coins': 0, 'or': 0, 'argent': 1, 'bronze': 2},
      {'name': 'Allemand',         'progression': 0.20, 'coins': 0, 'or': 0, 'argent': 0, 'bronze': 1},
    ],
  };

  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            final isLandscape = orientation == Orientation.landscape;
            final isTablet    = _isTablet(context);
            if (isTablet && isLandscape) {
              return _buildLandscapeLayout(context);
            } else {
              return _buildPortraitLayout(context, isTablet: isTablet);
            }
          },
        ),
      ),
    );
  }

  
  Widget _buildPortraitLayout(BuildContext context, {required bool isTablet}) {
    // Tablette portrait → un peu plus grand que mobile, même structure colonne simple
    final double titleSize   = isTablet ? 20 : 17;
    final double bodySize    = isTablet ? 15 : 13;
    final double avatarR     = isTablet ? 34 : 30;
    final double hPad        = isTablet ? 20 : 16;
    final double cardRadius  = isTablet ? 16 : 14;
    final double spacing     = isTablet ? 22 : 18;

    final subjects = _child['subjects'] as List<Map<String, dynamic>>;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _openMenu(context),
            child: Icon(Icons.menu, size: isTablet ? 37 : 34, color: _kCyan),
          ),
          SizedBox(height: spacing),

          _headerCard(
            avatarRadius: avatarR,
            cardRadius: cardRadius,
            bodySize: bodySize,
          ),
          SizedBox(height: spacing),

          Text(
            'Mes résultats totaux',
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: isTablet ? 12 : 10),

          _summaryBoxPortrait(bodySize: bodySize, cardRadius: cardRadius, isTablet: isTablet),
          SizedBox(height: spacing - 4),

          Text(
            'Détails par matière',
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: isTablet ? 14 : 12),

          Column(
            children: subjects
                .map((s) => _subjectCard(s, isTablet: isTablet))
                .toList(),
          ),
        ],
      ),
    );
  }

 //tablet
  Widget _buildLandscapeLayout(BuildContext context) {
    final subjects = _child['subjects'] as List<Map<String, dynamic>>;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _openMenu(context),
            child: const Icon(Icons.menu, size: 36, color: _kCyan),
          ),
          const SizedBox(height: 14),
          _headerCard(avatarRadius: 34, cardRadius: 18, bodySize: 15),
          const SizedBox(height: 18),
          const Text(
            'Mes résultats totaux',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: _kCyanBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _summaryCol('🪙', '${_child['coins']}',        'coins totaux'),
                _dividerV(),
                _summaryCol('📈', '${_child['progression']}%', 'progression moyenne'),
                _dividerV(),
                _summaryCol('🏆', '${_child['coupes']}',       'coupes gagnées'),
                _dividerV(),
                _summaryCol('📚', '${_child['matieres']}',     'matières étudiées'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Détails par matière',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 14),

          // Grille 2 colonnes
          _buildSubjectsGrid2Col(subjects),
        ],
      ),
    );
  }

 //paysage
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

 
  void _openMenu(BuildContext context) => Navigator.push(
        context,
        PageRouteBuilder(
          opaque: false,
          barrierColor: Colors.black45,
          pageBuilder: (_, __, ___) => const MenuBarreEnfant(),
        ),
      );

  Widget _headerCard({
    required double avatarRadius,
    required double cardRadius,
    required double bodySize,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: _kPurple,
        borderRadius: BorderRadius.circular(cardRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: avatarRadius,
            backgroundColor: Colors.white.withOpacity(0.3),
            child: Icon(Icons.person, color: Colors.white, size: avatarRadius),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bonjour ${_child['name']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: bodySize + 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Vérifiez votre progression',
                  style: TextStyle(color: Colors.white70, fontSize: bodySize - 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryBoxPortrait({
    required double bodySize,
    required double cardRadius,
    required bool isTablet,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 18 : 14,
        vertical:   isTablet ? 14 : 10,
      ),
      decoration: BoxDecoration(
        color: _kCyanBg,
        borderRadius: BorderRadius.circular(cardRadius),
      ),
      child: Column(
        children: [
          _summaryRow('🪙', '${_child['coins']}',        'coins totaux',        bodySize, isTablet),
          SizedBox(height: isTablet ? 10 : 6),
          _summaryRow('📈', '${_child['progression']}%', 'progression moyenne', bodySize, isTablet),
          SizedBox(height: isTablet ? 10 : 6),
          _summaryRow('🏆', '${_child['coupes']}',       'coupes gagnées',      bodySize, isTablet),
          SizedBox(height: isTablet ? 10 : 6),
          _summaryRow('📚', '${_child['matieres']}',     'matières étudiées',   bodySize, isTablet),
        ],
      ),
    );
  }

  Widget _summaryRow(
      String emoji, String value, String label, double fontSize, bool isTablet) {
    return Row(
      children: [
        SizedBox(
          width: isTablet ? 32 : 28,
          child: Text(emoji, style: TextStyle(fontSize: fontSize + 4)),
        ),
        SizedBox(width: isTablet ? 14 : 12),
        SizedBox(
          width: isTablet ? 56 : 52,
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(width: isTablet ? 14 : 12),
        Text(
          label,
          style: TextStyle(fontSize: fontSize - 1, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _summaryCol(String emoji, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87)),
        const SizedBox(height: 2),
        Text(label,
            style: const TextStyle(fontSize: 11, color: Colors.black54)),
      ],
    );
  }

  Widget _dividerV() =>
      Container(width: 1, height: 48, color: Colors.black12);

  Widget _subjectCard(Map<String, dynamic> subject, {required bool isTablet}) {
    final double prog = subject['progression'];
    final int pct     = (prog * 100).round();

    return Container(
      // Margin bottom : tablette portrait légèrement plus que mobile
      margin: EdgeInsets.only(bottom: isTablet ? 18 : 14),
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
              Expanded(
                child: Text(
                  subject['name'],
                  style: TextStyle(
                    fontSize: isTablet ? 17 : 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
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
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFFFFA726)),
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
                child: _trophy(subject['or'] ?? 0,     'Or',
                    const Color(0xFFFFD700), isTablet: isTablet),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _trophy(subject['argent'] ?? 0, 'Argent',
                    const Color(0xFFB0BEC5), isTablet: isTablet),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _trophy(subject['bronze'] ?? 0, 'Bronze',
                    const Color(0xFFCD7F32), isTablet: isTablet),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _trophy(int count, String label, Color color,
      {bool isTablet = false}) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical:   isTablet ? 10 : 8,
        horizontal: 6,
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