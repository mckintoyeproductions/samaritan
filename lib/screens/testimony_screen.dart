import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Testimony {
  final String title;
  final String description;
  final String? name;
  final DateTime submittedAt;

  Testimony({
    required this.title,
    required this.description,
    this.name,
    required this.submittedAt,
  });
}

class TestimonyScreen extends StatefulWidget {
  const TestimonyScreen({Key? key}) : super(key: key);

  @override
  State<TestimonyScreen> createState() => _TestimonyScreenState();
}

class _TestimonyScreenState extends State<TestimonyScreen> {
  final List<Testimony> _testimonies = [
    Testimony(
      title: "He Saved Me!",
      description: "I was in a serious car accident last year. By God’s mercy, I walked out without a scratch.",
      name: "Chioma",
      submittedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Testimony(
      title: "A Job After 2 Years",
      description: "After praying for 2 years, I got my dream job this week. Thank you Jesus!",
      name: null,
      submittedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _nameController = TextEditingController();

  void _submitTestimony() {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) return;

    final newTestimony = Testimony(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      name: _nameController.text.trim().isEmpty ? null : _nameController.text.trim(),
      submittedAt: DateTime.now(),
    );

    setState(() {
      _testimonies.insert(0, newTestimony);
      _titleController.clear();
      _descriptionController.clear();
      _nameController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Thank you! Your testimony was submitted.')),
    );
  }

  void _showTestimonyDetail(Testimony testimony) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(testimony.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(testimony.description),
            const SizedBox(height: 16),
            Text(
              testimony.name != null ? '- ${testimony.name}' : '- Anonymous',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat.yMMMMd().format(testimony.submittedAt),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Testimonies")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Daily Declaration or Spiritual Quote
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '"We overcome by the blood of the Lamb and the word of our testimony." — Revelation 12:11',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            // Testimonies List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _testimonies.length,
              itemBuilder: (_, index) {
                final testimony = _testimonies[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text(testimony.title),
                    subtitle: Text(
                      testimony.description.length > 80
                          ? "${testimony.description.substring(0, 80)}..."
                          : testimony.description,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _showTestimonyDetail(testimony),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),

            // Submission Form
            const Divider(),
            const Text("Share Your Testimony", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 12),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Testimony Title (Required)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "What happened? (Required)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Name (Optional)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _submitTestimony,
              icon: const Icon(Icons.check_circle),
              label: const Text("Submit Testimony"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
