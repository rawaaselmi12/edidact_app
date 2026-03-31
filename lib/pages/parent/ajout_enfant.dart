import 'package:flutter/material.dart';

const _kCyan = Color(0xFF26C6DA);
const _kCyanLight = Color(0xFFB2EBF2);

class AjoutEnfantPage extends StatefulWidget {
  const AjoutEnfantPage({super.key});

  @override
  State<AjoutEnfantPage> createState() => _AjoutEnfantPageState();
}

class _AjoutEnfantPageState extends State<AjoutEnfantPage> {
  final _nomController          = TextEditingController();
  final _classeController       = TextEditingController();
  final _identifiantController  = TextEditingController();
  final _motDePasseController   = TextEditingController();
  bool _showPassword = false;

  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  bool _isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

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
    final isTablet    = _isTablet(context);
    final isLandscape = _isLandscape(context);

    final EdgeInsets insetPadding = isTablet
        ? (isLandscape
            ? const EdgeInsets.symmetric(horizontal: 80, vertical: 28)
            : const EdgeInsets.symmetric(horizontal: 100, vertical: 60))
        : const EdgeInsets.symmetric(horizontal: 20, vertical: 40);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: insetPadding,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(isTablet ? 24 : 20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: isLandscape && isTablet
            ? _buildLandscape(context)
            : _buildPortrait(context, isTablet),
      ),
    );
  }

//payasage
  Widget _buildLandscape(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          
          _buildHeader(context, fontSize: 20),

          Padding(
            padding: const EdgeInsets.fromLTRB(28, 4, 28, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'photo de profil',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: _kCyan,
                    decoration: TextDecoration.underline,
                    decorationColor: _kCyan,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: _kCyanLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Ajouter image',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Information personnelles',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _fieldLabel('Prénom', fontSize: 14),
                          _textField(_nomController, '....................', fontSize: 14),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _fieldLabel('Classe', fontSize: 14),
                          _textField(_classeController, '....................', fontSize: 14),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                const Text(
                  'Information de connexion',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _fieldLabel('Identifiant', fontSize: 14),
                          _textField(_identifiantController, '....................', fontSize: 14),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _fieldLabel('Mot de passe', fontSize: 14),
                          _passwordField(fontSize: 14),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                _buildButtons(context, fontSize: 16, verticalPad: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }

//portrait
  Widget _buildPortrait(BuildContext context, bool isTablet) {
    final double labelSz = isTablet ? 15 : 13;
    final double fieldSz = isTablet ? 14 : 13;
    final double btnSz   = isTablet ? 16 : 15;
    final double btnPad  = isTablet ? 14 : 12;
    final double hPad    = isTablet ? 28 : 20;
    final double spacing = isTablet ? 18 : 14;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context, fontSize: isTablet ? 20 : 17),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _fieldLabel('Nom et prénom', fontSize: labelSz),
                _textField(_nomController, '----------', fontSize: fieldSz),
                SizedBox(height: spacing),

                _fieldLabel('Classe', fontSize: labelSz),
                _textField(_classeController, '----------', fontSize: fieldSz),
                SizedBox(height: spacing),

                _fieldLabel('Identifiant', fontSize: labelSz),
                _textField(_identifiantController, '----------', fontSize: fieldSz),
                SizedBox(height: spacing),

                _fieldLabel('Mot de passe', fontSize: labelSz),
                _passwordField(fontSize: fieldSz),
                SizedBox(height: isTablet ? 20 : 16),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 20 : 16,
                        vertical:   isTablet ? 12 : 9,
                      ),
                      decoration: BoxDecoration(
                        color: _kCyan,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.image_outlined, color: Colors.white, size: isTablet ? 22 : 18),
                          SizedBox(width: isTablet ? 8 : 6),
                          Text(
                            'Ajouter image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isTablet ? 15 : 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: isTablet ? 24 : 20),
                _buildButtons(context, fontSize: btnSz, verticalPad: btnPad),
                SizedBox(height: isTablet ? 24 : 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, {required double fontSize}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Text(
            'Ajouter compte enfant',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: _kCyan,
            ),
          ),
        ),
        Positioned(
          right: 12,
          top: 10,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
              child: const Icon(Icons.close, size: 16, color: Colors.black54),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context, {required double fontSize, required double verticalPad}) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: verticalPad),
              decoration: BoxDecoration(
                color: _kCyan,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                'valider',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: fontSize),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: verticalPad),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: _kCyan, width: 1.5),
              ),
              child: Text(
                'annuler',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kCyan, fontWeight: FontWeight.bold, fontSize: fontSize),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _fieldLabel(String text, {double fontSize = 13}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600, color: Colors.black87),
      ),
    );
  }

  Widget _textField(TextEditingController controller, String hint, {double fontSize = 13}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: fontSize),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _passwordField({double fontSize = 13}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: _motDePasseController,
        obscureText: !_showPassword,
        style: TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
          hintText: '----------',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: fontSize),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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