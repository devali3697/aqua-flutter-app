import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AquaHomeScreen extends StatelessWidget {
  const AquaHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔵 figures (same as design)
    const double balance = 4216.00;
    const double available = 784.00;
    const double creditLimit = 5000.00;

    // blue progress ratio (used / limit)
    final double progress = (balance / creditLimit).clamp(0.0, 1.0);

    return Scaffold(
      // neeche wala area = light grey
      backgroundColor: const Color(0xFFF2F2F7),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double w = constraints.maxWidth;
            final double cardHeight = w * 0.46;
            final double horizontalPadding = 24;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // =================== TOP WHITE AREA (card + balance) ===================
                  Container(
                    width: double.infinity,
                    color: Colors.white, // sirf flat white, koi shadow nahi
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 28),

                        // --------- Aqua card ---------- //
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          child: Container(
                            height: cardHeight,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF00D2FF),
                                  Color(0xFF00D38C),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.16),
                                  blurRadius: 20,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                // aqua logo
                                Positioned(
                                  left: 24,
                                  top: 26,
                                  child: Text(
                                    "aqua",
                                    style: GoogleFonts.nunito(
                                      fontSize: 24, // thoda chhota, ref jaisa
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0000A6),
                                    ),
                                  ),
                                ),

                                // card number
                                Positioned(
                                  left: 24,
                                  bottom: 30,
                                  child: Text(
                                    ".... 7843",
                                    style: GoogleFonts.arimo(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF003366),
                                    ),
                                  ),
                                ),

                                // mastercard
                                Positioned(
                                  right: 30,
                                  bottom: 30,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFE60023),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: const Offset(-12, 0),
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFFFA300),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // --------- Balance / Available ---------- //
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding + 2,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Balance",
                                        style: GoogleFonts.arimo(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.info_outline,
                                        size: 16,
                                        color: Color(0xFF0A7BFF),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "£4,075.00", // ✅ same as design
                                    style: GoogleFonts.arimo(
                                      fontSize: 30, // thoda bada, bold
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Available",
                                    style: GoogleFonts.arimo(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "£925.00", // ✅ same as design
                                    style: GoogleFonts.arimo(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // --------- Progress bar (blue + grey) ---------- //
                        // --------- Progress bar (blue + grey) ---------- //
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          child: SizedBox(
                            height: 8.0, // 🔵 pehle 5.5 tha, ab thoda mota
                            child: Stack(
                              children: [
                                // grey track
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE2E4EB),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                // blue level (used portion)
                                FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: progress, // ~0.84
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0A7BFF),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // --------- Credit limit text ---------- //
                        Text(
                          "Credit limit: £5,000.00", // ✅ same as design
                          style: GoogleFonts.arimo(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF8e8e93), // thoda light grey
                          ),
                        ),

                        const SizedBox(height: 26),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // =================== GREY AREA (Direct Debit etc.) =================== //

                  // Direct Debit card
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Set up a Direct Debit",
                                  style: GoogleFonts.arimo(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "and help avoid late payments",
                                  style: GoogleFonts.arimo(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.close_rounded,
                            size: 22,
                            color: Color(0xFFB8BCC7),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 10,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0A7BFF),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 10,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD0D3DD),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 46),

                  Text(
                    "No recent transactions",
                    style: GoogleFonts.arimo(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFB8BCC7),
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
