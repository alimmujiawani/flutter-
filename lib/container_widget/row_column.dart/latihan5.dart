import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Latihan5 extends StatelessWidget {
  const Latihan5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F7FC),
        foregroundColor: const Color(0xFF18243A),
        elevation: 0,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _ProfileCard(),
                  const SizedBox(height: 18),
                  _CourseCard(
                    onStart: () {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text('Selamat belajar Flutter!'),
                          ),
                        );
                    },
                  ),
                  const SizedBox(height: 18),
                  const _TechnologyLogos(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TechnologyLogos extends StatelessWidget {
  const _TechnologyLogos();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text(
            'Skill Keahlian:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F02F4),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: const [
            _SkillCard(
              label: 'Laravel',
              assetPath: 'assets/images/laravel.svg',
            ),
            _SkillCard(label: 'Tailwind', icon: Icons.wind_power_rounded),
            _SkillCard(
              label: 'Flutter',
              assetPath: 'assets/images/flutter.svg',
            ),
          ],
        ),
      ],
    );
  }
}

class _SkillCard extends StatelessWidget {
  const _SkillCard({required this.label, this.assetPath, this.icon});

  final String label;
  final String? assetPath;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      child: Container(
        width: 110,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.5),
        ),
        child: Stack(
          children: [
            Center(
              child: assetPath != null
                  ? Padding(
                      padding: const EdgeInsets.all(18),
                      child: SvgPicture.asset(assetPath!),
                    )
                  : Icon(icon, size: 52, color: const Color(0xFF38BDF8)),
            ),
            const Positioned(
              right: 4,
              top: 4,
              child: Icon(Icons.check_circle, color: Colors.blue, size: 20),
            ),
            Positioned(
              left: 6,
              right: 6,
              bottom: 5,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 30, 182),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(
              255,
              211,
              201,
              201,
            ).withValues(alpha: 0.16),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Color.fromARGB(255, 110, 108, 116),
              size: 29,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mates Power Riot',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Riot Selecta',
                  style: TextStyle(color: Color(0xFFDCE9FF), fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.notifications_none_rounded,
            color: Color(0xFFDCE9FF),
            size: 22,
          ),
        ],
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 188),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 27, 40, 176),
            Color.fromARGB(255, 79, 135, 226),
            Color.fromARGB(255, 136, 175, 206),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(
              255,
              0,
              110,
              255,
            ).withValues(alpha: 0.2),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 14,
            top: 22,
            child: Icon(
              Icons.flutter_dash_rounded,
              size: 92,
              color: Colors.white.withValues(alpha: 0.14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'BELAJAR MANDIRI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Belajar Flutter!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Bangun aplikasi mulai dari fundamental.',
                  style: TextStyle(color: Color(0xFFEAF9FF), fontSize: 13),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: onStart,
                  icon: const Icon(Icons.arrow_forward_rounded, size: 17),
                  label: const Text('Mulai Belajar'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 11,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
