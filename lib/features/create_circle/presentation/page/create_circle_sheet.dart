import 'dart:developer';

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
  String? _focus = 'Tilawah';
  String? _privacy = 'Public';

  final _focuses = ['Tilawah', 'Hifz', 'Tadabbur', 'Tajweed'];
  // final _levels = ['Beginner', 'Intermediate', 'Advanced'];

  Future<void> handleCreateCircle() async {
    final notifier = ref.read(circleNotifierProvider.notifier);
    final authNotifier = ref.read(authNotifierProvider.notifier);

    final name = _nameController.text;
    final description = _descriptionController.text;
    final focus = _focus ?? 'Tilawah';
    final privacy = _privacy ?? 'Public' ;

    if (!mounted) return;

    // Save root navigator before popping (sheet context will be destroyed)
    final rootNavigator = Navigator.of(context, rootNavigator: true);

    // Close the bottom sheet immediately
    Navigator.pop(context);

    // Show loading dialog on the main screen
    showDialog(
      context: rootNavigator.context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF0F1923),
        content: Row(
          children: [
            const CircularProgressIndicator(color: Color(0xFF2ECC71)),
            const SizedBox(width: 16),
            const Text(
              'Creating your circle...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );

    final updatedState = await notifier.createCircle(
      name: name,
      description: description,
      focus: focus,
      privacy: privacy,
    );

    // Dismiss loading dialog
    if (rootNavigator.context.mounted) {
      rootNavigator.pop();
    }

    if (!rootNavigator.context.mounted) return;
    if (updatedState.error != null) {
      log('Error: ${updatedState.error}');
      ScaffoldMessenger.of(rootNavigator.context).showSnackBar(
        SnackBar(
          content: Text(
            'Circle cannot be created. Please Try again',
            style: const TextStyle(overflow: TextOverflow.ellipsis),
            maxLines: 2,
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else if (updatedState.circle != null) {
      authNotifier.setHasJoinedRoom();
      rootNavigator.context.push('/dash');
    }
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
