import 'package:flutter/material.dart';
import 'package:edidact_app/pages/enfant/enfant_ex.dart';
import 'package:edidact_app/pages/enfant/resultats.dart';
import 'package:edidact_app/pages/enfant/mes_recompenses.dart';
import 'package:edidact_app/pages/parent/home_page.dart';

const double _kTabletBreakpoint = 600;

class MenuBarreEnfant extends StatelessWidget {
  const MenuBarreEnfant({super.key});

  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= _kTabletBreakpoint;

  bool _isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  @override
  Widget build(BuildContext context) {
    final isTablet = _isTablet(context);
    final isLandscape = _isLandscape(context);

    double menuWidth;
    if (isTablet && isLandscape) {
      menuWidth = 300;
    } else if (isTablet) {
      menuWidth = 270;
    } else {
      menuWidth = 230;
    }

    
    final double logoSize    = isTablet ? 78 : 65;
    final double titleSize   = isTablet ? 21 : 18;

    final double iconSize = isTablet && !isLandscape ? 30 : (isTablet ? 28 : 24);
    final double labelSize = isTablet && !isLandscape ? 20 : (isTablet ? 18 : 16);

    final double itemVPad    = isTablet ? 26 : 22;
    final double itemHPad    = isTablet ? 30 : 24;
    final double topSpacing  = isTablet ? 28 : 20;
    final double menuSpacing = isTablet ? 56 : 48;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          Container(
            width: menuWidth,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF00BCD4),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: topSpacing),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: itemHPad),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/image1.png',
                          width: logoSize,
                          height: logoSize,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'EDIDACT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: titleSize,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: menuSpacing),

                  _menuItem(
                    context: context,
                    icon: Icons.menu_book_rounded,
                    label: 'Exercices',
                    iconSize: iconSize,
                    labelSize: labelSize,
                    vPad: itemVPad,
                    hPad: itemHPad,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
MaterialPageRoute(builder: (_) => EnfantExPage()),
                      );
                    },
                  ),
                  _menuItem(
                    context: context,
                    icon: Icons.assignment_rounded,
                    label: 'Examens',
                    iconSize: iconSize,
                    labelSize: labelSize,
                    vPad: itemVPad,
                    hPad: itemHPad,
                    onTap: () => Navigator.pop(context),
                  ),
                  _menuItem(
                    context: context,
                    icon: Icons.bar_chart_rounded,
                    label: 'Résultats',
                    iconSize: iconSize,
                    labelSize: labelSize,
                    vPad: itemVPad,
                    hPad: itemHPad,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ResultatsPage()),
                      );
                    },
                  ),
                  _menuItem(
                    context: context,
                    icon: Icons.emoji_events_outlined,
                    label: 'Récompenses',
                    iconSize: iconSize,
                    labelSize: labelSize,
                    vPad: itemVPad,
                    hPad: itemHPad,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MesRecompensePage()),
                      );
                    },
                  ),

                  const Spacer(),

                  _menuItem(
                    context: context,
                    icon: Icons.logout,
                    label: 'Déconnexion',
                    iconSize: iconSize,
                    labelSize: labelSize,
                    vPad: itemVPad,
                    hPad: itemHPad,
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                        (route) => false,
                      );
                    },
                  ),

                  SizedBox(height: isTablet ? 32 : 24),
                ],
              ),
            ),
          ),

          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(color: Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required double iconSize,
    required double labelSize,
    required double vPad,
    required double hPad,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white24,
      highlightColor: Colors.white10,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: iconSize),
            const SizedBox(width: 18), 
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: labelSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}