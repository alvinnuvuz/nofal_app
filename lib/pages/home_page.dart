import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/counter_provider.dart';
import 'page_state.dart';

class HomePage extends StatelessWidget {
  final PageState pageState;
  final Function(String) onCategorySelected;
  
  const HomePage({
    super.key,
    required this.pageState,
    required this.onCategorySelected,
  });
  
  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Home'),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.surface.withOpacity(0.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning! 👋',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Selected Category: ${pageState.selectedCategory ?? "None"}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Consumer<CounterProvider>(
                        builder: (context, counter, child) {
                          return Text(
                            'Global Counter: ${counter.counter}',
                            style: Theme.of(context).textTheme.headlineMedium,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Features Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Features',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(16),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureCard(
                    context,
                    Icons.dashboard,
                    'Dashboard',
                    Colors.blue,
                    onTap: () => onCategorySelected('Dashboard'),
                  ),
                  _buildFeatureCard(
                    context,
                    Icons.analytics,
                    'Analytics',
                    Colors.green,
                    onTap: () => onCategorySelected('Analytics'),
                  ),
                  _buildFeatureCard(
                    context,
                    Icons.notifications,
                    'Notifications',
                    Colors.orange,
                    onTap: () => onCategorySelected('Notifications'),
                  ),
                  _buildFeatureCard(
                    context,
                    Icons.settings,
                    'Settings',
                    Colors.purple,
                    onTap: () => onCategorySelected('Settings'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            onPressed: counterProvider.decrement,
            backgroundColor: Colors.red,
            child: const Icon(Icons.remove, color: Colors.white),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: counterProvider.increment,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFeatureCard(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
    {VoidCallback? onTap}
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}