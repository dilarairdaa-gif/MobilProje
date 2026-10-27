import 'package:flutter/material.dart';
import 'dart:async';

final ValueNotifier<int> globalTotalCalories = ValueNotifier<int>(0);

void main() {
  runApp(const FitnessApp());
}

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitLife',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF09090B),
        cardColor: const Color(0xFF18181B),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF10B981),
          secondary: Color(0xFF8B5CF6),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    WorkoutsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05), width: 1)),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF09090B),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Özet'),
            BottomNavigationBarItem(icon: Icon(Icons.fitness_center_rounded), label: 'Antrenman'),
            BottomNavigationBarItem(icon: Icon(Icons.calculate_rounded), label: 'VKİ Hesapla'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF10B981),
          unselectedItemColor: Colors.grey.shade600,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 800;

    Widget headerSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Merhaba! 👋', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -0.5)),
            const SizedBox(height: 5),
            Text('Bugün harika görünüyorsun.', style: TextStyle(color: Colors.grey.shade400, fontSize: 16)),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [Color(0xFF10B981), Color(0xFF8B5CF6)]),
          ),
          child: const CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xFF18181B),
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),
      ],
    );

    Widget activitySection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Bugünkü Aktiviten', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        ValueListenableBuilder<int>(
          valueListenable: globalTotalCalories,
          builder: (context, calories, child) {
            return Row(
              children: [
                _buildActivityCard('Adım', '0', Icons.directions_walk, const Color(0xFFF59E0B)),
                const SizedBox(width: 15),
                _buildActivityCard('Kalori', calories.toString(), Icons.local_fire_department, const Color(0xFFEF4444)),
                const SizedBox(width: 15),
                _buildActivityCard('Su', '1.5L', Icons.water_drop, const Color(0xFF3B82F6)),
              ],
            );
          },
        ),
      ],
    );

    Widget suggestionSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Günün Önerisi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF8B5CF6), Color(0xFF3B82F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(color: const Color(0xFF8B5CF6).withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10)),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Tüm Vücut Kardiyo', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 8),
                    Text('Odaklan ve Kalori Yak', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              const Icon(Icons.fitness_center, size: 80, color: Colors.white54),
            ],
          ),
        ),
      ],
    );

    Widget goalSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Haftalık Hedef', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF18181B),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('4 / 7 Gün', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
                  Text('%57', style: TextStyle(fontSize: 16, color: Color(0xFF10B981), fontWeight: FontWeight.w800)),
                ],
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  value: 0.57,
                  backgroundColor: Colors.white.withOpacity(0.05),
                  color: const Color(0xFF10B981),
                  minHeight: 12,
                ),
              ),
              const SizedBox(height: 20),
              const Text('Harika gidiyorsun! Haftalık hedefine ulaşmana çok az kaldı.', style: TextStyle(color: Colors.grey, height: 1.5)),
            ],
          ),
        ),
      ],
    );

    Widget motivationSection = Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF8B5CF6).withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.format_quote_rounded, color: Color(0xFFA78BFA), size: 40),
          const SizedBox(width: 15),
          const Expanded(
            child: Text(
              '"Vazgeçmek üzereysen, neden başladığını hatırla."',
              style: TextStyle(color: Color(0xFFE2E8F0), fontSize: 16, fontStyle: FontStyle.italic, height: 1.4),
            ),
          ),
        ],
      ),
    );

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isDesktop ? 1000 : 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerSection,
                const SizedBox(height: 30),
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [activitySection, const SizedBox(height: 30), suggestionSection],
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: Column(
                          children: [goalSection, const SizedBox(height: 30), motivationSection],
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      activitySection,
                      const SizedBox(height: 30),
                      suggestionSection,
                      const SizedBox(height: 30),
                      goalSection,
                      const SizedBox(height: 30),
                      motivationSection,
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF18181B),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withOpacity(0.15), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 15),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 5),
            Text(title, style: TextStyle(color: Colors.grey.shade400, fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> workouts = [
      {
        'title': 'Kardiyo Patlaması',
        'level': 'Orta',
        'durationMin': 20,
        'calories': 250,
        'icon': Icons.directions_run,
        'exercises': [
          '5 Dakika Olduğun Yerde Hafif Koşu (Isınma)',
          '50 Kere Kollar Havada Zıplama (Jumping Jack)',
          '30 Kere Dizleri Göğse Çekerek Hızlı Koşu',
          '20 Kere Yere Yatıp Kalkarak Zıplama (Burpee)',
          '5 Dakika Ayakta Esneme ve Dinlenme'
        ]
      },
      {
        'title': 'Üst Vücut Güç',
        'level': 'İleri',
        'durationMin': 30,
        'calories': 320,
        'icon': Icons.fitness_center,
        'exercises': [
          '15 Kere Normal Şınav Çekme',
          '12 Kere Su Şişesi/Ağırlık ile Yukarı İtiş',
          '15 Kere Sandalyeden Destekle Arka Kol İtişi',
          '12 Kere Sırtüstü Yatarak Ağırlık Kaldırma',
          '45 Saniye Dirsekler Üzerinde Düz Durma (Plank)'
        ]
      },
      {
        'title': 'Esneklik & Yoga',
        'level': 'Başlangıç',
        'durationMin': 15,
        'calories': 120,
        'icon': Icons.self_improvement,
        'exercises': [
          '3 Dakika Diz Üstü Kapanarak Dinlenme (Çocuk Pozu)',
          '10 Kere Emekleme Pozisyonunda Sırt Esnetme',
          '2 Dakika Ters V Şeklinde Durarak Bacak Esnetme',
          '2 Dakika Yerde Tek Bacak Üzerine Kapanma',
          '3 Dakika Sırtüstü Tamamen Serbest Uzandıktan Sonra Kalkış'
        ]
      },
      {
        'title': 'Karın Kası',
        'level': 'Tümü',
        'durationMin': 15,
        'calories': 150,
        'icon': Icons.accessibility_new,
        'exercises': [
          '20 Kere Sadece Omuzları Kaldırarak Yarım Mekik',
          '20 Kere Yatarak Havada Pedal Çevirme',
          '15 Kere Yatarak Düz Bacak Kaldırma',
          '60 Saniye Dirsekler Üzerinde Düz Durma (Plank)',
          '20 Kere Oturarak Sağa Sola Gövde Döndürme'
        ]
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Programlar', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.tealAccent.withOpacity(0.1), shape: BoxShape.circle),
                    child: Icon(workout['icon'], color: Colors.tealAccent, size: 30),
                  ),
                  title: Text(workout['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('${workout['durationMin']} Dk • ${workout['level']} Seviye'),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.tealAccent, size: 20),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutDetailPage(workout: workout),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class WorkoutDetailPage extends StatelessWidget {
  final Map<String, dynamic> workout;

  const WorkoutDetailPage({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    List<String> exercises = workout['exercises'];

    return Scaffold(
      appBar: AppBar(
        title: Text(workout['title']),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Icon(workout['icon'], size: 80, color: Colors.tealAccent),
              const SizedBox(height: 15),
              Text(
                '${workout['durationMin']} Dk Toplam Süre  🔥 Yaklaşık ${workout['calories']} Kalori',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Antrenman İçeriği', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      leading: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.tealAccent.withOpacity(0.2),
                        child: Text('${index + 1}', style: const TextStyle(color: Colors.tealAccent, fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      title: Text(exercises[index], style: const TextStyle(fontSize: 16)),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WorkoutTimerPage(
                            workoutTitle: workout['title'],
                            durationMin: workout['durationMin'],
                            calories: workout['calories'],
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: const Text('Antrenmana Başla', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WorkoutTimerPage extends StatefulWidget {
  final String workoutTitle;
  final int durationMin;
  final int calories;

  const WorkoutTimerPage({
    super.key,
    required this.workoutTitle,
    required this.durationMin,
    required this.calories,
  });

  @override
  State<WorkoutTimerPage> createState() => _WorkoutTimerPageState();
}

class _WorkoutTimerPageState extends State<WorkoutTimerPage> {
  late int _timeLeft;
  late int _totalTime;
  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _totalTime = widget.durationMin * 60;
    _timeLeft = _totalTime;
  }

  void _startTimer() {
    if (_timer != null) _timer!.cancel();
    setState(() => _isRunning = true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() => _timeLeft--);
      } else {
        _finishWorkout();
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _timeLeft = _totalTime;
    });
  }

  void _finishWorkout() {
    _timer?.cancel();
    setState(() => _isRunning = false);

    globalTotalCalories.value += widget.calories;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Center(child: Text('Harika İş Çıkardın! 🎉', style: TextStyle(fontWeight: FontWeight.bold))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.local_fire_department, color: Colors.orangeAccent, size: 60),
            const SizedBox(height: 15),
            Text(
              '${widget.calories} Kalori Yaktın!',
              style: const TextStyle(fontSize: 22, color: Colors.tealAccent, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Bugünlük antrenmanını başarıyla tamamladın.', textAlign: TextAlign.center),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent,
                foregroundColor: Colors.black,
              ),
              child: const Text('Ana Menüye Dön'),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get timerString {
    int minutes = _timeLeft ~/ 60;
    int seconds = _timeLeft % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workoutTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: CircularProgressIndicator(
                    value: _timeLeft / _totalTime,
                    strokeWidth: 15,
                    backgroundColor: Colors.grey.shade800,
                    color: Colors.tealAccent,
                  ),
                ),
                Text(timerString, style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _resetTimer,
                  icon: const Icon(Icons.restart_alt),
                  iconSize: 40,
                  color: Colors.grey,
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: _isRunning ? _pauseTimer : _startTimer,
                  backgroundColor: _isRunning ? Colors.orangeAccent : Colors.tealAccent,
                  child: Icon(
                    _isRunning ? Icons.pause : Icons.play_arrow,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _finishWorkout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Bitir', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String _bmiResult = '';
  String _bmiStatus = '';
  Color _statusColor = Colors.white;

  void _calculateBMI() {
    FocusScope.of(context).unfocus();

    double? weight = double.tryParse(_weightController.text);
    double? height = double.tryParse(_heightController.text);

    if (weight != null && height != null && height > 0) {
      double heightInMeters = height / 100;
      double bmi = weight / (heightInMeters * heightInMeters);

      setState(() {
        _bmiResult = bmi.toStringAsFixed(1);

        if (bmi < 18.5) {
          _bmiStatus = 'Zayıf (Kilo Almalısınız)';
          _statusColor = Colors.blueAccent;
        } else if (bmi < 24.9) {
          _bmiStatus = 'Normal (Harika!)';
          _statusColor = Colors.greenAccent;
        } else if (bmi < 29.9) {
          _bmiStatus = 'Fazla Kilolu';
          _statusColor = Colors.orangeAccent;
        } else {
          _bmiStatus = 'Obezite';
          _statusColor = Colors.redAccent;
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen geçerli sayılar girin.')),
      );
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  Widget _buildReferenceRow(String label, String range, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 10),
              Text(label, style: const TextStyle(fontSize: 16)),
            ],
          ),
          Text(range, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white70)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vücut Kitle İndeksi', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.calculate_rounded, size: 70, color: Colors.tealAccent),
                const SizedBox(height: 15),
                const Text(
                  'Boyunuzu ve kilonuzu girerek vücut kitle indeksinizi anında öğrenin.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.white70),
                ),
                const SizedBox(height: 35),
                TextField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                    labelText: 'Boy (Örn: 175 cm)',
                    prefixIcon: const Icon(Icons.height, size: 20),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                    labelText: 'Kilo (Örn: 70 kg)',
                    prefixIcon: const Icon(Icons.monitor_weight, size: 20),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _calculateBMI,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Hesapla', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                if (_bmiResult.isNotEmpty) ...[
                  const SizedBox(height: 30),
                  const Text('VKİ Sonucunuz:', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(height: 10),
                  Text(_bmiResult, style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: _statusColor)),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(color: _statusColor.withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
                    child: Text(_bmiStatus, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _statusColor)),
                  ),
                ],
                const SizedBox(height: 40),
                const Divider(color: Colors.grey),
                const SizedBox(height: 20),
                const Text('VKİ Referans Değerleri', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                _buildReferenceRow('Zayıf', '< 18.5', Colors.blueAccent),
                _buildReferenceRow('Normal (İdeal)', '18.5 - 24.9', Colors.greenAccent),
                _buildReferenceRow('Fazla Kilolu', '25.0 - 29.9', Colors.orangeAccent),
                _buildReferenceRow('Obezite', '> 30.0', Colors.redAccent),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}