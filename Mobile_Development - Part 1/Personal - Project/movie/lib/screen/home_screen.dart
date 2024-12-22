import 'package:flutter/material.dart';
import 'package:movie/screen/search_sreen.dart';
import 'package:movie/screen/watch_list_sreen.dart';
import 'package:movie/widgets/movie_lists/movie_section_widget.dart';
import 'package:movie/widgets/movie_lists/now_playing_movie.dart';
import 'package:movie/api/api_constants.dart';
import 'package:movie/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> _nowPlayingMovies;
  late Future<List<Movie>> _popularMovies;
  late Future<List<Movie>> _topRatedMovies;
  late Future<List<Movie>> _upcomingMovies;
  late ScrollController _scrollController; 

  int _currentIndex = 0; // Current index of the selected tab
  late ThemeMode _themeMode; // Current theme mode

    // Load saved theme from SharedPreferences
  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light; // Set theme based on saved preference
    });
  }

  // Toggle theme and save preference
  void _toggleTheme() async {
    final prefs = await SharedPreferences.getInstance(); // Initialize SharedPreferences
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
        prefs.setBool('isDarkMode', true); // Save dark mode preference
      } else {
        _themeMode = ThemeMode.light;
        prefs.setBool('isDarkMode', false); // Save light mode preference
      }
    });
  }

  @override
  void initState() {
    super.initState(); 
    _nowPlayingMovies = ApiConstants().getNowPlayingMovies(); // Initialize Future
    _popularMovies = ApiConstants().getPopularMovies(); // Initialize Future
    _topRatedMovies = ApiConstants().getTopRatedMovies(); // Initialize Future
    _upcomingMovies = ApiConstants().getUpcomingMovies(); // Initialize Future
    _scrollController = ScrollController(); // Initialize ScrollController
    _loadTheme(); // Load saved theme
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define the different screens
    final List<Widget> screens = [
      // Home Screen Content
      SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Now Playing Movies
            FutureBuilder<List<Movie>>(
              future: _nowPlayingMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No Movies Found'));
                }
                return NowPlayingMovie(nowPlayingMovies: snapshot.data!);
              },
            ),
            const SizedBox(height: 5,),
            // Popular Movies Section
            MovieSectionWidget(
              title: 'Popular Movies', 
              moviesFuture: _popularMovies,
            ),

            // Top Rated Movies Section
            MovieSectionWidget(
              title: 'Top Rated Movies', 
              moviesFuture: _topRatedMovies,
            ),

            // Upcoming Movies Section
            MovieSectionWidget(
              title: 'Upcoming', 
              moviesFuture: _upcomingMovies,
            ),
          ],
        ),
      ),

      // Search Screen
      const SearchScreen(),

      // Watchlist Screen
      const WatchlistScreen()
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      themeMode: _themeMode, // Set theme mode
      theme: ThemeData.light(), // Light theme
      darkTheme: ThemeData.dark(), // Dark theme,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          splashColor: _themeMode == ThemeMode.light
              ? Colors.white // Light mode color
              : Colors.black, // Dark mode color
          backgroundColor: _themeMode == ThemeMode.light
              ? Colors.black // Light mode color
              : Colors.white, // Dark mode color
          onPressed: _toggleTheme, // Toggle theme when pressed
          child: Icon(
            _themeMode == ThemeMode.light
                ? Icons.dark_mode_outlined // Dark mode icon
                : Icons.light_mode_outlined, // Light mode icon
            color: _themeMode == ThemeMode.light ? Colors.white : Colors.black,
          ),
        ),
        body: screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              if (_currentIndex == index && index == 0) {
                _scrollController.animateTo(
                  0.0, 
                  duration: const Duration(milliseconds: 500), 
                  curve: Curves.easeInOut,
                );
              }
              _currentIndex = index;
            });
          },
          selectedItemColor: const Color(0xffef233c), // Color for the selected item
          unselectedItemColor: Colors.grey, // Color for unselected items
      
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_rounded),
              label: 'Watchlist',
            ),
          ],
        ),
      ),
    );
  }
}
