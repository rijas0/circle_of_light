import 'package:flutter/material.dart';

class QuranAudioPlayer extends StatelessWidget {
  const QuranAudioPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: const BoxDecoration(
        color: Color(0xFF141E18),
        border: Border(top: BorderSide(color: Color(0xFF1E2E22), width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Al-Fatiha',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Mishary Rashid Alafasy',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.skip_previous, color: Colors.white, size: 22),
                onPressed: () {},
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF4ADE80),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.play_arrow, color: Color(0xFF0D1410), size: 28),
              ),
              IconButton(
                icon: const Icon(Icons.skip_next, color: Colors.white, size: 22),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.queue_music, color: Colors.white, size: 22),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Text('00:00', style: TextStyle(color: Color(0xFF6B7280), fontSize: 11)),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: LinearProgressIndicator(
                    value: 0,
                    backgroundColor: Color(0xFF1E2E22),
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4ADE80)),
                    minHeight: 3,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
              ),
              Text('01:40', style: TextStyle(color: Color(0xFF6B7280), fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}
