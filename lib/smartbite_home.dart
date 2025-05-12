import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'diaryscreen.dart'; // ✅ Import your Diary screen here

class SmartBiteHome extends StatelessWidget {
  final void Function()? onToggleTheme;

  const SmartBiteHome({super.key, this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final iconColor = theme.iconTheme.color ?? Colors.black;
    final cardColor = theme.cardColor;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.person, color: iconColor),
                  Text(
                    'SMARTBITE',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.brightness_6, color: Colors.green),
                    onPressed: onToggleTheme,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Today',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 16),

              // Calories Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 80.0,
                      lineWidth: 10.0,
                      percent: 1300 / 1800,
                      center: const Text(
                        "1,300\nRemaining",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.greenAccent, fontSize: 18),
                      ),
                      progressColor: Colors.greenAccent,
                      backgroundColor: Colors.white24,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        _StatColumn(icon: Icons.flag, label: '1800'),
                        _StatColumn(icon: Icons.restaurant, label: '500'),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Macros Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Macros",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        MacroCircle(label: "Carbohydrates", value: 195, max: 230, color: Colors.lightGreen),
                        MacroCircle(label: "Fat", value: 10, max: 50, color: Colors.orangeAccent),
                        MacroCircle(label: "Protein", value: 38, max: 100, color: Colors.purpleAccent),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Bottom icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.search, color: iconColor),
                  Icon(Icons.qr_code_scanner, color: iconColor),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavIcon(icon: Icons.dashboard, label: "Dashboard"),
                  _NavIcon(
                    icon: Icons.book,
                    label: "Diary",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DiaryScreen()),
                      );
                    },
                  ),
                  _NavIcon(icon: Icons.more_horiz, label: "More"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for Macros Circle
class MacroCircle extends StatelessWidget {
  final String label;
  final int value;
  final int max;
  final Color color;

  const MacroCircle({
    super.key,
    required this.label,
    required this.value,
    required this.max,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Column(
      children: [
        CircularPercentIndicator(
          radius: 40.0,
          lineWidth: 6.0,
          percent: value / max,
          center: Text(
            "$value / $max",
            style: TextStyle(fontSize: 10, color: textColor),
          ),
          progressColor: color,
          backgroundColor: Colors.white24,
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: textColor, fontSize: 12)),
      ],
    );
  }
}

// Widget for Stats
class _StatColumn extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatColumn({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Column(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: textColor)),
      ],
    );
  }
}

// Bottom nav icons (updated with onTap)
class _NavIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _NavIcon({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: iconColor),
          Text(label, style: TextStyle(color: textColor, fontSize: 12)),
        ],
      ),
    );
  }
}
