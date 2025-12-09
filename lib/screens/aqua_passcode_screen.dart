import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AquaBottomNavShell.dart';

class AquaPasscodeScreen extends StatefulWidget {
  const AquaPasscodeScreen({super.key});

  @override
  State<AquaPasscodeScreen> createState() => _AquaPasscodeScreenState();
}

class _AquaPasscodeScreenState extends State<AquaPasscodeScreen> {
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
  List.generate(6, (_) => FocusNode());

  int _focusedIndex = 0; // ✅ default: 1st box selected

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));

    for (var i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          setState(() => _focusedIndex = i);
        }
      });
    }

    // ✅ pehle box ko default focus
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onAllDigitsFilled() {
    final code = _controllers.map((e) => e.text).join();
    debugPrint('Passcode: $code');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AquaBottomNavShell()),
    );
  }

  Widget _buildDigitBox(int index, double size) {
    final bool isFocused = _focusedIndex == index;

    String? hint;
    if (index == 0) hint = '1st';
    if (index == 1) hint = '2nd';
    if (index == 2) hint = '3rd';
    if (index == 3) hint = '4th';
    if (index == 4) hint = '5th';
    if (index == 5) hint = '6th';

    final Color fillColor =
    isFocused ? Colors.white : const Color(0xFFE5E5EA); // softer grey
    final Color borderColor =
    isFocused ? const Color(0xFF007AFF) : Colors.transparent;
    final double borderWidth = isFocused ? 1.4 : 0.0;

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(12), // iOS style rounded square
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
          boxShadow: isFocused
              ? [
            BoxShadow(
              color: const Color(0xFF007AFF).withOpacity(0.18),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ]
              : const [],
        ),
        child: Center(
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            style: GoogleFonts.arimo(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF0A0A0A),
            ),
            maxLength: 1,
            showCursor: true,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
              isCollapsed: true,
              contentPadding: EdgeInsets.zero,
              hintText: isFocused ? hint : null,
              hintStyle: GoogleFonts.arimo(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFB0B0B0),
              ),
            ),
            onTap: () {
              setState(() => _focusedIndex = index);
              FocusScope.of(context).requestFocus(_focusNodes[index]);
            },
            onChanged: (value) {
              if (value.length == 1) {
                if (index < 5) {
                  FocusScope.of(context)
                      .requestFocus(_focusNodes[index + 1]);
                } else {
                  final allFilled = _controllers
                      .every((c) => c.text.trim().length == 1);
                  if (allFilled) _onAllDigitsFilled();
                }
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context)
                    .requestFocus(_focusNodes[index - 1]);
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double maxWidth = constraints.maxWidth;

            double boxSize = 50.0;
            double boxGap = 8.0;
            if (maxWidth < 360) {
              boxSize = 46.0;
              boxGap = 6.0;
            }

            return Stack(
              children: [
                // top-right help icon
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, right: 18.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        'assets/images/help_icon.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),

                // 🔥 main content perfectly centered
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ✅ REPLACED: logo + text → single combined image
                      Image.asset(
                        'assets/images/aqualogo.png', // 👈 yahan apni combined image ka path do
                        height: 40,
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(height: 24),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          'Please enter the requested digits from your\npasscode to continue',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.arimo(
                            fontSize: 14,
                            height: 1.3,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF303030),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // boxes row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 6; i++) ...[
                            _buildDigitBox(i, boxSize),
                            if (i != 5) SizedBox(width: boxGap),
                          ],
                        ],
                      ),

                      const SizedBox(height: 18),

                      // forgotten text
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Forgotten your passcode?',
                              style: GoogleFonts.arimo(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF007AFF),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
