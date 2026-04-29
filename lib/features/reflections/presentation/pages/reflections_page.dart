import 'package:flutter/material.dart';


class ReflectionsScreen extends StatefulWidget {
  const ReflectionsScreen({super.key});

  @override
  State<ReflectionsScreen> createState() => _ReflectionsScreenState();
}

class _ReflectionsScreenState extends State<ReflectionsScreen> {
  int _selectedTabIndex = 0; // 0 = All Reflections, 1 = My Reflections
  int _selectedFilterIndex = 0; // 0 = Latest, 1 = Popular, 2 = Ayah, 3 = My Circle

  final List<String> _mainTabs = ['All Reflections', 'My Reflections'];
  final List<String> _filters = ['Latest', 'Popular', 'Ayah', 'My Circle'];

  final List<Map<String, dynamic>> _reflections = [
    {
      'name': 'Fatima',
      'status': 'Completed',
      'time': '2h ago',
      'subtitle': 'Read Surah Yaseen',
      'content':
          '"And [remember] when the hearts were joined together by Allah\'s favor."',
      'reference': 'Quran 3:103',
      'likes': 24,
      'comments': 5,
      'avatarColor': Color(0xFF4A3728),
      'initials': 'F',
      'hasQuote': true,
    },
    {
      'name': 'Yusuf',
      'status': 'Completed',
      'time': '4h ago',
      'subtitle': 'Reflect on Ayah 10',
      'content':
          'Patience is not about waiting, it\'s about how we behave while we\'re waiting.',
      'reference': null,
      'likes': 31,
      'comments': 7,
      'avatarColor': Color(0xFF2D3E50),
      'initials': 'Y',
      'hasQuote': false,
    },
    {
      'name': 'Aisha',
      'status': 'Completed',
      'time': '6h ago',
      'subtitle': 'Read Surah Rahman',
      'content':
          'The beauty of Quran is that it talks to your heart in every situation.',
      'reference': null,
      'likes': 18,
      'comments': 3,
      'avatarColor': Color(0xFF3D2B35),
      'initials': 'A',
      'hasQuote': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _buildTabSelector(),
                    const SizedBox(height: 16),
                    _buildComposeBox(),
                    const SizedBox(height: 16),
                    _buildFilterChips(),
                    const SizedBox(height: 12),
                    ..._reflections.map((r) => _buildReflectionCard(r)),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reflections',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Share your thoughts and grow together',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.white.withOpacity(0.8),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSelector() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF152230),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Row(
        children: List.generate(_mainTabs.length, (index) {
          final isSelected = _selectedTabIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTabIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF1A3A2A)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: isSelected
                      ? Border.all(
                          color: const Color(0xFF2ECC71).withOpacity(0.3))
                      : null,
                ),
                child: Center(
                  child: Text(
                    _mainTabs[index],
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFF2ECC71)
                          : Colors.white.withOpacity(0.5),
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildComposeBox() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF152230),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.07)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildAvatar('U', const Color(0xFF2D3E50), radius: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'What did you learn from the Quran today?',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.45),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildComposeAction(Icons.format_quote_outlined, 'Add Ayah'),
              const SizedBox(width: 10),
              _buildComposeAction(Icons.image_outlined, 'Add Photo'),
              const Spacer(),
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFF2ECC71),
                  borderRadius: BorderRadius.circular(21),
                ),
                child: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComposeAction(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.6), size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = _selectedFilterIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilterIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF2ECC71)
                    : const Color(0xFF152230),
                borderRadius: BorderRadius.circular(20),
                border: isSelected
                    ? null
                    : Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Text(
                _filters[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
                  fontSize: 13,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildReflectionCard(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF152230),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              _buildAvatar(
                  data['initials'], data['avatarColor'] as Color,
                  radius: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          data['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A3A2A),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: const Color(0xFF2ECC71).withOpacity(0.4)),
                          ),
                          child: const Text(
                            'Completed',
                            style: TextStyle(
                              color: Color(0xFF2ECC71),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '· ${data['time']}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      data['subtitle'],
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.bookmark_border_rounded,
                color: Colors.white.withOpacity(0.4),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Content
          Text(
            data['content'],
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          if (data['reference'] != null) ...[
            const SizedBox(height: 4),
            Text(
              data['reference'],
              style: TextStyle(
                color: Colors.white.withOpacity(0.35),
                fontSize: 12,
              ),
            ),
          ],
          const SizedBox(height: 14),

          // Actions row
          Row(
            children: [
              _buildActionButton(
                Icons.favorite_rounded,
                '${data['likes']}',
                const Color(0xFFE74C3C),
              ),
              const SizedBox(width: 16),
              _buildActionButton(
                Icons.chat_bubble_outline_rounded,
                '${data['comments']}',
                Colors.white.withOpacity(0.5),
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(Icons.ios_share_rounded,
                      color: Colors.white.withOpacity(0.5), size: 16),
                  const SizedBox(width: 5),
                  Text(
                    'Share',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String count, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 5),
        Text(
          count,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(String initials, Color color, {double radius = 20}) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * 0.75,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}