import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/counter_provider.dart';
import 'page_state.dart';

class ProfilePage extends StatefulWidget {
  final PageState pageState;
  final Function(Map<String, dynamic>) updatePreferences;
  
  const ProfilePage({
    super.key,
    required this.pageState,
    required this.updatePreferences,
  });
  
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _darkMode = false;
  bool _notifications = true;
  
  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1494790108755-2616b786d4d9?w=400&h=400&fit=crop',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Sarah Johnson',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'sarah.johnson@email.com',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Stats
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(context, '128', 'Posts'),
                      _buildStatItem(context, '${counterProvider.counter}', 'Global Counter'),
                      _buildStatItem(context, '456', 'Following'),
                    ],
                  ),
                ),
              ),
            ),
            
            // Shared State Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shared State Information',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text('Selected Category: ${widget.pageState.selectedCategory ?? "None"}'),
                      Text('Item Count: ${widget.pageState.itemCount ?? 0}'),
                      const SizedBox(height: 12),
                      Consumer<CounterProvider>(
                        builder: (context, counter, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Global Counter: ${counter.counter}'),
                              ElevatedButton(
                                onPressed: counter.reset,
                                child: const Text('Reset Counter'),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Settings
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildProfileOption(
                    context,
                    Icons.person_outline,
                    'Edit Profile',
                    Icons.chevron_right,
                  ),
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    subtitle: const Text('Enable dark theme'),
                    value: _darkMode,
                    onChanged: (value) {
                      setState(() {
                        _darkMode = value;
                        widget.updatePreferences({'darkMode': value});
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Notifications'),
                    subtitle: const Text('Receive notifications'),
                    value: _notifications,
                    onChanged: (value) {
                      setState(() {
                        _notifications = value;
                        widget.updatePreferences({'notifications': value});
                      });
                    },
                  ),
                  _buildProfileOption(
                    context,
                    Icons.settings_outlined,
                    'Settings',
                    Icons.chevron_right,
                  ),
                  _buildProfileOption(
                    context,
                    Icons.logout,
                    'Logout',
                    Icons.chevron_right,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProfileOption(
    BuildContext context,
    IconData icon,
    String title,
    IconData trailingIcon, {
    Color? color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (color ?? Theme.of(context).colorScheme.primary)
                .withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: color ?? Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          trailingIcon,
          color: Colors.grey,
        ),
        onTap: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: Colors.grey[50],
      ),
    );
  }
  
  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}