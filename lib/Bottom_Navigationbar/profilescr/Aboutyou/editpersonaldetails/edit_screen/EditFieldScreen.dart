import 'package:flutter/material.dart';

class EditFieldScreen extends StatefulWidget {
  final String fieldTitle;
  final String currentValue;

  const EditFieldScreen({
    super.key,
    required this.fieldTitle,
    required this.currentValue,
    required String title,
  });

  @override
  State<EditFieldScreen> createState() => _EditFieldScreenState();
}

class _EditFieldScreenState extends State<EditFieldScreen> {
  late TextEditingController _controller;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentValue);
  }

  void _save() async {
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(milliseconds: 600)); // simulate save
    Navigator.pop(context, _controller.text.trim());
    setState(() => _isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit ${widget.fieldTitle}"),
        actions: [
          TextButton(
            onPressed:
                _controller.text.trim().isEmpty || _isSaving ? null : _save,
            child: _isSaving
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text("Save", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: widget.fieldTitle,
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
