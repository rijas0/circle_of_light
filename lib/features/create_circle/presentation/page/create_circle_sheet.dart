import 'package:circle_of_light/features/auth/presentation/providers/provider.dart';
import 'package:circle_of_light/features/create_circle/presentation/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateCircleSheet extends ConsumerStatefulWidget {
  const CreateCircleSheet({super.key});
  @override
  ConsumerState<CreateCircleSheet> createState() => CreateCircleSheetState();
}

class CreateCircleSheetState extends ConsumerState<CreateCircleSheet> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _focus = 'Tilawah';
  String _privacy = 'Public';

  final _focuses = ['Tilawah', 'Hifz', 'Tadabbur', 'Tajweed'];
  // final _levels = ['Beginner', 'Intermediate', 'Advanced'];

  Future<void> handleCreateCircle() async {
    final messenger = ScaffoldMessenger.of(context);
    if (mounted) {
      Navigator.pop(context);
    }
    // final notifier = ref.read(circleNotifierProvider.notifier);
    // await notifier.createCircle(
    //   accessToken: "eyJhbGciOiJFUzI1NiIsImtpZCI6ImEzYzhjMTJiLTFkNmYtNDAxNi1iMzU4LTFlNzNhYjY5MGM0NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3F5eXZneHJ5cG9sa3R4b3djdHd1LnN1cGFiYXNlLmNvL2F1dGgvdjEiLCJzdWIiOiJlYzkzNzJiMS0wZjQ0LTQwNzYtOTNkNC0zYjdlMDc1MzNhODkiLCJhdWQiOiJhdXRoZW50aWNhdGVkIiwiZXhwIjoxNzc4NTgxNTk0LCJpYXQiOjE3Nzg1Nzc5OTQsImVtYWlsIjoicmlqYXNubTg0QGdtYWlsLmNvbSIsInBob25lIjoiIiwiYXBwX21ldGFkYXRhIjp7InByb3ZpZGVyIjoiZW1haWwiLCJwcm92aWRlcnMiOlsiZW1haWwiXX0sInVzZXJfbWV0YWRhdGEiOnsiZW1haWxfdmVyaWZpZWQiOnRydWUsImZ1bGxfbmFtZSI6InJpamFzbm04NCJ9LCJyb2xlIjoiYXV0aGVudGljYXRlZCIsImFhbCI6ImFhbDEiLCJhbXIiOlt7Im1ldGhvZCI6InBhc3N3b3JkIiwidGltZXN0YW1wIjoxNzc4NTc3OTk0fV0sInNlc3Npb25faWQiOiJmNDEyYzNmYS03MWZkLTRjYzctYTA0Ni1iMWZjY2U1MzMzMjciLCJpc19hbm9ueW1vdXMiOmZhbHNlfQ.SCMne7lhx5p1Ktfk69brX3M6yLsFWw3j37rxqikK7HE-8qF34U8Kcn_YWVGYqI7daVc6M9qwLJn1VgoUznpp_A",
    //   name: _nameController.text,
    //   description: _descriptionController.text,
    //   focus: _focus,
    //   privacy: _privacy,
    // );
    

    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C63FF).withOpacity(0.25),
              blurRadius: 40,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated icon container
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF95E9B8), Color(0xFF3B3B3B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.meeting_room_rounded,
                color: Colors.white,
                size: 34,
              ),
            ),

            const SizedBox(height: 20),

            // Title
            const Text(
              'Creating Your Circle',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),

            const SizedBox(height: 8),

            // Subtitle
            Text(
              'Setting up your space, just a moment...',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 13.5,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 28),

            // Progress indicator
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: LinearProgressIndicator(
                minHeight: 4,
                backgroundColor: Colors.white.withOpacity(0.08),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF2ECC71),
                ),
              ),
            ),

            const SizedBox(height: 14),

            Text(
              'Please do not close the app',
              style: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 11.5,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
      },
    );
    final circleState = ref.read(circleNotifierProvider);
    if (circleState.error != null) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            circleState.error!,
            style: TextStyle(overflow: TextOverflow.ellipsis),
            maxLines: 2,
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else if (circleState.circle != null) {
      // ref.read(authNotifierProvider.notifier).setHasJoinedRoom();
      // context.go('/dash');
    }
    // await Future.delayed(Duration(seconds: 10));
    // if(mounted) Navigator.pop(context);
    ref.read(authNotifierProvider.notifier).setHasJoinedRoom();
    if(mounted) context.push('/dash');
  }

  @override
  Widget build(BuildContext context) {
    final cstate = ref.read(circleNotifierProvider);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0F1923),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Title
              const Text(
                'Create a Circle',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Set up your Quran study circle',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),

              // Circle Name
              _label('Circle Name'),
              const SizedBox(height: 8),
              _textField(
                _nameController,
                'e.g. Surah Al-Kahf Friday Circle',
                Icons.circle_outlined,
                14,
              ),
              const SizedBox(height: 20),

              _label('Circle Description'),
              const SizedBox(height: 8),
              _textField(
                _descriptionController,
                'e.g. Surah Al-Kahf Friday Circle',
                Icons.info,
                24,
              ),
              const SizedBox(height: 20),

              // Focus
              _label('Focus / Purpose'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _focuses
                    .map(
                      (f) => _chip(
                        f,
                        _focus == f,
                        () => setState(() => _focus = f),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),

              // Level
              // _label('Level'),
              // const SizedBox(height: 8),
              // Wrap(
              //   spacing: 8,
              //   children: _levels.map((l) => _chip(l, _level == l, () => setState(() => _level = l))).toList(),
              // ),
              // const SizedBox(height: 20),

              // Privacy
              _label('Privacy'),
              const SizedBox(height: 8),
              Row(
                children: [
                  _privacyOption('Public', Icons.public_rounded),
                  const SizedBox(width: 10),
                  _privacyOption('Private', Icons.lock_outline_rounded),
                ],
              ),
              const SizedBox(height: 28),

              // Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => handleCreateCircle(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2ECC71),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: cstate.isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          'Create Circle',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Text(
    text,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 13,
      fontWeight: FontWeight.w600,
    ),
  );

  Widget _textField(
    TextEditingController ctrl,
    String hint,
    IconData icon,
    double padding,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF152230),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: TextField(
        controller: ctrl,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.28),
            fontSize: 13,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(0.3),
            size: 18,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: padding,
          ),
        ),
      ),
    );
  }

  Widget _chip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF1A3A2A) : const Color(0xFF152230),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? const Color(0xFF2ECC71).withOpacity(0.6)
                : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected
                ? const Color(0xFF2ECC71)
                : Colors.white.withOpacity(0.5),
            fontSize: 13,
            fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _privacyOption(String label, IconData icon) {
    final selected = _privacy == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _privacy = label),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF1A3A2A) : const Color(0xFF152230),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? const Color(0xFF2ECC71).withOpacity(0.5)
                  : Colors.white.withOpacity(0.08),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: selected
                    ? const Color(0xFF2ECC71)
                    : Colors.white.withOpacity(0.35),
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: selected
                      ? const Color(0xFF2ECC71)
                      : Colors.white.withOpacity(0.5),
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
