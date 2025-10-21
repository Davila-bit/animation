// This is a basic Flutter widget test.
// Collaborators: Suzal Regmi, Diana Avila

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const FadingTextAnimation(),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  const FadingTextAnimation({super.key});

  @override
  State<FadingTextAnimation> createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation>
    with TickerProviderStateMixin {
  bool _isVisible = true;
  bool _isDarkMode = false;
  Color _textColor = Colors.purple;
  bool _showFrame = false;
  late AnimationController _rotationController;
  late AnimationController _fadeController;
  int _currentScreen = 0;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Text Color'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildColorOption(Colors.purple, 'Purple'),
                _buildColorOption(Colors.pink, 'Pink'),
                _buildColorOption(Colors.blue, 'Blue'),
                _buildColorOption(Colors.green, 'Green'),
                _buildColorOption(Colors.orange, 'Orange'),
                _buildColorOption(Colors.red, 'Red'),
                _buildColorOption(Colors.teal, 'Teal'),
                _buildColorOption(Colors.indigo, 'Indigo'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildColorOption(Color color, String name) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: color),
      title: Text(name),
      onTap: () {
        setState(() {
          _textColor = color;
        });
        Navigator.of(context).pop();
      },
    );
  }

  void _nextScreen() {
    setState(() {
      _currentScreen = (_currentScreen + 1) % 2;
    });
  }

  void _previousScreen() {
    setState(() {
      _currentScreen = (_currentScreen - 1 + 2) % 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Animation App'),
          backgroundColor: _isDarkMode ? Colors.purple[900] : Colors.purple[400],
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: toggleTheme,
              tooltip: 'Toggle Day/Night Mode',
            ),
            IconButton(
              icon: const Icon(Icons.palette),
              onPressed: _showColorPicker,
              tooltip: 'Change Text Color',
            ),
          ],
        ),
        body: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              _previousScreen();
            } else if (details.primaryVelocity! < 0) {
              _nextScreen();
            }
          },
          child: PageView(
            controller: PageController(initialPage: _currentScreen),
            onPageChanged: (index) {
              setState(() {
                _currentScreen = index;
              });
            },
            children: [
              _buildFirstScreen(),
              _buildSecondScreen(),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                if (_rotationController.isAnimating) {
                  _rotationController.stop();
                } else {
                  _rotationController.repeat();
                }
              },
              heroTag: "rotation",
              tooltip: 'Rotate Image',
              child: const Icon(Icons.rotate_right),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              onPressed: toggleVisibility,
              heroTag: "fade",
              tooltip: 'Toggle Fade',
              child: const Icon(Icons.play_arrow),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentScreen,
          onTap: (index) {
            setState(() {
              _currentScreen = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Screen 1',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Screen 2',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstScreen() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _isDarkMode
              ? [Colors.purple[900]!, Colors.pink[900]!]
              : [Colors.purple[100]!, Colors.pink[100]!],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Fading Text Animation
            GestureDetector(
              onTap: toggleVisibility,
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                child: Text(
                  '🐱 Purr-fect Flutter! 🐱',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _textColor,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        offset: const Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            // Image with frame toggle
            Column(
              children: [
                Container(
                  decoration: _showFrame
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _textColor,
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _textColor.withValues(alpha: 0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        )
                      : null,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(_showFrame ? 16 : 20),
                    child: Image.asset(
                      'assets/cat_image.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: _textColor.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.pets,
                            size: 100,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Show Frame: '),
                    Switch(
                      value: _showFrame,
                      onChanged: (bool value) {
                        setState(() {
                          _showFrame = value;
                        });
                      },
                      activeThumbColor: _textColor,
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            Text(
              'Swipe left/right or use bottom navigation to switch screens',
              style: TextStyle(
                fontSize: 14,
                color: _isDarkMode ? Colors.white70 : Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondScreen() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: _isDarkMode
              ? [Colors.indigo[900]!, Colors.purple[900]!]
              : [Colors.indigo[100]!, Colors.purple[100]!],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Different fading animation with longer duration
            GestureDetector(
              onTap: toggleVisibility,
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 2000), // 2 seconds
                curve: Curves.bounceInOut,
                child: Text(
                  '🌟 Meow-gical Animation! 🌟',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _textColor,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        offset: const Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            // Rotating image
            AnimatedBuilder(
              animation: _rotationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationController.value * 2.0 * 3.14159,
                  child: Container(
                    decoration: _showFrame
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _textColor,
                              width: 4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: _textColor.withValues(alpha: 0.3),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          )
                        : null,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(_showFrame ? 16 : 20),
                      child: Image.asset(
                        'assets/cat_image.png',
                        width: 180,
                        height: 180,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              color: _textColor.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.pets,
                              size: 80,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Show Frame: '),
                Switch(
                  value: _showFrame,
                  onChanged: (bool value) {
                    setState(() {
                      _showFrame = value;
                    });
                  },
                  activeThumbColor: _textColor,
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            Text(
              'This screen has a slower, bouncy fade animation!',
              style: TextStyle(
                fontSize: 16,
                color: _isDarkMode ? Colors.white70 : Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
