import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// ---------------- PDF SCREEN ----------------

class AquaPdfStatementScreen extends StatefulWidget {
  final String pdfTitle; // e.g. "2025-11-06 PDF Statement"
  final String pdfUrl;   // network url

  const AquaPdfStatementScreen({
    super.key,
    required this.pdfTitle,
    required this.pdfUrl,
  });

  static const _bgGrey = Color(0xFFF2F2F7);
  static const _blue = Color(0xFF007AFF);

  @override
  State<AquaPdfStatementScreen> createState() =>
      _AquaPdfStatementScreenState();
}

class _AquaPdfStatementScreenState extends State<AquaPdfStatementScreen> {
  bool _isDownloading = false;
  String? _lastSavedPath; // latest downloaded file path

  Future<void> _downloadPdf() async {
    if (_isDownloading) return;
    try {
      setState(() => _isDownloading = true);

      final uri = Uri.parse(widget.pdfUrl);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final dir = await getApplicationDocumentsDirectory();
        final safeName = widget.pdfTitle
            .replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_');
        final file = File('${dir.path}/$safeName.pdf');

        await file.writeAsBytes(response.bodyBytes);
        _lastSavedPath = file.path;

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PDF saved: ${file.path}'),
            duration: const Duration(seconds: 3),
          ),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to download PDF (status != 200)'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Download error: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isDownloading = false);
      }
    }
  }

  Future<void> _sharePdf() async {
    // agar humne abhi download kiya hai to file share kar do
    if (_lastSavedPath != null && await File(_lastSavedPath!).exists()) {
      await Share.shareXFiles(
        [XFile(_lastSavedPath!)],
        text: widget.pdfTitle,
      );
    } else {
      // warna simple url share (ye bhi completely valid hai)
      await Share.share(
        widget.pdfUrl,
        subject: widget.pdfTitle,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AquaPdfStatementScreen._bgGrey,

      // ---------- FLOATING DOWNLOAD BUTTON ----------
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AquaPdfStatementScreen._blue,
        onPressed: _isDownloading ? null : _downloadPdf,
        icon: _isDownloading
            ? const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : const Icon(Icons.download),
        label: Text(
          _isDownloading ? 'Downloading...' : 'Download PDF',
          style: GoogleFonts.arimo(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // ---------- TOP BAR (Back + title + share) ----------
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
                        foregroundColor: AquaPdfStatementScreen._blue,
                        padding: const EdgeInsets.only(left: 8),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios, size: 18),
                      label: Text(
                        'Back',
                        style: GoogleFonts.arimo(
                          fontSize: 16,
                          color: AquaPdfStatementScreen._blue,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      widget.pdfTitle,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.arimo(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: _sharePdf, // ✅ actually share karega
                      icon: const Icon(
                        Icons.share,
                        size: 20,
                        color: AquaPdfStatementScreen._blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFE1E1E1)),

            // ---------- BODY: WHITE CARD + PDF ----------
            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: SfPdfViewer.network(
                      widget.pdfUrl,
                      canShowScrollStatus: false,
                      canShowPaginationDialog: false,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
