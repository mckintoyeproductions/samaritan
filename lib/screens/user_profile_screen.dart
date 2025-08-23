import 'package:flutter/material.dart';
import '../models/user_profile_model.dart';
import '../services/user_profile_service.dart';
import '../widgets/kyc_badge_widget.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UserProfileModel? _profile;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await UserProfileService().getUserProfile();
    setState(() {
      _profile = profile;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _profile == null
          ? const Center(child: Text("Profile not found"))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${_profile!.name ?? 'N/A'}", style: textTheme.titleMedium),
            Text("Email: ${_profile!.email ?? 'N/A'}", style: textTheme.bodyMedium),
            Text("Phone: ${_profile!.phone ?? 'N/A'}", style: textTheme.bodyMedium),
            const SizedBox(height: 8),
            KycBadgeWidget(status: _profile!.kycStatus),
            const SizedBox(height: 16),
            // Add Edit or Save Later
            ElevatedButton(
              onPressed: () {
                // Push edit screen or show snackbar
              },
              child: const Text("Update Profile"),
            )
          ],
        ),
      ),
    );
  }
}
