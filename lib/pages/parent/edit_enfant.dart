import 'package:flutter/material.dart';

class EditEnfantPage extends StatefulWidget {
  final String nom;
  final String classe;
  final String identifiant;
  final String motDePasse;

  const EditEnfantPage({
    super.key,
    this.nom = '',
    this.classe = '',
    this.identifiant = '',
    this.motDePasse = '',
  });

  @override
  State<EditEnfantPage> createState() => _EditEnfantPageState();
}

class _EditEnfantPageState extends State<EditEnfantPage> {
  late final TextEditingController _nomController;
  late final TextEditingController _classeController;
  late final TextEditingController _identifiantController;
  late final TextEditingController _motDePasseController;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController();
    _classeController = TextEditingController();
    _identifiantController = TextEditingController();
    _motDePasseController = TextEditingController();
  }

  @override
  void dispose() {
    _nomController.dispose();
    _classeController.dispose();
    _identifiantController.dispose();
    _motDePasseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Header ──────────────────────────────────────────
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: const Text(
                    'Modifier compte enfant',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF26C6DA),
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 10,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close,
                          size: 16, color: Colors.black54),
                    ),
                  ),
                ),
              ],
            ),

            // ── Form ────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Photo d'enfant button
                  GestureDetector(
                    onTap: () {
                      // TODO: choisir photo
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 22),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F7FA),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text(
                        "Photo d'enfant",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Nom et prénom
                  _fieldLabel('Nom et prénom'),
                  _textField(_nomController, '----------'),
                  const SizedBox(height: 14),

                  // Classe
                  _fieldLabel('Classe'),
                  _textField(_classeController, '----------'),
                  const SizedBox(height: 14),

                  // Identifiant
                  _fieldLabel('Identifiant'),
                  _textField(_identifiantController, '----------'),
                  const SizedBox(height: 14),

                  // Mot de passe
                  _fieldLabel('Mot de passe'),
                  _passwordField(),
                  const SizedBox(height: 22),

                  // Valider / Annuler
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // TODO: logique validation
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF26C6DA),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Text(
                              'valider',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: const Color(0xFF26C6DA),
                                width: 1.5,
                              ),
                            ),
                            child: const Text(
                              'annuler',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF26C6DA),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _textField(TextEditingController controller, String hint) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: _motDePasseController,
        obscureText: !_showPassword,
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          hintText: '----------',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: () => setState(() => _showPassword = !_showPassword),
            child: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}