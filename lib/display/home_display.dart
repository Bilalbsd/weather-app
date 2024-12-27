import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // Contrôleur d'animation pour la taille et la couleur
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this, // "this" fait référence à un TickerProvider ici
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _colorAnimation =
        ColorTween(begin: Colors.blueAccent, end: Colors.blue.shade700).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TP2 - Gestion du state'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Exercice 1 - BLoC
            _buildAnimatedCubeButton(
              context,
              label: 'BLoC',
              icon: Icons.history_edu,
              route: '/quiz/bloc',
            ),
            const SizedBox(height: 16.0),

            // Exercice 2 - Provider
            _buildAnimatedCubeButton(
              context,
              label: 'Provider',
              icon: Icons.settings,
              route: '/quiz/providers',
            ),
            const SizedBox(height: 16.0),

            // Exercice 3 - Weather
            _buildAnimatedCubeButton(
              context,
              label: 'Weather',
              icon: Icons.cloud,
              route: '/weather',
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour les boutons sous forme de cube avec animations
  Widget _buildAnimatedCubeButton(BuildContext context,
      {required String label, required IconData icon, required String route}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      onTapDown: (_) {
        _controller.forward(); // Démarre l'animation
      },
      onTapUp: (_) {
        _controller.reverse(); // Retour à l'état normal
      },
      onTapCancel: () {
        _controller
            .reverse(); // Retour à l'état normal si l'utilisateur annule l'appui
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                color: _colorAnimation.value,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                    offset: Offset(0, 4), // Shadow position
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: Colors.white, size: 40),
                    const SizedBox(height: 8),
                    Text(
                      label,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
