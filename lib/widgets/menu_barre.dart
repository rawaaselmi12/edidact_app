import 'package:flutter/material.dart';
import 'package:edidact_app/pages/parent/home_page.dart';
import 'package:edidact_app/pages/parent/reward_page.dart';
import 'package:edidact_app/pages/parent/mes_enfants_page.dart';
import 'package:edidact_app/pages/parent/historique.dart';
import 'package:edidact_app/pages/parent/profile.dart';

class MenuBarre extends StatelessWidget {
  const MenuBarre({super.key});

  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 520;

  bool _isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  @override
  Widget build(BuildContext context) {
    final isTablet    = _isTablet(context);
    final isLandscape = _isLandscape(context);

    final double drawerWidth = isTablet
        ? (isLandscape ? 320 : 360)
        : 260;

    final double logoSize = isTablet
        ? (isLandscape ? 78 : 108)
        : (isLandscape ? 65 : 72);

    final double titleFontSize = isTablet
        ? (isLandscape ? 21 : 21)
        : (isLandscape ? 18 : 18);

    final double iconSize = isTablet
        ? (isLandscape ? 28 : 28)
        : (isLandscape ? 24 : 24);

    final double itemFontSize = isTablet
        ? (isLandscape ? 19 : 19)
        : (isLandscape ? 19 : 19);

    final double hPad = isTablet
        ? (isLandscape ? 30 : 38)
        : (isLandscape ? 24 : 27);

    final double vPad = isTablet
        ? (isLandscape ? 24 : 32)
        : (isLandscape ? 22 : 25);

    final double topSpacing = isTablet
        ? (isLandscape ? 32 : 48)
        : (isLandscape ? 20 : 24);

    final double logoSpacing = isTablet
        ? (isLandscape ? 60 : 80)
        : (isLandscape ? 48 : 54);

    final double bottomSpacing = isTablet
        ? (isLandscape ? 32 : 48)
        : (isLandscape ? 24 : 28);

    final double iconLabelGap = isTablet
        ? (isLandscape ? 19 : 19)
        : (isLandscape ? 19 : 19);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          Container(
            width: drawerWidth,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF00BCD4),
              borderRadius: BorderRadius.only(
                topRight:    Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: topSpacing),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/image1.png',
                          width:  logoSize,
                          height: logoSize,
                        ),
                        SizedBox(width: isTablet ? 16 : 10),
                        Text(
                          'EDIDACT',
                          style: TextStyle(
                            color:         Colors.white,
                            fontSize:      titleFontSize,
                            fontWeight:    FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: logoSpacing),
                  

                  _item(
                    icon:         Icons.bar_chart_rounded,
                    label:        'Progression',
                    iconSize:     iconSize,
                    fontSize:     itemFontSize,
                    hPad:         hPad,
                    vPad:         vPad,
                    iconLabelGap: iconLabelGap,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const HomePage()));
                    },
                  ),
                  _item(
                    icon:         Icons.description_outlined,
                    label:        'Examens',
                    iconSize:     iconSize,
                    fontSize:     itemFontSize,
                    hPad:         hPad,
                    vPad:         vPad,
                    iconLabelGap: iconLabelGap,
                    onTap: () => Navigator.pop(context),
                  ),
                  _item(
                    icon:         Icons.emoji_events_outlined,
                    label:        'Récompenses',
                    iconSize:     iconSize,
                    fontSize:     itemFontSize,
                    hPad:         hPad,
                    vPad:         vPad,
                    iconLabelGap: iconLabelGap,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const RewardPage()));
                    },
                  ),
                  _item(
                    icon:         Icons.supervised_user_circle_outlined,
                    label:        'Mes enfants',
                    iconSize:     iconSize,
                    fontSize:     itemFontSize,
                    hPad:         hPad,
                    vPad:         vPad,
                    iconLabelGap: iconLabelGap,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const MesEnfantsPage()));
                    },
                  ),
                  _item(
                    icon:         Icons.history_outlined,
                    label:        'Historique',
                    iconSize:     iconSize,
                    fontSize:     itemFontSize,
                    hPad:         hPad,
                    vPad:         vPad,
                    iconLabelGap: iconLabelGap,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const HistoriquePage()));
                    },
                  ),

                  const Spacer(),

                  _item(
                    icon:         Icons.person_outline,
                    label:        'Profile',
                    iconSize:     iconSize,
                    fontSize:     itemFontSize,
                    hPad:         hPad,
                    vPad:         vPad,
                    iconLabelGap: iconLabelGap,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ProfilePage()));
                    },
                  ),
                  _item(
                    icon:         Icons.logout,
                    label:        'Déconnexion',
                    iconSize:     iconSize,
                    fontSize:     itemFontSize,
                    hPad:         hPad,
                    vPad:         vPad,
                    iconLabelGap: iconLabelGap,
                    onTap: () => Navigator.pop(context),
                  ),

                  SizedBox(height: bottomSpacing),
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

  Widget _item({
    required IconData      icon,
    required String        label,
    required VoidCallback  onTap,
    required double        iconSize,
    required double        fontSize,
    required double        hPad,
    required double        vPad,
    required double        iconLabelGap,
  }) {
    return InkWell(
      onTap:           onTap,
      splashColor:     Colors.white24,
      highlightColor:  Colors.white10,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: iconSize),
            SizedBox(width: iconLabelGap),
            Text(
              label,
              style: TextStyle(
                color:      Colors.white,
                fontSize:   fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}