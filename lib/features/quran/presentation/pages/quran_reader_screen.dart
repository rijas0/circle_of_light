import 'package:flutter/material.dart';

import '../../domain/entities/surah.dart';
import '../../domain/entities/ayah.dart';
import '../widgets/ayah_row.dart';
import '../widgets/quran_audio_player.dart';

class QuranReaderScreen extends StatefulWidget {
  const QuranReaderScreen({super.key, required this.surah});

  final Surah surah;

  @override
  State<QuranReaderScreen> createState() => _QuranReaderScreenState();
}

class _QuranReaderScreenState extends State<QuranReaderScreen> {
  late List<Ayah> _ayahs;

  @override
  void initState() {
    super.initState();
    _ayahs = _getAyahsForSurah(widget.surah.number);
  }

  List<Ayah> _getAyahsForSurah(int surahNumber) {
    const allAyahs = {
      1: [
        Ayah(number: 1, arabicText: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ', englishTranslation: 'In the name of Allah, the Entirely Merciful, the Especially Merciful.'),
        Ayah(number: 2, arabicText: 'ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَٰلَمِينَ', englishTranslation: 'All praise is for Allah—Lord of all worlds.'),
        Ayah(number: 3, arabicText: 'ٱلرَّحْمَٰنِ ٱلرَّحِيمِ', englishTranslation: 'The Entirely Merciful, the Especially Merciful.'),
        Ayah(number: 4, arabicText: 'مَٰلِكِ يَوْمِ ٱلدِّينِ', englishTranslation: 'Sovereign of the Day of Recompense.'),
        Ayah(number: 5, arabicText: 'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ', englishTranslation: 'It is You we worship and You we ask for help.'),
        Ayah(number: 6, arabicText: 'ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَ', englishTranslation: 'Guide us to the straight path.'),
        Ayah(number: 7, arabicText: 'صِرَٰطَ ٱلَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ ٱلْمَغْضُوبِ عَلَيْهِمْ وَلَا ٱلضَّآلِّينَ', englishTranslation: 'The path of those upon whom You have bestowed favor, not of those who have evoked [Your] anger or of those who are astray.'),
      ],
    };
    return allAyahs[surahNumber] ?? const [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1410),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSurahSelector(),
            Expanded(child: _buildAyahList()),
            const QuranAudioPlayer(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          const Expanded(
            child: Text(
              'Quran',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Icon(Icons.bookmark_border, color: Colors.white, size: 24),
          const SizedBox(width: 16),
          const Icon(Icons.settings, color: Colors.white, size: 24),
        ],
      ),
    );
  }

  Widget _buildSurahSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF141E18),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF1E2E22), width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: Color(0xFF1E2E22), width: 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.surah.name,
                      style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    const Icon(Icons.expand_more, color: Color(0xFF6B7280), size: 18),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Juz 1',
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    const Icon(Icons.expand_more, color: Color(0xFF6B7280), size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAyahList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _ayahs.length,
      itemBuilder: (context, index) {
        final ayah = _ayahs[index];
        return AyahRow(ayah: ayah, isFirst: index == 0, isLast: index == _ayahs.length - 1);
      },
    );
  }
}
