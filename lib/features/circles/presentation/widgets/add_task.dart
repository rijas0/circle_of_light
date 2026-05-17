import 'package:circle_of_light/features/circles/domain/entities/create_task_entity.dart';
import 'package:circle_of_light/features/circles/presentation/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTaskSheet extends ConsumerStatefulWidget {
  const AddTaskSheet();

  @override
  ConsumerState<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends ConsumerState<AddTaskSheet> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedType = 'Reading';
  DateTime? _dueDate;

  static const _types = [
    'Reading',
    'Reflection',
    'Listening',
    'Memorisation',
    'Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0F1F12),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            border: Border(top: BorderSide(color: Color(0x14FFFFFF))),
          ),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Add task',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFE8F5E9),
                ),
              ),
              const SizedBox(height: 20),

              // Task name
              _FieldLabel('Task name'),
              _SheetInput(
                controller: _nameController,
                hint: 'e.g. Read Surah Al-Kahf',
              ),
              const SizedBox(height: 14),

              // Description
              _FieldLabel('Description (optional)'),
              _SheetInput(
                controller: _descController,
                hint: 'Add a note or instruction…',
                maxLines: 3,
              ),
              const SizedBox(height: 14),

              // Type + Due date
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _FieldLabel('Type'),
                        _SheetDropdown(
                          value: _selectedType,
                          items: _types,
                          onChanged: (v) => setState(() => _selectedType = v!),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _FieldLabel('Due date'),
                        _DatePickerField(
                          value: _dueDate,
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (picked != null)
                              setState(() => _dueDate = picked);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Submit
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _nameController.text.trim().isEmpty
                      ? null
                      : _submit,
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('Add task'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF22C55E),
                    foregroundColor: const Color(0xFF0A1A0C),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {
    //TODO:Complete this update circle details screen when task created/updated/deleted
    final task = CreateTaskEntity(
      circleId: 'circleId',
      taskName: _nameController.text.trim(),
      taskDueDate: _dueDate ?? DateTime.now().add(Duration(days: 1)),
      taskDescription: _descController.text.trim(),
      taskType: _selectedType,
    );
    await ref
        .refresh(circleTaskCrudNotifierProvider.notifier)
        .createTask(task: task);
    Navigator.pop(context);
  }
}

// ── Helpers ──────────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.45)),
    ),
  );
}

class _SheetInput extends StatelessWidget {
  const _SheetInput({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
  });
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 14, color: Color(0xFFE8F5E9)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.25),
          fontSize: 14,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0x6622C55E), width: 1),
        ),
      ),
    );
  }
}

class _SheetDropdown extends StatelessWidget {
  const _SheetDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      dropdownColor: const Color(0xFF0F1F12),
      style: const TextStyle(fontSize: 14, color: Color(0xFFE8F5E9)),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 0.5,
          ),
        ),
      ),
      items: items
          .map((t) => DropdownMenuItem(value: t, child: Text(t)))
          .toList(),
    );
  }
}

class _DatePickerField extends StatelessWidget {
  const _DatePickerField({required this.value, required this.onTap});
  final DateTime? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 0.5),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_rounded,
              size: 14,
              color: Color(0xFF22C55E),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                value != null
                    ? '${value!.day}/${value!.month}/${value!.year}'
                    : 'Pick date',
                style: TextStyle(
                  fontSize: 13,
                  color: value != null
                      ? const Color(0xFFE8F5E9)
                      : Colors.white.withOpacity(0.25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
