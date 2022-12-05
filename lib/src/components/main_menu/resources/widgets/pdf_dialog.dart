import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfDialog extends StatefulWidget {
  const PdfDialog({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => this,
    );
  }

  @override
  State<PdfDialog> createState() => _PdfDialogState();
}

class _PdfDialogState extends State<PdfDialog> {
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    pdfInit();
  }

  Future<void> pdfInit() async {
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: Navigator.of(context).pop,
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 50),
                shape: const CircleBorder(),
                backgroundColor: Colors.indigo,
              ),
              child: const Icon(
                Icons.clear,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Expanded(
              child: SfPdfViewer.network(
                widget.url,
                pageLayoutMode: PdfPageLayoutMode.continuous,
                enableDoubleTapZooming: true,
              ),
            ),
        ],
      ),
    );
  }
}
