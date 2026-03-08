import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/post.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
import '../constants/app_constants.dart';
import '../widgets/app_drawer.dart';
import '../widgets/news_card.dart';
import 'article_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final ApiService _apiService = ApiService();
  late TabController _tabController;

  static final List<Category> _tabs = [
    Category(id: 0, name: 'अर्थ खबर अपडेट', slug: 'recent'),
    Category(id: 10, name: 'अर्थ खबर विशेष', slug: 'artha-khabar-special'),
  ];

  final Map<int, List<Post>> _postsByCategory = {};
  List<Post> _recentPosts = [];
  bool _isLoading = true;
  String? _errorMessage;
  int _loadingCategoryId = -1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging && _tabController.index > 0) {
        _loadCategoryPosts(_tabs[_tabController.index].id);
      }
    });
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final recentPosts = await _apiService.getRecentPosts();
      setState(() {
        _recentPosts = recentPosts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'समाचार लोड गर्न असमर्थ: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadCategoryPosts(int categoryId) async {
    if (categoryId == 0 || _postsByCategory.containsKey(categoryId)) {
      return;
    }

    setState(() {
      _loadingCategoryId = categoryId;
    });

    try {
      final posts = await _apiService.getPostsByCategory(categoryId);
      setState(() {
        _postsByCategory[categoryId] = posts;
        _loadingCategoryId = -1;
      });
    } catch (e) {
      setState(() {
        _postsByCategory[categoryId] = [];
        _loadingCategoryId = -1;
      });
    }
  }

  List<Post> _getPostsForCategory(int categoryId) {
    if (categoryId == 0) {
      return _recentPosts;
    }
    return _postsByCategory[categoryId] ?? [];
  }

  bool _isCategoryLoading(int categoryId) {
    return _loadingCategoryId == categoryId;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.green.shade700, size: 28),
            onPressed: () => Scaffold.of(context).openDrawer(),
            style: IconButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ),
        title: _buildAppBarTitle(),
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs.map((c) => Tab(text: c.name)).toList(),
          onTap: (index) {
            if (index > 0) {
              _loadCategoryPosts(_tabs[index].id);
            }
          },
        ),
      ),
      drawer: const AppDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBarTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/logo_main.png',
            height: 44,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Text(
              'अर्थ खबर',
              style: TextStyle(
                color: AppTheme.primaryRed,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppConstants.tagline,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 10,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.play_circle_fill, size: 12, color: AppTheme.primaryRed),
              Text(
                ' Live',
                style: TextStyle(
                  color: AppTheme.primaryRed,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryRed,
                ),
                child: const Text('पुन: प्रयास गर्नुहोस्'),
              ),
            ],
          ),
        ),
      );
    }

    return TabBarView(
      controller: _tabController,
      children: _tabs.map((category) {
        return _NewsFeedView(
          categoryId: category.id,
          posts: _getPostsForCategory(category.id),
          isLoading: _isCategoryLoading(category.id),
          onLoad: () => _loadCategoryPosts(category.id),
          footer: _buildFooter(),
          onArticleTap: (post) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleScreen(post: post),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: AppTheme.primaryBlue,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Arthakhabar.com',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AppConstants.footerText,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AppConstants.copyright,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              '© ${DateTime.now().year}',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsFeedView extends StatelessWidget {
  final int categoryId;
  final List<Post> posts;
  final bool isLoading;
  final VoidCallback onLoad;
  final Widget footer;
  final ValueChanged<Post> onArticleTap;

  const _NewsFeedView({
    required this.categoryId,
    required this.posts,
    required this.isLoading,
    required this.onLoad,
    required this.footer,
    required this.onArticleTap,
  });

  @override
  Widget build(BuildContext context) {
    if (categoryId != 0 && !isLoading && posts.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => onLoad());
    }

    if (isLoading && posts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (posts.isEmpty) {
      return ListView(
        children: [
          const SizedBox(height: 48),
          const Center(child: Text('कुनै समाचार छैन')),
          const SizedBox(height: 24),
          footer,
        ],
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: posts.length + (isLoading ? 1 : 0) + 1,
      itemBuilder: (context, index) {
        if (index == posts.length) {
          if (isLoading) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return footer;
        }
        if (index == posts.length + 1) {
          return footer;
        }
        return NewsCard(
          post: posts[index],
          onTap: () => onArticleTap(posts[index]),
        );
      },
    );
  }
}
