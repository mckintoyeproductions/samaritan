import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/prayer_request_model.dart';
import '../services/prayer_service.dart';

class PrayRequestScreen extends StatefulWidget {
  const PrayRequestScreen({super.key});

  @override
  State<PrayRequestScreen> createState() => _PrayRequestScreenState();
}

class _PrayRequestScreenState extends State<PrayRequestScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  Future<void> _submitPrayerRequest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final request = PrayerRequest(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      name: _nameController.text.trim().isEmpty
          ? 'Anonymous'
          : _nameController.text.trim(),
      timestamp: DateTime.now(),
    );

    try {
      await PrayerService.getPrayerRequests();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Prayer request submitted 🙏")),
      );

      _titleController.clear();
      _descriptionController.clear();
      _nameController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Prayer'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Daily Declaration: 🙏🏾 “Cast all your anxiety on Him because He cares for you.” (1 Peter 5:7)',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Prayer Title'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'Prayer Request'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Your Name (Optional)'),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _isSubmitting ? null : _submitPrayerRequest,
                icon: const Icon(Icons.send),
                label: Text(_isSubmitting ? 'Submitting...' : 'Submit Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
