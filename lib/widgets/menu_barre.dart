import 'package:flutter/material.dart';
import 'package:edidact_app/pages/parent/home_page.dart';
import 'package:edidact_app/pages/parent/reward_page.dart';
import 'package:edidact_app/pages/parent/mes_enfants_page.dart';
import 'package:edidact_app/pages/parent/historique.dart';
import 'package:edidact_app/pages/parent/profile.dart';

class MenuBarre extends StatelessWidget {
  const MenuBarre({super.key});

  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  bool _isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  @override
  Widget build(BuildContext context) {
    final isTablet    = _isTablet(context);
    final isLandscape = _isLandscape(context);

    // mobile 230, tablet portrait 290, tablet paysage 320
    final double drawerWidth = isTablet
        ? (isLandscape ? 320 : 290)
        : 230;

    // Tailles adaptatives
    final double logoSize      = isTablet ? 78  : 65;
    final double titleFontSize = isTablet ? 21  : 18;
    final double iconSize      = isTablet ? 28  : 24;
    final double itemFontSize  = isTablet ? 18  : 16;
    final double hPad          = isTablet ? 30  : 24;
    final double vPad          = isTablet ? 24  : 22;
    final double topSpacing    = isTablet ? 32  : 20;
    final double logoSpacing   = isTablet ? 60  : 48;
    final double bottomSpacing = isTablet ? 32  : 24;
    final double iconLabelGap  = isTablet ? 18  : 16;

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
                        SizedBox(width: isTablet ? 14 : 10),
                        Text(
                          'EDIDACT',
                          style: TextStyle(
                            color:       Colors.white,
                            fontSize:    titleFontSize,
                            fontWeight:  FontWeight.bold,
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