import 'package:flutter/material.dart';

class RewardCreationPage extends StatefulWidget {
  const RewardCreationPage({super.key});

  @override
  State<RewardCreationPage> createState() => _RewardCreationPageState();
}

class _RewardCreationPageState extends State<RewardCreationPage> {
  final _titreController = TextEditingController();
  String? _categorieSelected;
  String? _coinsSelected;
  String? _enfantSelected;

  final List<String> _categories = ['jouet', 'journée au parc', 'cinéma', 'autre'];
  final List<String> _coins = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  final List<String> _enfants = ['enfant 1', 'enfant 2', 'enfant 3'];

  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  bool _isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  @override
  void dispose() {
    _titreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet    = _isTablet(context);
    final isLandscape = _isLandscape(context);

    final EdgeInsets insetPadding = isTablet
        ? (isLandscape
            ? const EdgeInsets.symmetric(horizontal: 60, vertical: 30)
            : const EdgeInsets.symmetric(horizontal: 80, vertical: 60))
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
            ? _buildLandscapeLayout(context)
            : _buildPortraitLayout(context, isTablet),
      ),
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context, fontSize: 20),

          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _fieldLabel('Image de la récompense', fontSize: 15),
                const SizedBox(height: 8),
                _buildImagePicker(),
                const SizedBox(height: 20),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _fieldLabel('Titre', fontSize: 15),
                          _textField(_titreController, '..............', fontSize: 14),
                          const SizedBox(height: 16),
                          _fieldLabel('Nombre de coins', fontSize: 15),
                          _dropdownField(
                            value: _coinsSelected,
                            items: _coins,
                            hint: '...............',
                            fontSize: 14,
                            onChanged: (v) => setState(() => _coinsSelected = v),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Colonne droite
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _fieldLabel('Catégorie', fontSize: 15),
                          _dropdownField(
                            value: _categorieSelected,
                            items: _categories,
                            hint: '...............',
                            fontSize: 14,
                            onChanged: (v) => setState(() => _categorieSelected = v),
                          ),
                          const SizedBox(height: 16),
                          _fieldLabel('Enfants concernés', fontSize: 15),
                          _dropdownField(
                            value: _enfantSelected,
                            items: _enfants,
                            hint: '...............',
                            fontSize: 14,
                            onChanged: (v) => setState(() => _enfantSelected = v),
                          ),
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
  Widget _buildPortraitLayout(BuildContext context, bool isTablet) {
    final double labelSize  = isTablet ? 15 : 13;
    final double fieldSize  = isTablet ? 14 : 13;
    final double btnSize    = isTablet ? 16 : 15;
    final double btnPad     = isTablet ? 14 : 12;
    final double hPad       = isTablet ? 28 : 20;
    final double spacing    = isTablet ? 18 : 14;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context, fontSize: isTablet ? 20 : 18),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _fieldLabel('Titre:', fontSize: labelSize),
                _textField(_titreController, '......', fontSize: fieldSize),
                SizedBox(height: spacing),

                _fieldLabel('Catégorie :', fontSize: labelSize),
                _dropdownField(
                  value: _categorieSelected,
                  items: _categories,
                  hint: '........',
                  fontSize: fieldSize,
                  onChanged: (v) => setState(() => _categorieSelected = v),
                ),
                SizedBox(height: spacing),

                _fieldLabel('nombre de coins:', fontSize: labelSize),
                _dropdownField(
                  value: _coinsSelected,
                  items: _coins,
                  hint: '.......',
                  fontSize: fieldSize,
                  onChanged: (v) => setState(() => _coinsSelected = v),
                ),
                SizedBox(height: spacing),

                _fieldLabel('Enfants concernées:', fontSize: labelSize),
                _dropdownField(
                  value: _enfantSelected,
                  items: _enfants,
                  hint: '.........',
                  fontSize: fieldSize,
                  onChanged: (v) => setState(() => _enfantSelected = v),
                ),
                SizedBox(height: isTablet ? 28 : 24),

                _buildButtons(context, fontSize: btnSize, verticalPad: btnPad),
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
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Text(
            'Créer une récompense',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF26C6DA),
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
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 16, color: Colors.black54),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF26C6DA),
          borderRadius: BorderRadius.circular(10),
        ),
        
      ),
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
                color: const Color(0xFF26C6DA),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                'valider',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
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
              padding: EdgeInsets.symmetric(vertical: verticalPad),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xFF26C6DA), width: 1.5),
              ),
              child: Text(
                'annuler',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF26C6DA),
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
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
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
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

  Widget _dropdownField({
    required String? value,
    required List<String> items,
    required String hint,
    required ValueChanged<String?> onChanged,
    double fontSize = 13,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint, style: TextStyle(color: Colors.grey[400], fontSize: fontSize)),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          style: TextStyle(fontSize: fontSize, color: Colors.black87),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}