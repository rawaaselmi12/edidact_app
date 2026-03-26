import 'package:flutter/material.dart';
import 'package:edidact_app/widgets/menu_barre.dart';

const _kPurple    = Color(0xFF9C27B0);
const _kCyan      = Color(0xFF00BCD4);
const _kCyanLight = Color(0xFF26C6DA);

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _tabIndex = 0;
  final _nomCtrl     = TextEditingController();
  final _emailCtrl   = TextEditingController();
  final _adresseCtrl = TextEditingController();
  final _cpCtrl      = TextEditingController();

  @override
  void dispose() {
    _nomCtrl.dispose(); _emailCtrl.dispose();
    _adresseCtrl.dispose(); _cpCtrl.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.only(left: 16, top: 12, bottom: 4),
              child: GestureDetector(
                onTap: _openMenu,
                child: const Icon(Icons.menu, color: _kCyan, size: 34),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: _kPurple,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.person_outline_rounded, color: Colors.white, size: 32),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profil',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Gérez vos informations personnelles\net votre abonnement',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _TabBtn(label: 'Profil',   active: _tabIndex == 0, onTap: () => setState(() => _tabIndex = 0)),
                  const SizedBox(width: 8),
                  _TabBtn(label: 'Sécurité', active: _tabIndex == 1, onTap: () => setState(() => _tabIndex = 1)),
                ],
              ),
            ),

            const SizedBox(height: 14),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: _tabIndex == 0
                    ? _ProfilContent(
                        nomCtrl: _nomCtrl, emailCtrl: _emailCtrl,
                        adresseCtrl: _adresseCtrl, cpCtrl: _cpCtrl)
                    : const _SecuriteContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabBtn extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _TabBtn({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? _kCyan : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: active ? _kCyan : _kCyanLight, width: 1.5),
          ),
          child: Text(label,
              style: TextStyle(
                  color: active ? Colors.white : _kCyan,
                  fontWeight: FontWeight.w600,
                  fontSize: 15)),
        ),
      ),
    );
  }
}

class _ProfilContent extends StatelessWidget {
  final TextEditingController nomCtrl, emailCtrl, adresseCtrl, cpCtrl;
  const _ProfilContent({required this.nomCtrl, required this.emailCtrl,
      required this.adresseCtrl, required this.cpCtrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        _Card(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                width: 52, height: 52,
                decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle),
                child: Icon(Icons.person, color: Colors.grey.shade500, size: 28),
              ),
              const SizedBox(width: 12),
              const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('NOM....', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
                Text('E mail',  style: TextStyle(fontSize: 12, color: Colors.grey)),
              ]),
            ]),
            const SizedBox(height: 14),
            const Text('Informations personnelles',
                style: TextStyle(color: _kCyan, fontWeight: FontWeight.bold, fontSize: 13.5)),
            const SizedBox(height: 12),
            _Field(label: 'Nom complet', ctrl: nomCtrl,     activeBorder: false),
            const SizedBox(height: 10),
            _Field(label: 'Email',        ctrl: emailCtrl,   activeBorder: false),
            const SizedBox(height: 10),
            _Field(label: 'Adresse',      ctrl: adresseCtrl, activeBorder: false),
            const SizedBox(height: 10),
            _Field(label: 'Code postal',  ctrl: cpCtrl,      activeBorder: false),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kPurple, foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Modifier vos informations',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        )),

        const SizedBox(height: 14),

        _Card(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: const [
              Icon(Icons.shield_outlined, color: _kCyan, size: 20),
              SizedBox(width: 8),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Abonnement',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.5, color: Colors.black87)),
                Text('Informations sur votre abonnement actuel',
                    style: TextStyle(fontSize: 11, color: Colors.grey)),
              ]),
            ]),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              decoration: BoxDecoration(
                  color: const Color(0xFFE0F7FA), borderRadius: BorderRadius.circular(10)),
              child: Row(children: [
                const Expanded(child: Text('Statut de l\'abonnement',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5, color: Colors.black87))),
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
        )),

        const SizedBox(height: 14),

        _Card(child: Column(
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
                  _FRow(label: 'Plan:',    value: 'Abonnement trimestriel Premium'),
                  _FRow(label: 'Montant:', value: 'C\$6.35 CHF'),
                  _FRow(label: 'Période:', value: '09-03-2025/26-06-2025'),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _kCyan, foregroundColor: Colors.white,
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
        )),
      ],
    );
  }
}

class _SecuriteContent extends StatelessWidget {
  const _SecuriteContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        _Card(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: const [
              Icon(Icons.lock_outline, color: _kCyan, size: 22),
              SizedBox(width: 8),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gestion de mot de passe',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.5, color: Colors.black87)),
                  Text('modifier mot de passe',
                      style: TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              )),
            ]),
            const SizedBox(height: 16),
            _PasswordField(label: 'Ancien mot de passe'),
            const SizedBox(height: 10),
            _PasswordField(label: 'Nouveau mot de passe'),
            const SizedBox(height: 10),
            _PasswordField(label: 'Confirmer le mot de passe'),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kPurple, foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Confirmer',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        )),

        const SizedBox(height: 14),

        _Card(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: const [
              Icon(Icons.description_outlined, color: _kCyan, size: 22),
              SizedBox(width: 8),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Demande de résiliation',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.5, color: Colors.black87)),
                  Text('Vous souhaitez résilier votre abonnement',
                      style: TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              )),
            ]),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCyan.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kCyanLight, width: 1.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Nous sommes là pour vous aider',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                  SizedBox(height: 6),
                  Text(
                    'Avant de résilier, partagez-nous vos préoccupations. Notre équipe étudiera votre demande et vous contactera dans les 48 heures.',
                    style: TextStyle(fontSize: 11.5, color: Colors.black54, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _ResiliationStep(number: '1', text: 'Indiquez la raison de votre demande'),
            const SizedBox(height: 6),
            _ResiliationStep(number: '2', text: 'Notre équipe examine votre demande'),
            const SizedBox(height: 6),
            _ResiliationStep(number: '3', text: 'Nous vous contactons sous 48h'),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kPurple, foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Faire une résiliation',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        )),
      ],
    );
  }
}

class _PasswordField extends StatefulWidget {
  final String label;
  const _PasswordField({required this.label});

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscure = true;
  final _ctrl = TextEditingController();

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: const TextStyle(fontSize: 13, color: Colors.black87)),
        const SizedBox(height: 4),
        TextField(
          controller: _ctrl,
          obscureText: _obscure,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            suffixIcon: GestureDetector(
              onTap: () => setState(() => _obscure = !_obscure),
              child: Icon(
                _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 20, color: Colors.grey,
              ),
            ),
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

class _ResiliationStep extends StatelessWidget {
  final String number;
  final String text;
  const _ResiliationStep({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22, height: 22,
          decoration: BoxDecoration(
              color: _kCyan.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
          alignment: Alignment.center,
          child: Text(number,
              style: const TextStyle(fontSize: 12, color: _kCyan, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 12.5, color: Colors.black87))),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _kCyanLight, width: 1.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final TextEditingController ctrl;
  final bool activeBorder;
  final bool obscure;
  const _Field({required this.label, required this.ctrl,
      required this.activeBorder, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.black87)),
        const SizedBox(height: 4),
        TextField(
          controller: ctrl,
          obscureText: obscure,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(
                  color: activeBorder ? _kCyan : Colors.grey.shade300,
                  width: activeBorder ? 2.0 : 1.0),
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
          SizedBox(width: 155,
              child: Text(label,
                  style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400))),
          Expanded(child: Text(value,
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
          SizedBox(width: 70,
              child: Text(label,
                  style: const TextStyle(fontSize: 11.5, color: Colors.black54, fontWeight: FontWeight.w500))),
          Expanded(child: Text(value,
              style: const TextStyle(fontSize: 11.5, color: Colors.black87))),
        ],
      ),
    );
  }
}