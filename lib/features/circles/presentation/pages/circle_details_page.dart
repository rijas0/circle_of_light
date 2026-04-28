import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Light Seekers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF07120A),
        fontFamily: 'Georgia',
      ),
      home: const CircleDetailsScreen(),
    );
  }
}

// ─── Data ──────────────────────────────────────────────────────────────────────

class _MemberData {
  final String name;
  final String joinDate;
  final String status;
  final int streak;
  final bool isAdmin;
  const _MemberData(this.name, this.joinDate, this.status, this.streak,
      {this.isAdmin = false});
}

const List<_MemberData> _members = [
  _MemberData('Ahmed', 'Joined 12 Apr 2025', 'Completed', 12, isAdmin: true),
  _MemberData('Fatima', 'Joined 12 Apr 2025', 'Completed', 9),
  _MemberData('Zaid', 'Joined 13 Apr 2025', 'Pending', 6),
  _MemberData('Yusuf', 'Joined 14 Apr 2025', 'Completed', 11),
  _MemberData('Ali', 'Joined 14 Apr 2025', 'Pending', 5),
  _MemberData('Hassan', 'Joined 15 Apr 2025', 'Completed', 8),
  _MemberData('Aisha', 'Joined 15 Apr 2025', 'Completed', 10),
  _MemberData('Maryam', 'Joined 16 Apr 2025', 'Pending', 7),
];

// ─── Screen ────────────────────────────────────────────────────────────────────

class CircleDetailsScreen extends StatefulWidget {
  const CircleDetailsScreen({super.key});

  @override
  State<CircleDetailsScreen> createState() => _CircleDetailsScreenState();
}

class _CircleDetailsScreenState extends State<CircleDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  List<_MemberData> _filtered = _members;
  bool _codeCopied = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, initialIndex: 1, vsync: this);
    _searchController.addListener(_onSearch);
  }

  void _onSearch() {
    final q = _searchController.text.toLowerCase();
    setState(() {
      _filtered = _members
          .where((m) => m.name.toLowerCase().contains(q))
          .toList();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _copyCode() {
    Clipboard.setData(const ClipboardData(text: 'LS7K-MN2P'));
    setState(() => _codeCopied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _codeCopied = false);
    });
  }

  // ─── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07120A),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildPlaceholder('Overview'),
                  _buildMembersTab(),
                  _buildPlaceholder('Tasks'),
                  _buildPlaceholder('Reflections'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () =>Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
          ),
          const Expanded(
            child: Text(
              'Light Seekers',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.more_horiz, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF1A3322), width: 1)),
      ),
      child: TabBar(
        controller: _tabController,
        indicatorColor: const Color(0xFF22C55E),
        indicatorWeight: 2.5,
        labelColor: const Color(0xFF22C55E),
        unselectedLabelColor: const Color(0xFF6B7280),
        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 13),
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'Members'),
          Tab(text: 'Tasks'),
          Tab(text: 'Reflections'),
        ],
      ),
    );
  }

  Widget _buildMembersTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        _buildSearchBar(),
        const SizedBox(height: 8),
        ..._filtered.asMap().entries.map((e) {
          final isLast = e.key == _filtered.length - 1;
          return _buildMemberRow(e.value, isLast: isLast);
        }),
        const SizedBox(height: 20),
        _buildInviteCard(),
        const SizedBox(height: 16),
        _buildAboutCard(),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1F13),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF1A3322), width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF4B5563), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: const InputDecoration(
                hintText: 'Search members...',
                hintStyle: TextStyle(color: Color(0xFF4B5563), fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberRow(_MemberData m, {bool isLast = false}) {
    final isCompleted = m.status == 'Completed';
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 26,
                backgroundColor: _avatarColor(m.name),
                child: Text(
                  m.name[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Name + joined
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          m.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (m.isAdmin) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF14532D),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Admin',
                              style: TextStyle(
                                color: Color(0xFF22C55E),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      m.joinDate,
                      style: const TextStyle(
                          color: Color(0xFF6B7280), fontSize: 12),
                    ),
                  ],
                ),
              ),
              // Status + streak + more
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    m.status,
                    style: TextStyle(
                      color: isCompleted
                          ? const Color(0xFF22C55E)
                          : const Color(0xFFF59E0B),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '${m.streak} ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text('🔥', style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {},
                child: const Icon(Icons.more_vert,
                    color: Color(0xFF4B5563), size: 20),
              ),
            ],
          ),
        ),
        if (!isLast)
          const Divider(
            color: Color(0xFF1A3322),
            height: 1,
            thickness: 1,
          ),
      ],
    );
  }

  Color _avatarColor(String name) {
    const colors = [
      Color(0xFF1B4332),
      Color(0xFF1A237E),
      Color(0xFF4E342E),
      Color(0xFF1B5E20),
      Color(0xFF4A148C),
      Color(0xFF006064),
      Color(0xFF37474F),
      Color(0xFF880E4F),
    ];
    return colors[name.codeUnitAt(0) % colors.length];
  }

  Widget _buildInviteCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1F13),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1A3322), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Invite to Light Seekers',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Share this code with others so they can\njoin your circle.',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          // Code box
          GestureDetector(
            onTap: _copyCode,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF07120A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF22C55E),
                  width: 1.5,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'LS7K-MN2P',
                    style: TextStyle(
                      color: Color(0xFF22C55E),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: _codeCopied
                        ? const Icon(Icons.check_circle_outline,
                            color: Color(0xFF22C55E), size: 22, key: ValueKey('check'))
                        : const Icon(Icons.copy_outlined,
                            color: Color(0xFF22C55E), size: 22, key: ValueKey('copy')),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Share button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.share_outlined, color: Colors.white, size: 18),
              label: const Text(
                'Share Invite',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF22C55E),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1F13),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1A3322), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'About this circle',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A3322),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.edit_outlined,
                      color: Color(0xFF22C55E), size: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Our goal is to grow together in Quran, support each other and stay consistent.',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 13,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 14),
          const Divider(color: Color(0xFF1A3322), height: 1),
          const SizedBox(height: 14),
          const Text(
            'Created by you  •  12 Apr 2025',
            style: TextStyle(color: Color(0xFF4B5563), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(String label) {
    return Center(
      child: Text(
        label,
        style: const TextStyle(color: Color(0xFF4B5563), fontSize: 16),
      ),
    );
  }
}