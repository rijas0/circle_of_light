import 'package:flutter/material.dart';

class JoinCircleSheet extends StatefulWidget {
  const JoinCircleSheet();

  @override
  State<JoinCircleSheet> createState() => JoinCircleSheetState();
}

class JoinCircleSheetState extends State<JoinCircleSheet> {
  final _codeController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0F1923),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header
            const Text('Join a Circle',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            Text('Enter an invite code to join',
                style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13)),
            const SizedBox(height: 24),

            // Invite Code Field
            const Text('Invite Code',
                style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF152230),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: TextField(
                controller: _codeController,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 4),
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  hintText: 'e.g. QURAN2025',
                  hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.25),
                      fontSize: 14,
                      letterSpacing: 2,
                      fontWeight: FontWeight.normal),
                  prefixIcon: Icon(Icons.vpn_key_outlined,
                      color: Colors.white.withOpacity(0.3), size: 18),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Info note
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0D2018),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF2ECC71).withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline_rounded,
                      color: Color(0xFF2ECC71), size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Ask your circle leader for the invite code.',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5), fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Join Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        setState(() => _isLoading = true);
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pop(context);
                        });
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20, height: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : const Text('Join Circle',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}