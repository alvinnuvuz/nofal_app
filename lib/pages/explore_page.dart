import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/counter_provider.dart';
import 'page_state.dart';

class ExplorePage extends StatelessWidget {
  final PageState pageState;
  final Function(int) updateItemCount;
  
  const ExplorePage({
    super.key,
    required this.pageState,
    required this.updateItemCount,
  });
  
  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);
    
    final List<Map<String, dynamic>> exploreItems = [
      {
        'title': 'Trending',
        'icon': Icons.trending_up,
        'color': Colors.red,
      },
      {
        'title': 'New Releases',
        'icon': Icons.new_releases,
        'color': Colors.blue,
      },
      {
        'title': 'Categories',
        'icon': Icons.category,
        'color': Colors.green,
      },
      {
        'title': 'Favorites',
        'icon': Icons.favorite,
        'color': Colors.pink,
      },
      {
        'title': 'Recommended',
        'icon': Icons.star,
        'color': Colors.amber,
      },
      {
        'title': 'Popular',
        'icon': Icons.people,
        'color': Colors.purple,
      },
    ];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Discover New Content',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Text(
                            'Global Counter from Home: ${counterProvider.counter}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Selected Category: ${pageState.selectedCategory ?? "None"}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        updateItemCount(exploreItems[index]['count']);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              exploreItems[index]['color'].withOpacity(0.3),
                              exploreItems[index]['color'].withOpacity(0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              exploreItems[index]['icon'],
                              size: 20,
                              color: exploreItems[index]['color'],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              exploreItems[index]['title'],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: exploreItems[index]['color'],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: exploreItems.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }
}