import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AquaMoreScreen extends StatefulWidget {
  const AquaMoreScreen({super.key});

  @override
  State<AquaMoreScreen> createState() => _AquaMoreScreenState();
}

class _AquaMoreScreenState extends State<AquaMoreScreen> {
  bool _personalExpanded = false;

  // ---------- COMMON ROW (COLLAPSED) ----------
  Widget _buildCollapsedRow(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2), // gap between rows
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.arimo(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
            const Icon(
              Icons.expand_more,
              size: 18,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }

  // ---------- PERSONAL HEADER ----------
  Widget _buildPersonalHeader({required bool expanded}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2), // same gap
      child: GestureDetector(
        onTap: () => setState(() => _personalExpanded = !_personalExpanded),
        child: Container(
          color: expanded ? const Color(0xFFFFC32B) : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Personal details',
                style: GoogleFonts.arimo(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              Icon(
                expanded ? Icons.expand_less : Icons.expand_more,
                size: 18,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- PERSONAL EXPANDED BODY (FULL) ----------
  Widget _buildPersonalExpandedBody() {
    const darkBlue = Color(0xFF010035); // updated blue

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Intro text
          Text(
            "It's important to make sure your contact details are up to date.",
            style: GoogleFonts.arimo(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            "From time to time, we need to get in touch with you about your account. We also use your contact information to confirm your identity, so it's very important that when you move house or change phone numbers, you keep your details up to date. It only takes a minute to make sure they're current.",
            style: GoogleFonts.arimo(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 24),

          // Your details + [EDIT]
          Row(
            children: [
              Text(
                'Your details',
                style: GoogleFonts.arimo(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  // TODO: handle edit tap
                },
                child: Text(
                  '[EDIT]',
                  style: GoogleFonts.arimo(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: darkBlue,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Name block
          Text(
            'Name',
            style: GoogleFonts.arimo(
              fontSize: 14,
              fontWeight: FontWeight.w700, // bold label
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'MR CHIMEZIE EMENIKE',
            style: GoogleFonts.arimo(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Need to change your name?',
            style: GoogleFonts.arimo(
              fontSize: 14,
              color: darkBlue,
              decoration: TextDecoration.underline,
            ),
          ),

          const SizedBox(height: 24),

          // ADDRESS
          Text(
            'Address',
            style: GoogleFonts.arimo(
              fontSize: 14,
              fontWeight: FontWeight.w700, // bold label
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '87 CORINNE ROAD\nLONDON\nN19 5HA',
            style: GoogleFonts.arimo(
              fontSize: 15,
              color: Colors.black,
              height: 1.35,
            ),
          ),

          const SizedBox(height: 24),

          // EMAIL
          Text(
            'Email',
            style: GoogleFonts.arimo(
              fontSize: 14,
              fontWeight: FontWeight.w700, // bold label
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'chimezie.emenike@gmail.com',
            style: GoogleFonts.arimo(
              fontSize: 15,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 24),

          // HOME TELEPHONE
          Text(
            'Home telephone',
            style: GoogleFonts.arimo(
              fontSize: 14,
              fontWeight: FontWeight.w700, // bold label
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 24),

          // MOBILE TELEPHONE
          Text(
            'Mobile telephone',
            style: GoogleFonts.arimo(
              fontSize: 14,
              fontWeight: FontWeight.w700, // bold label
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '07564517548',
            style: GoogleFonts.arimo(
              fontSize: 15,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 28),

          // GDPR NOTICE
          Text(
            'Under the General Data Protection Regulation (GDPR) you have the right to access personal details that we hold about you. You can download a copy of the most commonly requested information by visiting Account Settings through a web browser. If you need anything else, or would like more information about how to exercise your GDPR rights, please contact our customer service team or see our Privacy Notice.',
            style: GoogleFonts.arimo(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            // ---------- TOP BAR ----------
            Container(
              color: Colors.white,
              height: 44,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_back_ios,
                            size: 18,
                            color: Color(0xFF007AFF),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            'Back',
                            style: GoogleFonts.arimo(
                              fontSize: 16,
                              color: const Color(0xFF007AFF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Account Settings',
                      style: GoogleFonts.arimo(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFE1E1E1)),

            // ---------- LIST ----------
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 4, bottom: 16),
                children: [
                  _buildCollapsedRow('Statements & Letters preferences'),

                  _buildPersonalHeader(expanded: _personalExpanded),
                  if (_personalExpanded) _buildPersonalExpandedBody(),
                  if (_personalExpanded)
                    const SizedBox(height: 2),

                  _buildCollapsedRow('Security settings'),
                  _buildCollapsedRow('Alerts & notifications'),
                  _buildCollapsedRow('Marketing & contact preferences'),
                  _buildCollapsedRow('Credit limit preferences'),
                  _buildCollapsedRow('Third party permissions'),
                  _buildCollapsedRow('Account Closure'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
