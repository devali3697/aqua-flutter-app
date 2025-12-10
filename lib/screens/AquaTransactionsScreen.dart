import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AquaStatementDetailScreen.dart';

class AquaTransactionsScreen extends StatefulWidget {
  const AquaTransactionsScreen({super.key});

  @override
  State<AquaTransactionsScreen> createState() =>
      _AquaTransactionsScreenState();
}

class _AquaTransactionsScreenState extends State<AquaTransactionsScreen> {
  bool _isTransactionsTab = true; // true = Transactions, false = Statements

  static const _bgGrey = Color(0xFFF2F2F7);
  static const _blue = Color(0xFF007AFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGrey,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            // ================== RECTANGULAR TABS ==================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E5EA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    // Transactions
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (!_isTransactionsTab) {
                            setState(() => _isTransactionsTab = true);
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: _isTransactionsTab
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: _isTransactionsTab
                                ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              )
                            ]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              'Transactions',
                              style: GoogleFonts.arimo(
                                fontSize: 16,
                                fontWeight: _isTransactionsTab
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Statements
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (_isTransactionsTab) {
                            setState(() => _isTransactionsTab = false);
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: !_isTransactionsTab
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: !_isTransactionsTab
                                ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              )
                            ]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              'Statements',
                              style: GoogleFonts.arimo(
                                fontSize: 16,
                                fontWeight: !_isTransactionsTab
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            // ================== BODY ==================
            Expanded(
              child: _isTransactionsTab
                  ? _buildTransactionsTab()
                  : _buildStatementsTab(),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // TRANSACTIONS TAB
  // =========================================================

  Widget _buildTransactionsTab() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(height: 12),

        // -------- Filter text --------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Filter',
            style: GoogleFonts.arimo(
              fontSize: 17,
              color: _blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8),

        const Divider(height: 1, color: Color(0xFFE1E1E1)),

        // ======== TOP WHITE SUMMARY SHEET ========
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryCard(
                amount: '£0.00',
                subtitle: 'Spent since last statement',
                rightLabel: 'Active',
              ),
              const SizedBox(height: 26),
              _buildSummaryCard(
                amount: '£4,075.00',
                subtitle: '07 Nov - 05 Dec',
                rightLabel: 'Previous',
              ),
            ],
          ),
        ),

        const SizedBox(height: 26),

        // ======== Mon, 24 Nov – Payment Received -£150.00 ========
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Mon, 24 Nov',
            style: GoogleFonts.arimo(
              fontSize: 13,
              color: const Color(0xFF8E8E93),
            ),
          ),
        ),
        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 14),
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF28CD41),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Received -',
                          style: GoogleFonts.arimo(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Thank You',
                          style: GoogleFonts.arimo(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, top: 14, bottom: 14),
                  child: Text(
                    '-£150.00',
                    style: GoogleFonts.arimo(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF28CD41),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 26),

        // ======== Sat, 09 Nov – PAYPAL PAYMENT OUT ========
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Sat, 09 Nov',
            style: GoogleFonts.arimo(
              fontSize: 13,
              color: const Color(0xFF8E8E93),
            ),
          ),
        ),
        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 14),
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF7A5CFF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.north_east,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PAYPAL',
                          style: GoogleFonts.arimo(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '*ISABELLAKELIN1',
                          style: GoogleFonts.arimo(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, top: 14, bottom: 14),
                  child: Text(
                    '£1,200.00',
                    style: GoogleFonts.arimo(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 28),

        // ======== PREVIOUS STATEMENT TOTAL – £3,012.00 ========
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: _buildSummaryCard(
              amount: '£3,012.00',
              subtitle: '07 Oct - 06 Nov',
              rightLabel: 'Previous',
            ),
          ),
        ),

        const SizedBox(height: 26),

        // ======== Thu, 05 Nov – PLAYHOUSE-MONTESSORI £864.00 ========
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Thu, 05 Nov',
            style: GoogleFonts.arimo(
              fontSize: 13,
              color: const Color(0xFF8E8E93),
            ),
          ),
        ),
        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildMerchantCard(
            title: 'PLAYHOUSE-\nMONTESSORI',
            amount: '£864.00',
          ),
        ),

        const SizedBox(height: 26),

        // ======== Fri, 24 Oct – Payment Received for £1,000 ========
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Fri, 24 Oct',
            style: GoogleFonts.arimo(
              fontSize: 13,
              color: const Color(0xFF8E8E93),
            ),
          ),
        ),
        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 14),
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF28CD41),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Received -',
                          style: GoogleFonts.arimo(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Thank You',
                          style: GoogleFonts.arimo(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, top: 14, bottom: 14),
                  child: Text(
                    '-£1,000.00',
                    style: GoogleFonts.arimo(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF28CD41),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 26),

        // ======== LAST WHITE CARD (SEE YOUR CARD DETAILS) ========
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 14),
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: _blue, width: 2),
                  ),
                  child: const Icon(
                    Icons.credit_card,
                    color: _blue,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'See your card details on\nthe go',
                          style: GoogleFonts.arimo(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'See it for free here',
                          style: GoogleFonts.arimo(
                            fontSize: 14,
                            color: const Color(0xFF8E8E93),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 32),
      ],
    );
  }

  // ===== summary row used in top + middle blocks =====
  Widget _buildSummaryCard({
    required String amount,
    required String subtitle,
    required String rightLabel,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              amount,
              style: GoogleFonts.arimo(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            const Icon(Icons.info_outline, size: 18, color: _blue),
            const SizedBox(width: 6),
            Text(
              rightLabel,
              style: GoogleFonts.arimo(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF8E8E93),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: GoogleFonts.arimo(
            fontSize: 15,
            color: const Color(0xFF8E8E93),
          ),
        ),
      ],
    );
  }

  Widget _buildMerchantCard({required String title, required String amount}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF7A5CFF),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.north_east, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Text(
                title,
                style: GoogleFonts.arimo(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              amount,
              style: GoogleFonts.arimo(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // STATEMENTS TAB
  // =========================================================

  Widget _buildStatementsTab() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(height: 24),

        // LATEST
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'LATEST',
            style: GoogleFonts.arimo(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // December
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildStatementCard('December'),
        ),

        const SizedBox(height: 32),

        // 2025
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            '2025',
            style: GoogleFonts.arimo(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // 2025 months list (Nov → Apr) inside single card  — JUNE REMOVED
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Column(
              children: [
                _StatementRowWithDivider(month: 'November', showDivider: true),
                _StatementRowWithDivider(month: 'October', showDivider: true),
                _StatementRowWithDivider(month: 'September', showDivider: true),
                _StatementRowWithDivider(month: 'August', showDivider: true),
                _StatementRowWithDivider(month: 'July', showDivider: true),
                _StatementRowWithDivider(month: 'May', showDivider: true),
                _StatementRowWithDivider(month: 'April', showDivider: false),
              ],
            ),
          ),
        ),

        const SizedBox(height: 32),
      ],
    );
  }

  // Card with tap (December)
  Widget _buildStatementCard(String month) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AquaStatementDetailScreen(
              month: month,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: _buildStatementRowInner(month),
      ),
    );
  }

  // Row used inside grouped card; parent already handles tap
  Widget _buildStatementRowInner(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.arimo(
              fontSize: 17,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
        ],
      ),
    );
  }

  // Reusable row for grouped 2025 months
  Widget _buildStatementRow(String month) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AquaStatementDetailScreen(
              month: month,
            ),
          ),
        );
      },
      child: _buildStatementRowInner(month),
    );
  }
}

// Helper widget for 2025 months with optional divider
class _StatementRowWithDivider extends StatelessWidget {
  final String month;
  final bool showDivider;

  const _StatementRowWithDivider({
    Key? key,
    required this.month,
    required this.showDivider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state =
    context.findAncestorStateOfType<_AquaTransactionsScreenState>();
    return Column(
      children: [
        if (state != null) state._buildStatementRow(month),
        if (showDivider)
          const Divider(height: 1, color: Color(0xFFE0E0E0)),
      ],
    );
  }
}
