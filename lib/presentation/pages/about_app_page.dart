import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/common/constants.dart';

class AboutAppPage extends StatelessWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/about-page';

  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: success,
                  child: Center(
                    child: Hero(
                      tag: 'appLogo',
                      child: Image.asset(
                        'assets/logo-circle.jpg',
                        width: 120,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  color: warning,
                  child: const Text(
                    'Aplikasi ini merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia dan dilanjutkan oleh Jelvin Krisna Putra sebagai proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
