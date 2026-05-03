import 'package:flutter/material.dart';

import '../../domain/entities/surah.dart';
import '../widgets/surah_list_item.dart';
import 'quran_reader_screen.dart';

class AllSurahsScreen extends StatefulWidget {
  const AllSurahsScreen({super.key});

  @override
  State<AllSurahsScreen> createState() => _AllSurahsScreenState();
}

class _AllSurahsScreenState extends State<AllSurahsScreen> {
  int _selectedIndex = 0;
  String _searchQuery = '';

  static const _tabs = ['All', 'Makki', 'Madani', 'Juz', 'Page'];

  final List<Surah> _allSurahs = [
    const Surah(number: 1, name: 'Al-Fatihah', englishName: 'The Opening', arabicName: 'الفَاتِحَة', verseCount: 7, revelationType: RevelationType.makki),
    const Surah(number: 2, name: 'Al-Baqarah', englishName: 'The Cow', arabicName: 'البَقَرَة', verseCount: 286, revelationType: RevelationType.madani),
    const Surah(number: 3, name: 'Aal-Imran', englishName: 'The Family of Imran', arabicName: 'آل عِمْرَان', verseCount: 200, revelationType: RevelationType.madani),
    const Surah(number: 4, name: 'An-Nisa', englishName: 'The Women', arabicName: 'النِّسَاء', verseCount: 176, revelationType: RevelationType.madani),
    const Surah(number: 5, name: 'Al-Ma\'idah', englishName: 'The Table Spread', arabicName: 'المَائِدَة', verseCount: 120, revelationType: RevelationType.madani),
    const Surah(number: 6, name: 'Al-An\'am', englishName: 'The Cattle', arabicName: 'الأَنْعَام', verseCount: 165, revelationType: RevelationType.makki),
    const Surah(number: 7, name: 'Al-A\'raf', englishName: 'The Heights', arabicName: 'الأعْرَاف', verseCount: 206, revelationType: RevelationType.makki),
    const Surah(number: 8, name: 'Al-Anfal', englishName: 'The Spoils of War', arabicName: 'الأَنفَال', verseCount: 75, revelationType: RevelationType.madani),
    const Surah(number: 9, name: 'At-Tawbah', englishName: 'The Repentance', arabicName: 'التَّوْبَة', verseCount: 129, revelationType: RevelationType.madani),
    const Surah(number: 10, name: 'Yunus', englishName: 'Jonah', arabicName: 'يُونُس', verseCount: 109, revelationType: RevelationType.makki),
    const Surah(number: 11, name: 'Hud', englishName: 'Hud', arabicName: 'هُود', verseCount: 123, revelationType: RevelationType.makki),
    const Surah(number: 12, name: 'Yusuf', englishName: 'Joseph', arabicName: 'يُوسُف', verseCount: 111, revelationType: RevelationType.makki),
    const Surah(number: 13, name: 'Ar-Ra\'d', englishName: 'The Thunder', arabicName: 'الرَّعْد', verseCount: 43, revelationType: RevelationType.madani),
    const Surah(number: 14, name: 'Ibrahim', englishName: 'Abraham', arabicName: 'إِبْرَاهِيم', verseCount: 52, revelationType: RevelationType.makki),
    const Surah(number: 15, name: 'Al-Hijr', englishName: 'The Rocky Tract', arabicName: 'الحِجْر', verseCount: 99, revelationType: RevelationType.makki),
    const Surah(number: 16, name: 'An-Nahl', englishName: 'The Bee', arabicName: 'النَّحْل', verseCount: 128, revelationType: RevelationType.makki),
    const Surah(number: 17, name: 'Al-Isra', englishName: 'The Night Journey', arabicName: 'الإِسْرَاء', verseCount: 111, revelationType: RevelationType.makki),
    const Surah(number: 18, name: 'Al-Kahf', englishName: 'The Cave', arabicName: 'الكَهْف', verseCount: 110, revelationType: RevelationType.makki),
    const Surah(number: 19, name: 'Maryam', englishName: 'Mary', arabicName: 'مَرْيَم', verseCount: 98, revelationType: RevelationType.makki),
    const Surah(number: 20, name: 'Taha', englishName: 'Ta-Ha', arabicName: 'طه', verseCount: 135, revelationType: RevelationType.makki),
    const Surah(number: 21, name: 'Al-Anbiya', englishName: 'The Prophets', arabicName: 'الأَنْبِيَاء', verseCount: 112, revelationType: RevelationType.makki),
    const Surah(number: 22, name: 'Al-Hajj', englishName: 'The Pilgrimage', arabicName: 'الحَجّ', verseCount: 78, revelationType: RevelationType.madani),
    const Surah(number: 23, name: 'Al-Mu\'minun', englishName: 'The Believers', arabicName: 'المُؤْمِنُون', verseCount: 118, revelationType: RevelationType.makki),
    const Surah(number: 24, name: 'An-Nur', englishName: 'The Light', arabicName: 'النُّور', verseCount: 64, revelationType: RevelationType.madani),
    const Surah(number: 25, name: 'Al-Furqan', englishName: 'The Criterion', arabicName: 'الفُرْقَان', verseCount: 77, revelationType: RevelationType.makki),
    const Surah(number: 26, name: 'Ash-Shu\'ara', englishName: 'The Poets', arabicName: 'الشُّعَرَاء', verseCount: 227, revelationType: RevelationType.makki),
    const Surah(number: 27, name: 'An-Naml', englishName: 'The Ant', arabicName: 'النَّمْل', verseCount: 93, revelationType: RevelationType.makki),
    const Surah(number: 28, name: 'Al-Qasas', englishName: 'The Stories', arabicName: 'القَصَص', verseCount: 88, revelationType: RevelationType.makki),
    const Surah(number: 29, name: 'Al-Ankabut', englishName: 'The Spider', arabicName: 'العَنْكَبُوت', verseCount: 69, revelationType: RevelationType.makki),
    const Surah(number: 30, name: 'Ar-Rum', englishName: 'The Romans', arabicName: 'الرُّوم', verseCount: 60, revelationType: RevelationType.makki),
    const Surah(number: 31, name: 'Luqman', englishName: 'Luqman', arabicName: 'لُقْمَان', verseCount: 34, revelationType: RevelationType.makki),
    const Surah(number: 32, name: 'As-Sajdah', englishName: 'The Prostration', arabicName: 'السَّجْدَة', verseCount: 30, revelationType: RevelationType.makki),
    const Surah(number: 33, name: 'Al-Ahzab', englishName: 'The Combined Forces', arabicName: 'الأحْزَاب', verseCount: 73, revelationType: RevelationType.madani),
    const Surah(number: 34, name: 'Saba', englishName: 'Sheba', arabicName: 'سَبَأ', verseCount: 54, revelationType: RevelationType.makki),
    const Surah(number: 35, name: 'Fatir', englishName: 'Originator', arabicName: 'فَاطِر', verseCount: 45, revelationType: RevelationType.makki),
    const Surah(number: 36, name: 'Ya-Sin', englishName: 'Ya-Sin', arabicName: 'يس', verseCount: 83, revelationType: RevelationType.makki),
    const Surah(number: 37, name: 'As-Saffat', englishName: 'Those in Ranks', arabicName: 'الصَّافَّات', verseCount: 182, revelationType: RevelationType.makki),
    const Surah(number: 38, name: 'Sad', englishName: 'Sad', arabicName: 'ص', verseCount: 88, revelationType: RevelationType.makki),
    const Surah(number: 39, name: 'Az-Zumar', englishName: 'The Groups', arabicName: 'الزُّمَر', verseCount: 75, revelationType: RevelationType.makki),
    const Surah(number: 40, name: 'Ghafir', englishName: 'The Forgiver', arabicName: 'غَافِر', verseCount: 85, revelationType: RevelationType.makki),
    const Surah(number: 41, name: 'Fussilat', englishName: 'Explained in Detail', arabicName: 'فُصِّلَت', verseCount: 54, revelationType: RevelationType.makki),
    const Surah(number: 42, name: 'Ash-Shura', englishName: 'The Consultation', arabicName: 'الشُّورَى', verseCount: 53, revelationType: RevelationType.makki),
    const Surah(number: 43, name: 'Az-Zukhruf', englishName: 'The Gold Adornments', arabicName: 'الزُّخْرُف', verseCount: 89, revelationType: RevelationType.makki),
    const Surah(number: 44, name: 'Ad-Dukhan', englishName: 'The Smoke', arabicName: 'الدُّخَان', verseCount: 59, revelationType: RevelationType.makki),
    const Surah(number: 45, name: 'Al-Jathiyah', englishName: 'The Kneeling', arabicName: 'الجَاثِيَة', verseCount: 37, revelationType: RevelationType.makki),
    const Surah(number: 46, name: 'Al-Ahqaf', englishName: 'The Wind-Curved Sandhills', arabicName: 'الأحْقَاف', verseCount: 35, revelationType: RevelationType.makki),
    const Surah(number: 47, name: 'Muhammad', englishName: 'Muhammad', arabicName: 'مُحَمَّد', verseCount: 38, revelationType: RevelationType.madani),
    const Surah(number: 48, name: 'Al-Fath', englishName: 'The Victory', arabicName: 'الفَتْح', verseCount: 29, revelationType: RevelationType.madani),
    const Surah(number: 49, name: 'Al-Hujurat', englishName: 'The Rooms', arabicName: 'الحُجُرَات', verseCount: 18, revelationType: RevelationType.madani),
    const Surah(number: 50, name: 'Qaf', englishName: 'Qaf', arabicName: 'ق', verseCount: 45, revelationType: RevelationType.makki),
    const Surah(number: 51, name: 'Adh-Dhariyat', englishName: 'The Winnowing Winds', arabicName: 'الذَّارِيَات', verseCount: 60, revelationType: RevelationType.makki),
    const Surah(number: 52, name: 'At-Tur', englishName: 'The Mount', arabicName: 'الطُّور', verseCount: 49, revelationType: RevelationType.makki),
    const Surah(number: 53, name: 'An-Najm', englishName: 'The Star', arabicName: 'النَّجْم', verseCount: 62, revelationType: RevelationType.makki),
    const Surah(number: 54, name: 'Al-Qamar', englishName: 'The Moon', arabicName: 'القَمَر', verseCount: 55, revelationType: RevelationType.makki),
    const Surah(number: 55, name: 'Ar-Rahman', englishName: 'The Beneficent', arabicName: 'الرَّحْمَن', verseCount: 78, revelationType: RevelationType.madani),
    const Surah(number: 56, name: 'Al-Waqi\'ah', englishName: 'The Inevitable', arabicName: 'الوَاقِعَة', verseCount: 96, revelationType: RevelationType.makki),
    const Surah(number: 57, name: 'Al-Hadid', englishName: 'The Iron', arabicName: 'الحَدِيد', verseCount: 29, revelationType: RevelationType.madani),
    const Surah(number: 58, name: 'Al-Mujadila', englishName: 'The Pleading Woman', arabicName: 'المُجَادِلَة', verseCount: 22, revelationType: RevelationType.madani),
    const Surah(number: 59, name: 'Al-Hashr', englishName: 'The Exile', arabicName: 'الحَشْر', verseCount: 24, revelationType: RevelationType.madani),
    const Surah(number: 60, name: 'Al-Mumtahanah', englishName: 'She That Is Examined', arabicName: 'المُمْتَحَنَة', verseCount: 13, revelationType: RevelationType.madani),
    const Surah(number: 61, name: 'As-Saff', englishName: 'The Ranks', arabicName: 'الصَّفّ', verseCount: 14, revelationType: RevelationType.madani),
    const Surah(number: 62, name: 'Al-Jumu\'ah', englishName: 'The Congregation', arabicName: 'الجُمُعَة', verseCount: 11, revelationType: RevelationType.madani),
    const Surah(number: 63, name: 'Al-Munafiqun', englishName: 'The Hypocrites', arabicName: 'المُنَافِقُون', verseCount: 11, revelationType: RevelationType.madani),
    const Surah(number: 64, name: 'At-Taghabun', englishName: 'The Mutual Disillusion', arabicName: 'التَّغَابُن', verseCount: 18, revelationType: RevelationType.madani),
    const Surah(number: 65, name: 'At-Talaq', englishName: 'The Divorce', arabicName: 'الطَّلَاق', verseCount: 12, revelationType: RevelationType.madani),
    const Surah(number: 66, name: 'At-Tahrim', englishName: 'The Prohibition', arabicName: 'التَّحْرِيم', verseCount: 12, revelationType: RevelationType.madani),
    const Surah(number: 67, name: 'Al-Mulk', englishName: 'The Sovereignty', arabicName: 'المُلْك', verseCount: 30, revelationType: RevelationType.makki),
    const Surah(number: 68, name: 'Al-Qalam', englishName: 'The Pen', arabicName: 'القَلَم', verseCount: 52, revelationType: RevelationType.makki),
    const Surah(number: 69, name: 'Al-Haqqah', englishName: 'The Reality', arabicName: 'الحَاقَّة', verseCount: 52, revelationType: RevelationType.makki),
    const Surah(number: 70, name: 'Al-Ma\'arij', englishName: 'The Ascending Stairways', arabicName: 'المَعَارِج', verseCount: 44, revelationType: RevelationType.makki),
    const Surah(number: 71, name: 'Nuh', englishName: 'Noah', arabicName: 'نُوح', verseCount: 28, revelationType: RevelationType.makki),
    const Surah(number: 72, name: 'Al-Jinn', englishName: 'The Jinn', arabicName: 'الجِنّ', verseCount: 28, revelationType: RevelationType.makki),
    const Surah(number: 73, name: 'Al-Muzzammil', englishName: 'The Enshrouded One', arabicName: 'المُزَّمِّل', verseCount: 20, revelationType: RevelationType.makki),
    const Surah(number: 74, name: 'Al-Muddaththir', englishName: 'The Cloaked One', arabicName: 'المُدَّثِّر', verseCount: 56, revelationType: RevelationType.makki),
    const Surah(number: 75, name: 'Al-Qiyamah', englishName: 'The Resurrection', arabicName: 'القِيَامَة', verseCount: 40, revelationType: RevelationType.makki),
    const Surah(number: 76, name: 'Al-Insan', englishName: 'The Man', arabicName: 'الإِنسَان', verseCount: 31, revelationType: RevelationType.madani),
    const Surah(number: 77, name: 'Al-Mursalat', englishName: 'The Emissaries', arabicName: 'المُرْسَلَات', verseCount: 50, revelationType: RevelationType.makki),
    const Surah(number: 78, name: 'An-Naba', englishName: 'The Tidings', arabicName: 'النَّبَأ', verseCount: 40, revelationType: RevelationType.makki),
    const Surah(number: 79, name: 'An-Nazi\'at', englishName: 'Those Who Drag Forth', arabicName: 'النَّازِعَات', verseCount: 46, revelationType: RevelationType.makki),
    const Surah(number: 80, name: 'Abasa', englishName: 'He Frowned', arabicName: 'عَبَسَ', verseCount: 42, revelationType: RevelationType.makki),
    const Surah(number: 81, name: 'At-Takwir', englishName: 'The Overthrowing', arabicName: 'التَّكْوِير', verseCount: 29, revelationType: RevelationType.makki),
    const Surah(number: 82, name: 'Al-Infitar', englishName: 'The Cleaving', arabicName: 'الانْفِطَار', verseCount: 19, revelationType: RevelationType.makki),
    const Surah(number: 83, name: 'Al-Mutaffifin', englishName: 'The Defrauding', arabicName: 'المُطَفِّفِين', verseCount: 36, revelationType: RevelationType.makki),
    const Surah(number: 84, name: 'Al-Inshiqaq', englishName: 'The Splitting Open', arabicName: 'الانشِقَاق', verseCount: 25, revelationType: RevelationType.makki),
    const Surah(number: 85, name: 'Al-Buruj', englishName: 'The Mansions of the Stars', arabicName: 'البُرُوج', verseCount: 22, revelationType: RevelationType.makki),
    const Surah(number: 86, name: 'At-Tariq', englishName: 'The Morning Star', arabicName: 'الطَّارِق', verseCount: 17, revelationType: RevelationType.makki),
    const Surah(number: 87, name: 'Al-A\'la', englishName: 'The Most High', arabicName: 'الأعْلَى', verseCount: 19, revelationType: RevelationType.makki),
    const Surah(number: 88, name: 'Al-Ghashiyah', englishName: 'The Overwhelming', arabicName: 'الغَاشِيَة', verseCount: 26, revelationType: RevelationType.makki),
    const Surah(number: 89, name: 'Al-Fajr', englishName: 'The Dawn', arabicName: 'الفَجْر', verseCount: 30, revelationType: RevelationType.makki),
    const Surah(number: 90, name: 'Al-Balad', englishName: 'The City', arabicName: 'البَلَد', verseCount: 20, revelationType: RevelationType.makki),
    const Surah(number: 91, name: 'Ash-Shams', englishName: 'The Sun', arabicName: 'الشَّمْس', verseCount: 15, revelationType: RevelationType.makki),
    const Surah(number: 92, name: 'Al-Layl', englishName: 'The Night', arabicName: 'اللَّيْل', verseCount: 21, revelationType: RevelationType.makki),
    const Surah(number: 93, name: 'Ad-Duha', englishName: 'The Morning Hours', arabicName: 'الضُّحَى', verseCount: 11, revelationType: RevelationType.makki),
    const Surah(number: 94, name: 'Ash-Sharh', englishName: 'The Relief', arabicName: 'الشَّرْح', verseCount: 8, revelationType: RevelationType.makki),
    const Surah(number: 95, name: 'At-Tin', englishName: 'The Fig', arabicName: 'التِّين', verseCount: 8, revelationType: RevelationType.makki),
    const Surah(number: 96, name: 'Al-Alaq', englishName: 'The Clot', arabicName: 'العَلَق', verseCount: 19, revelationType: RevelationType.makki),
    const Surah(number: 97, name: 'Al-Qadr', englishName: 'The Power', arabicName: 'القَدْر', verseCount: 5, revelationType: RevelationType.makki),
    const Surah(number: 98, name: 'Al-Bayyinah', englishName: 'The Clear Proof', arabicName: 'البَيِّنَة', verseCount: 8, revelationType: RevelationType.madani),
    const Surah(number: 99, name: 'Az-Zalzalah', englishName: 'The Earthquake', arabicName: 'الزَّلْزَلَة', verseCount: 8, revelationType: RevelationType.madani),
    const Surah(number: 100, name: 'Al-Adiyat', englishName: 'The Coursers', arabicName: 'العَادِيَات', verseCount: 11, revelationType: RevelationType.makki),
    const Surah(number: 101, name: 'Al-Qari\'ah', englishName: 'The Calamity', arabicName: 'القَارِعَة', verseCount: 11, revelationType: RevelationType.makki),
    const Surah(number: 102, name: 'At-Takathur', englishName: 'The Rivalry in World Increase', arabicName: 'التَّكَاثُر', verseCount: 8, revelationType: RevelationType.makki),
    const Surah(number: 103, name: 'Al-Asr', englishName: 'The Declining Day', arabicName: 'العَصْر', verseCount: 3, revelationType: RevelationType.makki),
    const Surah(number: 104, name: 'Al-Humazah', englishName: 'The Traducer', arabicName: 'الهُمَزَة', verseCount: 9, revelationType: RevelationType.makki),
    const Surah(number: 105, name: 'Al-Fil', englishName: 'The Elephant', arabicName: 'الفِيل', verseCount: 5, revelationType: RevelationType.makki),
    const Surah(number: 106, name: 'Quraysh', englishName: 'Quraysh', arabicName: 'قُرَيْش', verseCount: 4, revelationType: RevelationType.makki),
    const Surah(number: 107, name: 'Al-Ma\'un', englishName: 'The Small Kindnesses', arabicName: 'المَاعُون', verseCount: 7, revelationType: RevelationType.makki),
    const Surah(number: 108, name: 'Al-Kawthar', englishName: 'The Abundance', arabicName: 'الكَوْثَر', verseCount: 3, revelationType: RevelationType.makki),
    const Surah(number: 109, name: 'Al-Kafirun', englishName: 'The Disbelievers', arabicName: 'الكَافِرُون', verseCount: 6, revelationType: RevelationType.makki),
    const Surah(number: 110, name: 'An-Nasr', englishName: 'The Divine Support', arabicName: 'النَّصْر', verseCount: 3, revelationType: RevelationType.madani),
    const Surah(number: 111, name: 'Al-Masad', englishName: 'The Palm Fiber', arabicName: 'المَسَد', verseCount: 5, revelationType: RevelationType.makki),
    const Surah(number: 112, name: 'Al-Ikhlas', englishName: 'The Sincerity', arabicName: 'الإِخْلَاص', verseCount: 4, revelationType: RevelationType.makki),
    const Surah(number: 113, name: 'Al-Falaq', englishName: 'The Daybreak', arabicName: 'الفَلَق', verseCount: 5, revelationType: RevelationType.makki),
    const Surah(number: 114, name: 'An-Nas', englishName: 'The Mankind', arabicName: 'النَّاس', verseCount: 6, revelationType: RevelationType.makki),
  ];

  List<Surah> get _filteredSurahs {
    var surahs = _allSurahs;

    switch (_selectedIndex) {
      case 1:
        surahs = surahs.where((s) => s.revelationType == RevelationType.makki).toList();
        break;
      case 2:
        surahs = surahs.where((s) => s.revelationType == RevelationType.madani).toList();
        break;
    }

    if (_searchQuery.isNotEmpty) {
      surahs = surahs
          .where((s) =>
              s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              s.englishName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              s.arabicName.contains(_searchQuery) ||
              s.number.toString() == _searchQuery)
          .toList();
    }

    return surahs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1410),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildFilterTabs(),
            Expanded(child: _buildSurahList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          const Expanded(
            child: Text(
              'All Surahs',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF141E18),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF1E2E22), width: 1),
              ),
              child: TextField(
                onChanged: (value) => setState(() => _searchQuery = value),
                style: const TextStyle(color: Colors.white, fontSize: 15),
                decoration: InputDecoration(
                  hintText: 'Search Surah',
                  hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF6B7280), size: 20),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF141E18),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF1E2E22), width: 1),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.filter_list, color: Color(0xFF4ADE80), size: 20),
                SizedBox(width: 6),
                Text(
                  'Filter',
                  style: TextStyle(
                    color: Color(0xFF4ADE80),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_tabs.length, (index) {
            final isSelected = _selectedIndex == index;
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () => setState(() => _selectedIndex = index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF3D7A52) : const Color(0xFF141E18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF3D7A52) : const Color(0xFF1E2E22),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    _tabs[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSurahList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredSurahs.length,
      itemBuilder: (context, index) {
        final surah = _filteredSurahs[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SurahListItem(
            surah: surah,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuranReaderScreen(surah: surah),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
