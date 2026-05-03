import 'package:circle_of_light/features/auth/presentation/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateJoinCircle extends ConsumerWidget {
  const CreateJoinCircle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F14),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Create or Join a Circle',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Start a new circle or join an existing one to begin your journey together.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.45),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              _buildCreateCard(ref, context),
              const SizedBox(height: 16),
              _buildJoinCard(ref, context),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreateCard(WidgetRef ref, BuildContext context) {
    return GestureDetector(
      onTap: () {
        ref.read(authNotifierProvider.notifier).setHasJoinedRoom();
        context.go('/dash');
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF0D2018),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFF2ECC71).withOpacity(0.25),
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: const Color(0xFF1A3A2A),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.group_add_outlined,
                color: Color(0xFF2ECC71),
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Circle',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Start a new circle and invite your friends.',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF2ECC71),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJoinCard(WidgetRef ref, BuildContext context) {
    return GestureDetector(
      onTap: () {
        ref.read(authNotifierProvider.notifier).setHasJoinedRoom();
        context.go('/dash');
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF0D1525),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFF3B82F6).withOpacity(0.25),
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: const Color(0xFF0F2040),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.login_rounded,
                color: Color(0xFF3B82F6),
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Join Circle',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Enter an invite code to join an existing circle.',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF3B82F6),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}