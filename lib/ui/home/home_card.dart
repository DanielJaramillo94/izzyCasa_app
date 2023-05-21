import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.label,
    required this.image,
    required this.route,
  });

  final String label;
  final String image;
  final String route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Tapped $label');
        context.go(route);
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: -10,
              blurRadius: 10,
              offset: const Offset(10, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.55),
              ),
            ),
            SizedBox(height: 100, child: Image.asset(image)),
          ],
        ),
      ),
    );
  }
}
