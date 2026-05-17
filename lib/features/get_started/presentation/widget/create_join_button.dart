import 'package:flutter/material.dart';

import 'buildActionCard.dart';
import 'buildCreateIcon.dart';

class CreateJoinButton extends StatelessWidget {
  final VoidCallback callback;
  const CreateJoinButton({super.key,required this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Get started',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ),

      const SizedBox(height: 6),

      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Create a new circle or join an existing one.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.45),
            fontSize: 14,
          ),
        ),
      ),

      const SizedBox(height: 20),

      // Create a Circle card
      buildActionCard(
        iconWidget: buildCreateIcon(),
        title: 'Create or Join Circle',
        subtitle: 'Start a new  or join an existing circle and\ninvite your friends.',
        arrowColor: const Color(0xFF2ECC71),
        borderColor: const Color(0xFF2ECC71).withOpacity(0.25),
        backgroundColor: const Color(0xFF0D2018),
        onTap: () => callback,
      ),
    ],);
  }
}
