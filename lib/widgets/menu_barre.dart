import 'package:flutter/material.dart';
import 'package:edidact_app/pages/home_page.dart';
import 'package:edidact_app/pages/reward_page.dart';
import 'package:edidact_app/pages/mes_enfants_page.dart';
import 'package:edidact_app/pages/historique.dart';
import 'package:edidact_app/pages/profile.dart';

class MenuBarre extends StatelessWidget {
  const MenuBarre({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          // ── Drawer panel ─────────────────────────────────────────
          Container(
            width: 230,
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
                  const SizedBox(height: 20),

                  // ── Logo + App name ──────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/image1.png',
                          width: 65,
                          height: 65,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'EDIDACT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 48),

                  // ── Menu items ───────────────────────────────────
                  _menuItem(
                    context: context,
                    icon: Icons.bar_chart_rounded,
                    label: 'Progression',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      );
                    },
                  ),
                  _menuItem(
                    context: context,
                    icon: Icons.description_outlined,
                    label: 'Examens',
                    onTap: () => Navigator.pop(context),
                  ),
                  _menuItem(
                    context: context,
                    icon: Icons.emoji_events_outlined,
                    label: 'Récompenses',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RewardPage()),
                      );
                    },
                  ),
                  _menuItem(
                    context: context,
                    icon: Icons.supervised_user_circle_outlined,
                    label: 'Mes enfants',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MesEnfantsPage()),
                      );
                    },
                  ),
                  _menuItem(
                    context: context,
                    icon: Icons.history_outlined,
                    label: 'Historique',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const HistoriquePage()),
                      );
                    },
                  ),

                  const Spacer(),

                  // ── Bottom items ─────────────────────────────────
                  _menuItem(
                    context: context,
                    icon: Icons.person_outline,
                    label: 'Profile',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ProfilePage()),
                      );
                    },
                  ),
                  _menuItem(
                    context: context,
                    icon: Icons.logout,
                    label: 'Déconnexion',
                    onTap: () => Navigator.pop(context),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // ── Zone de fermeture ─────────────────────────────────────
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
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white24,
      highlightColor: Colors.white10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}