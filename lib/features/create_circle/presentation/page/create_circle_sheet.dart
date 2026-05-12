import 'package:circle_of_light/features/create_circle/presentation/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  String _level = 'Beginner';

  final _focuses = ['Tilawah', 'Hifz', 'Tadabbur', 'Tajweed'];
  // final _levels = ['Beginner', 'Intermediate', 'Advanced'];

  Future<void> handleCreateCircle() async {
    await ref
        .read(circleNotifierProvider.notifier)
        .createCircleUseCase(
          accessToken: "eyJhbGciOiJFUzI1NiIsImtpZCI6ImEzYzhjMTJiLTFkNmYtNDAxNi1iMzU4LTFlNzNhYjY5MGM0NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3F5eXZneHJ5cG9sa3R4b3djdHd1LnN1cGFiYXNlLmNvL2F1dGgvdjEiLCJzdWIiOiJlYzkzNzJiMS0wZjQ0LTQwNzYtOTNkNC0zYjdlMDc1MzNhODkiLCJhdWQiOiJhdXRoZW50aWNhdGVkIiwiZXhwIjoxNzc4NTcyNDgxLCJpYXQiOjE3Nzg1Njg4ODEsImVtYWlsIjoicmlqYXNubTg0QGdtYWlsLmNvbSIsInBob25lIjoiIiwiYXBwX21ldGFkYXRhIjp7InByb3ZpZGVyIjoiZW1haWwiLCJwcm92aWRlcnMiOlsiZW1haWwiXX0sInVzZXJfbWV0YWRhdGEiOnsiZW1haWxfdmVyaWZpZWQiOnRydWUsImZ1bGxfbmFtZSI6InJpamFzbm04NCJ9LCJyb2xlIjoiYXV0aGVudGljYXRlZCIsImFhbCI6ImFhbDEiLCJhbXIiOlt7Im1ldGhvZCI6InBhc3N3b3JkIiwidGltZXN0YW1wIjoxNzc4NTY4ODgxfV0sInNlc3Npb25faWQiOiJlNzk4NjM1NS00OGRmLTQyNjgtYjc3Zi1iOGU3MmJmYmQ0ZDYiLCJpc19hbm9ueW1vdXMiOmZhbHNlfQ.ADbmMb8oN2NoRXe0xFuO1oVT8CsmT9SAAdosXEtBKEQpLWLPOMD1dfZEh_fYVbQ0PNOiIrgBN3x64peok2lHqQ",
          name: _nameController.text,
          description: _descriptionController.text,
          focus: _focus,
          privacy: _privacy,
        );
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
