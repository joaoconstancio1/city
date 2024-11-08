import 'package:flutter/material.dart';

class CustomErrorWidget extends StatefulWidget {
  final String message;
  final String details;
  final VoidCallback onRetry;

  const CustomErrorWidget({
    super.key,
    required this.message,
    required this.details,
    required this.onRetry,
  });

  @override
  State<CustomErrorWidget> createState() => _CustomErrorWidget();
}

class _CustomErrorWidget extends State<CustomErrorWidget> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 50,
          ),
          const SizedBox(height: 16),
          Text(
            widget.message,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: widget.onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 5,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.refresh, size: 20),
                SizedBox(width: 8),
                Text(
                  'Try Again',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              setState(() {
                _showDetails = !_showDetails;
              });
            },
            child: Text(
              _showDetails ? 'Hide Details' : 'Show Details',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.details,
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ),
            crossFadeState: _showDetails
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
