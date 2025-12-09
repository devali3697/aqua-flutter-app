import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

import 'AquaPdfStatementScreen.dart';

class AquaStatementDetailScreen extends StatelessWidget {
  final String month;

  const AquaStatementDetailScreen({
    super.key,
    required this.month,
  });

  static const _bgGrey = Color(0xFFF2F2F7);

  // ---- All month data here ----
  static const Map<String, _StatementData> _dataByMonth = {
    'December': _StatementData(
      balance: '£4,075.00',
      asOfText: '5th Dec',
      transactionsAndCharges: '£1,200.00',
      paymentsAndCredits: '£150.00',
    ),
    'November': _StatementData(
      balance: '£3,012.00',
      asOfText: '6th Nov',
      transactionsAndCharges: '£864.00',
      paymentsAndCredits: '£1,000.00',
    ),
    'October': _StatementData(
      balance: '£3,135.00',
      asOfText: '9th Oct',
      transactionsAndCharges: '£1,098.00',
      paymentsAndCredits: '£1,500.00',
    ),
    'September': _StatementData(
      balance: '£3,524.00',
      asOfText: '9th Sept',
      transactionsAndCharges: '£1,080.00',
      paymentsAndCredits: '£1,500.00',
    ),
    'August': _StatementData(
      balance: '£3,931.00',
      asOfText: '9th Aug',
      transactionsAndCharges: '£1,600.00',
      paymentsAndCredits: '£2,000.00',
    ),
    'July': _StatementData(
      balance: '£4,318.00',
      asOfText: '9th Jul',
      transactionsAndCharges: '£1,500.00',
      paymentsAndCredits: '£1,000.00',
    ),
    'May': _StatementData(
      balance: '£3,760.00',
      asOfText: '9th May',
      transactionsAndCharges: '£3,220.00',
      paymentsAndCredits: '£4,000.00',
    ),
    'April': _StatementData(
      balance: '£4,540.00',
      asOfText: '7th Apr',
      transactionsAndCharges: '£4,540.00',
      paymentsAndCredits: '£157.98',
    ),
  };

  @override
  Widget build(BuildContext context) {
    final data = _dataByMonth[month];

    // safety: agar kisi wajah se null ho jaye
    final balanceText = data?.balance ?? '£0.00';
    final asOfText = data?.asOfText ?? '';
    final txCharges = data?.transactionsAndCharges ?? '£0.00';
    final paymentsCredits = data?.paymentsAndCredits ?? '£0.00';

    return Scaffold(
      backgroundColor: _bgGrey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF007AFF),
                        padding: const EdgeInsets.only(left: 8),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios, size: 18),
                      label: Text(
                        'Back',
                        style: GoogleFonts.arimo(
                          fontSize: 16,
                          color: const Color(0xFF007AFF),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      month,
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

            // ---------- CONTENT ----------
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      balanceText,
                      style: GoogleFonts.arimo(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      asOfText.isEmpty
                          ? 'balance'
                          : 'balance as of $asOfText',
                      style: GoogleFonts.arimo(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // white area with two rows
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        _buildDetailRow(
                          title: 'Transactions and Charges',
                          value: txCharges,
                        ),
                        const Divider(height: 1, color: Color(0xFFE1E1E1)),
                        _buildDetailRow(
                          title: 'Payments and Credits',
                          value: paymentsCredits,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ------- Open PDF (only for December) -------
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        // ✅ Only December is allowed to open PDF
                        if (month != 'December') {
                          // do nothing at all
                          return;
                        }
                        await _openPdfFromFirebase(context);
                      },
                      child: Text(
                        'Open PDF statement',
                        style: GoogleFonts.arimo(
                          fontSize: 16,
                          color: const Color(0xFF007AFF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.arimo(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.arimo(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.chevron_right,
            size: 18,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  // --------- Firebase se active PDF URL laa ke open karna ---------
  Future<void> _openPdfFromFirebase(BuildContext context) async {
    // loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      final ref = FirebaseDatabase.instance.ref('admin_active_pdf');
      final snap = await ref.get();

      Navigator.of(context).pop(); // close loading dialog

      if (!snap.exists || snap.value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No statement PDF found. Please try again later.'),
          ),
        );
        return;
      }

      final data = Map<String, dynamic>.from(snap.value as Map);
      final url = (data['url'] ?? '').toString();

      if (url.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF URL is missing.'),
          ),
        );
        return;
      }

      // ✅ Now open viewer with Firebase URL
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => AquaPdfStatementScreen(
            pdfTitle: month, // header me month dikhayenge
            pdfUrl: url,     // Firebase se aaya hua URL
          ),
        ),
      );
    } catch (e) {
      Navigator.of(context).pop(); // close loading dialog if still open
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load statement PDF: $e'),
        ),
      );
    }
  }
}

// simple data holder
class _StatementData {
  final String balance;
  final String asOfText;
  final String transactionsAndCharges;
  final String paymentsAndCredits;

  const _StatementData({
    required this.balance,
    required this.asOfText,
    required this.transactionsAndCharges,
    required this.paymentsAndCredits,
  });
}
