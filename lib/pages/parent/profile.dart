import 'package:flutter/material.dart';
import 'package:edidact_app/widgets/menu_barre.dart';

const _kPurple = Color(0xFF9C27B0);
const _kCyan = Color(0xFF00BCD4);
const _kCyanLight = Color(0xFF26C6DA);

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _tabIndex = 0;
  final _nomCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _adresseCtrl = TextEditingController();
  final _cpCtrl = TextEditingController();
  final _tlpCtrl = TextEditingController();
  final _villeCtrl = TextEditingController();

  @override
  void dispose() {
    _nomCtrl.dispose();
    _emailCtrl.dispose();
    _tlpCtrl.dispose();
    _adresseCtrl.dispose();
    _cpCtrl.dispose();
    _villeCtrl.dispose();
    super.dispose();
  }

  void _openMenu() {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black45,
        pageBuilder: (_, __, ___) => const MenuBarre(),
        transitionsBuilder: (_, anim, __, child) => SlideTransition(
          position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
              .animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
          child: child,
        ),
      ),
    );
  }

  bool _isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.longestSide >= 900 || size.shortestSide >= 600;
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = _isTablet(context);
    final double hPad = isTablet ? 28 : 16;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: hPad, top: 12, bottom: 4),
              child: GestureDetector(
                onTap: _openMenu,
                child: Icon(Icons.menu, color: _kCyan, size: isTablet ? 40 : 34),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: Container(
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
                    Icon(Icons.person_outline_rounded,
                        color: Colors.white, size: isTablet ? 44 : 32),
                    SizedBox(width: isTablet ? 18 : 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profil',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isTablet ? 21 : 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(height: isTablet ? 10 : 8),
                          Text(
                            'Gérez vos informations personnelles et votre abonnement',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: isTablet ? 16 : 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: isTablet ? 20 : 16),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _tabIndex = 0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            vertical: isTablet ? 15 : 10),
                        decoration: BoxDecoration(
                          color: _tabIndex == 0 ? _kCyan : Colors.white,
                          borderRadius:
                              BorderRadius.circular(isTablet ? 14 : 10),
                          border: Border.all(color: _kCyan, width: 1.5),
                        ),
                        child: Text(
                          'Profil',
                          style: TextStyle(
                            color: _tabIndex == 0 ? Colors.white : _kCyan,
                            fontWeight: FontWeight.w600,
                            fontSize: isTablet ? 18 : 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: isTablet ? 12 : 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _tabIndex = 1),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            vertical: isTablet ? 15 : 10),
                        decoration: BoxDecoration(
                          color: _tabIndex == 1 ? _kCyan : Colors.white,
                          borderRadius:
                              BorderRadius.circular(isTablet ? 14 : 10),
                          border: Border.all(color: _kCyan, width: 1.5),
                        ),
                        child: Text(
                          'Sécurité',
                          style: TextStyle(
                            color: _tabIndex == 1 ? Colors.white : _kCyan,
                            fontWeight: FontWeight.w600,
                            fontSize: isTablet ? 18 : 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: isTablet ? 20 : 14),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 24),
                child: _tabIndex == 0
                    ? _ProfilContent(
                        nomCtrl: _nomCtrl,
                        emailCtrl: _emailCtrl,
                        tlpCtrl: _tlpCtrl,
                        adresseCtrl: _adresseCtrl,
                        cpCtrl: _cpCtrl,
                        villeCtrl: _villeCtrl,
                      )
                    : const _SecuriteContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfilContent extends StatelessWidget {
  final TextEditingController nomCtrl, emailCtrl, tlpCtrl, adresseCtrl, cpCtrl, villeCtrl;
  const _ProfilContent(
      {required this.nomCtrl,
      required this.emailCtrl,
      required this.tlpCtrl,
      required this.adresseCtrl,
      required this.cpCtrl,
      required this.villeCtrl});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width < 600) {
          return Column(
            children: [
              _personalCard(),
              const SizedBox(height: 14),
              _abonnementCard(),
              const SizedBox(height: 14),
              _factureCard(),
            ],
          );
        }

        if (width < 1000) {
          return Column(
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: _personalCard()),
                    const SizedBox(width: 14),
                    Expanded(child: _abonnementCard()),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _factureCard(),
            ],
          );
        }

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _personalCard(isDesktop: true)),
              const SizedBox(width: 14),
              Expanded(child: _abonnementCard()),
              const SizedBox(width: 14),
              Expanded(child: _factureCard()),
            ],
          ),
        );
      },
    );
  }

  Widget _personalCard({bool isDesktop = false}) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: Text('Informations personnelles',
                    style: TextStyle(
                        color: _kCyan, fontWeight: FontWeight.bold, fontSize: 14)),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text(
                  "Modifier",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          _Field(label: 'Nom complet', ctrl: nomCtrl, activeBorder: false),
          const SizedBox(height: 10),
          _Field(label: 'Email', ctrl: emailCtrl, activeBorder: false),
          const SizedBox(height: 10),
          _Field(label: 'Téléphone', ctrl: tlpCtrl, activeBorder: false),
          const SizedBox(height: 10),
          _Field(label: 'Adresse', ctrl: adresseCtrl, activeBorder: false),
          const SizedBox(height: 10),
          _Field(label: 'Code postal', ctrl: cpCtrl, activeBorder: false),
          const SizedBox(height: 10),
          _Field(label: 'Ville', ctrl: villeCtrl, activeBorder: false),
        ],
      ),
    );
  }

  Widget _abonnementCard() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: const [
            Icon(Icons.shield_outlined, color: _kCyan, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Abonnement',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.5, color: Colors.black87)),
                Text('Informations sur votre abonnement actuel',
                    style: TextStyle(fontSize: 11, color: Colors.grey)),
              ]),
            ),
          ]),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            decoration: BoxDecoration(
                color: const Color(0xFFE0F7FA), borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              const Expanded(
                  child: Text('Statut de l\'abonnement',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.5, color: Colors.black87))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                child: const Text('Actif',
                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ]),
          ),
          const SizedBox(height: 8),
          _AbBox(label: 'Plan actuel:', value: 'Abonnement trimestriel Premium'),
          const SizedBox(height: 6),
          _AbBox(label: 'Prochaine facturation:', value: '24/06/2025'),
          const SizedBox(height: 6),
          _AbBox(label: 'Montant:', value: 'C\$6.35 CHF'),
        ],
      ),
    );
  }

  Widget _factureCard() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: const [
            Icon(Icons.receipt_long_outlined, color: _kCyan, size: 20),
            SizedBox(width: 8),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Dernière Facture',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.5, color: Colors.black87)),
              Text('Votre facture la plus récente',
                  style: TextStyle(fontSize: 11, color: Colors.grey)),
            ]),
          ]),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
            decoration: BoxDecoration(
                border: Border.all(color: _kCyanLight, width: 1.2),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Facture #2593',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                const SizedBox(height: 2),
                const Text('07/04/2026', style: TextStyle(fontSize: 11, color: Colors.grey)),
                const SizedBox(height: 10),
                _FRow(label: 'Plan:', value: 'Abonnement trimestriel Premium'),
                _FRow(label: 'Montant:', value: 'C\$6.35 CHF'),
                _FRow(label: 'Période:', value: '09-03-2025/26-06-2025'),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _kCyan,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: const Icon(Icons.download_rounded, size: 18),
                    label: const Text('Télécharger le PDF',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
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

class _Field extends StatelessWidget {
  final String label;
  final TextEditingController ctrl;
  final bool activeBorder;
  const _Field({required this.label, required this.ctrl, required this.activeBorder});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.black87)),
        const SizedBox(height: 4),
        TextField(
          controller: ctrl,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: _kCyan, width: 2.0),
            ),
          ),
        ),
      ],
    );
  }
}

class _AbBox extends StatelessWidget {
  final String label;
  final String value;
  const _AbBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _kCyan.withOpacity(0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kCyanLight, width: 1.2),
      ),
      child: Row(
        children: [
          SizedBox(
              width: 155,
              child: Text(label,
                  style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400))),
          Expanded(
              child: Text(value,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}

class _FRow extends StatelessWidget {
  final String label;
  final String value;
  const _FRow({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 70,
              child: Text(label,
                  style: const TextStyle(fontSize: 11.5, color: Colors.black54, fontWeight: FontWeight.w500))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 11.5, color: Colors.black87))),
        ],
      ),
    );
  }
}

class _SecuriteContent extends StatelessWidget {
  const _SecuriteContent();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;

      Widget leftBox = _Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: const [
              Icon(Icons.key, color: _kCyan),
              SizedBox(width: 6),
              Text('Gestion de mot de passe',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: _kCyan)),
            ]),
            const SizedBox(height: 10),
            _Field(label: 'Mot de passe actuel', ctrl: TextEditingController(), activeBorder: true),
            const SizedBox(height: 10),
            _Field(label: 'Nouveau mot de passe', ctrl: TextEditingController(), activeBorder: true),
            const SizedBox(height: 10),
            _Field(label: 'Confirmer le mot de passe', ctrl: TextEditingController(), activeBorder: true),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: _kPurple),
                child: const Text('Confirmer', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      );

      Widget rightBox = _Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: const [
              Icon(Icons.description, color: _kCyan, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Demande de résiliation',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.5, color: _kCyan)),
                  Text('Vous souhaitez résilier votre abonnement',
                      style: TextStyle(fontSize: 11, color: Colors.grey)),
                ]),
              ),
            ]),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCyan.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nous sommes là pour vous aider',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                  SizedBox(height: 6),
                  Text(
                      'Avant de résilier, partagez-nous vos préoccupations. Notre équipe étudiera votre demande et vous contactera dans les 48 heures.',
                      style: TextStyle(fontSize: 12, color: Colors.black87)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCyan.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('1/ Indiquez la raison de votre demande',
                      style: TextStyle(fontSize: 12, color: Colors.black87)),
                  SizedBox(height: 4),
                  Text('2/ Notre équipe examine votre demande',
                      style: TextStyle(fontSize: 12, color: Colors.black87)),
                  SizedBox(height: 4),
                  Text('3/ Nous vous contactons sous 48h',
                      style: TextStyle(fontSize: 12, color: Colors.black87)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: _kPurple),
                  child: const Text('Faire une résiliation', style: TextStyle(color: Colors.white))),
            ),
          ],
        ),
      );

      if (width < 600) {
        return Column(
          children: [
            leftBox,
            const SizedBox(height: 16),
            rightBox,
          ],
        );
      }

      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: leftBox),
            const SizedBox(width: 16),
            Expanded(child: rightBox),
          ],
        ),
      );
    });
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }
}