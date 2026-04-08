import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const RightPersonApp());
}

// ---------------------------------------------------------
// ANA UYGULAMA & TEMA
// ---------------------------------------------------------
class RightPersonApp extends StatelessWidget {
  const RightPersonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Right Person', // İsim düzeltildi
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6584), // Romantik Pembe
          secondary: const Color(0xFF6C63FF), // Modern Mor
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FD),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.black87),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF6584),
            foregroundColor: Colors.white,
            elevation: 3,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

// ---------------------------------------------------------
// 1. GİRİŞ EKRANI
// ---------------------------------------------------------
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _selectedGender;
  String? _selectedProfileImage;

  final List<String> _avatars = [
    "https://i.pravatar.cc/300?u=10",
    "https://i.pravatar.cc/300?u=20",
    "https://i.pravatar.cc/300?u=33",
    "https://i.pravatar.cc/300?u=45",
    "https://i.pravatar.cc/300?u=51",
    "https://i.pravatar.cc/300?u=68",
  ];

  void _pickImage() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                "Bir Avatar Seç",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: _avatars.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedProfileImage = _avatars[index]);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.pinkAccent.withOpacity(0.5),
                            width: 2,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(_avatars[index]),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _startTest() {
    if (_nameController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Lütfen tüm alanları doldurun"),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }
    _selectedProfileImage ??= "https://i.pravatar.cc/300?u=99";

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TestScreen(
          userName: _nameController.text,
          userAge: _ageController.text,
          userGender: _selectedGender!,
          userImage: _selectedProfileImage!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6C63FF), Color(0xFFFF6584)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.white,
                        backgroundImage: _selectedProfileImage != null
                            ? NetworkImage(_selectedProfileImage!)
                            : null,
                        child: _selectedProfileImage == null
                            ? const Icon(
                                Icons.add_a_photo_rounded,
                                size: 40,
                                color: Color(0xFFFF6584),
                              )
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  // İsim Right Person olarak güncellendi
                  Text(
                    "Right Person",
                    style: GoogleFonts.poppins(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Ruh eşini bulmanın en doğru yolu.",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 40),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildInput(
                          _nameController,
                          "Adın Soyadın",
                          Icons.person_outline,
                        ),
                        const SizedBox(height: 15),
                        _buildInput(
                          _ageController,
                          "Yaşın",
                          Icons.cake_outlined,
                          isNumber: true,
                        ),
                        const SizedBox(height: 15),
                        DropdownButtonFormField<String>(
                          value: _selectedGender,
                          decoration: InputDecoration(
                            hintText: "Cinsiyetin",
                            prefixIcon: const Icon(
                              Icons.wc_outlined,
                              color: Color(0xFFFF6584),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: "Kadın",
                              child: Text("Kadın"),
                            ),
                            DropdownMenuItem(
                              value: "Erkek",
                              child: Text("Erkek"),
                            ),
                          ],
                          onChanged: (value) =>
                              setState(() => _selectedGender = value),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _startTest,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFFFF6584),
                      ),
                      child: const Text("BAŞLA"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFFFF6584)),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 2. TEST EKRANI
// ---------------------------------------------------------
class TestScreen extends StatefulWidget {
  final String userName, userAge, userGender, userImage;
  const TestScreen({
    super.key,
    required this.userName,
    required this.userAge,
    required this.userGender,
    required this.userImage,
  });
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      "text": "Her şeyin kusursuz ve hatasız olması beni rahatlatır.",
      "type": 1,
    },
    {
      "text": "Başkalarının ihtiyaçlarını kendiminkinden öne koyarım.",
      "type": 2,
    },
    {"text": "Başarısızlık benim için bir seçenek değildir.", "type": 3},
    {"text": "Sıradan biri olmak en büyük korkumdur.", "type": 4},
    {"text": "Duygulara kapılmak yerine mantıkla çözerim.", "type": 5},
    {"text": "Her zaman 'B planım' vardır, risk sevmem.", "type": 6},
    {"text": "Hayat kısa, eğlenmeliyim, sıkıntıya gelemem.", "type": 7},
    {"text": "Kontrolü kaybetmekten nefret ederim.", "type": 8},
    {"text": "Tartışma çıkmasın diye susabilirim.", "type": 9},
    {"text": "Kendime karşı çok eleştirelimdir.", "type": 1},
    {"text": "İnsanlar bana ihtiyaç duyduğunda değerli hissederim.", "type": 2},
    {"text": "Çok çalışmak ve üretken olmak beni tanımlar.", "type": 3},
    {"text": "Bazen sebepsiz bir hüzün yaşarım.", "type": 4},
    {"text": "Kalabalık ortamlarda enerjim çekilir.", "type": 5},
    {"text": "İnsanlara güvenmekte zorlanırım.", "type": 6},
    {"text": "Olumsuz duygulardan kaçmak için meşgul olurum.", "type": 7},
    {"text": "Haksızlığa anında sert tepki veririm.", "type": 8},
    {"text": "Hayır demekte zorlanırım.", "type": 9},
  ];

  late List<double> scores;
  @override
  void initState() {
    super.initState();
    scores = List.filled(questions.length, 3.0);
  }

  int calculateResult() {
    Map<int, double> typeScores = {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
      8: 0,
      9: 0,
    };
    for (int i = 0; i < questions.length; i++) {
      int type = questions[i]['type'];
      typeScores[type] = typeScores[type]! + scores[i];
    }
    int bestType = 1;
    double maxScore = 0;
    typeScores.forEach((type, score) {
      if (score > maxScore) {
        maxScore = score;
        bestType = type;
      }
    });
    return bestType;
  }

  double get progress =>
      scores.where((s) => s != 3.0).length / questions.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kişilik Analizi"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6.0),
          child: LinearProgressIndicator(
            value: progress == 0 ? 0.05 : progress,
            backgroundColor: Colors.grey[200],
            color: const Color(0xFFFF6584),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: questions.length + 1,
        itemBuilder: (context, index) {
          if (index == questions.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: () {
                  int myType = calculateResult();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainNavigationScreen(
                        userType: myType,
                        userName: widget.userName,
                        userAge: widget.userAge,
                        userGender: widget.userGender,
                        userImage: widget.userImage,
                      ),
                    ),
                  );
                },
                child: const Text("ANALİZİ BİTİR"),
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${index + 1}. ${questions[index]['text']}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: const Color(0xFFFF6584),
                    inactiveTrackColor: Colors.grey[200],
                    thumbColor: const Color(0xFF6C63FF),
                    overlayColor: const Color(0xFF6C63FF).withOpacity(0.2),
                    trackHeight: 6.0,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 8.0,
                    ),
                  ),
                  child: Slider(
                    value: scores[index],
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: scores[index].round().toString(),
                    onChanged: (val) => setState(() => scores[index] = val),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Katılmıyorum",
                      style: TextStyle(fontSize: 10, color: Colors.grey[400]),
                    ),
                    Text(
                      "Katılıyorum",
                      style: TextStyle(fontSize: 10, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------
// 3. ANA NAVİGASYON
// ---------------------------------------------------------
class MainNavigationScreen extends StatefulWidget {
  final int userType;
  final String userName, userAge, userGender, userImage;
  const MainNavigationScreen({
    super.key,
    required this.userType,
    required this.userName,
    required this.userAge,
    required this.userGender,
    required this.userImage,
  });
  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      MatchesTab(userType: widget.userType, userGender: widget.userGender),
      const ChatsTab(),
      ProfileTab(
        userType: widget.userType,
        name: widget.userName,
        age: widget.userAge,
        gender: widget.userGender,
        image: widget.userImage,
      ),
    ];
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: const Color(0xFFFF6584).withOpacity(0.2),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          backgroundColor: Colors.white,
          elevation: 10,
          onDestinationSelected: (int index) =>
              setState(() => _currentIndex = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.favorite_border),
              selectedIcon: Icon(Icons.favorite, color: Color(0xFFFF6584)),
              label: 'Keşfet',
            ),
            NavigationDestination(
              icon: Icon(Icons.chat_bubble_outline),
              selectedIcon: Icon(Icons.chat_bubble, color: Color(0xFF6C63FF)),
              label: 'Sohbet',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: Color(0xFF6C63FF)),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}

// --- TAB 1: EŞLEŞMELER ---
class MatchesTab extends StatefulWidget {
  final int userType;
  final String userGender;
  const MatchesTab({
    super.key,
    required this.userType,
    required this.userGender,
  });
  @override
  State<MatchesTab> createState() => _MatchesTabState();
}

class _MatchesTabState extends State<MatchesTab> {
  RangeValues _currentAgeRange = const RangeValues(18, 50);
  final List<Map<String, dynamic>> allUsers = [
    {
      "name": "Ayşe Y.",
      "age": 22,
      "type": 9,
      "gender": "Kadın",
      "img": "https://i.pravatar.cc/300?u=1",
      "bio": "Huzur arayan bir ruh.",
    },
    {
      "name": "Selin A.",
      "age": 21,
      "type": 4,
      "gender": "Kadın",
      "img": "https://i.pravatar.cc/300?u=3",
      "bio": "Sanat, kahve ve yağmur.",
    },
    {
      "name": "Zeynep T.",
      "age": 28,
      "type": 7,
      "gender": "Kadın",
      "img": "https://i.pravatar.cc/300?u=5",
      "bio": "Dünyayı gezmek tek hayalim.",
    },
    {
      "name": "Elif S.",
      "age": 20,
      "type": 8,
      "gender": "Kadın",
      "img": "https://i.pravatar.cc/300?u=7",
      "bio": "Net insanları severim.",
    },
    {
      "name": "Mehmet K.",
      "age": 24,
      "type": 2,
      "gender": "Erkek",
      "img": "https://i.pravatar.cc/300?u=2",
      "bio": "Yardımsever ve sadık.",
    },
    {
      "name": "Burak Ç.",
      "age": 23,
      "type": 1,
      "gender": "Erkek",
      "img": "https://i.pravatar.cc/300?u=4",
      "bio": "Disiplin başarının anahtarıdır.",
    },
    {
      "name": "Can B.",
      "age": 25,
      "type": 5,
      "gender": "Erkek",
      "img": "https://i.pravatar.cc/300?u=6",
      "bio": "Teknoloji ve bilim aşığı.",
    },
    {
      "name": "Ahmet Y.",
      "age": 32,
      "type": 3,
      "gender": "Erkek",
      "img": "https://i.pravatar.cc/300?u=10",
      "bio": "Kendi işimin patronuyum.",
    },
  ];

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(25),
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Filtrele",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Yaş Aralığı: ${_currentAgeRange.start.round()} - ${_currentAgeRange.end.round()}",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  RangeSlider(
                    values: _currentAgeRange,
                    min: 18,
                    max: 60,
                    divisions: 42,
                    activeColor: const Color(0xFFFF6584),
                    labels: RangeLabels(
                      _currentAgeRange.start.round().toString(),
                      _currentAgeRange.end.round().toString(),
                    ),
                    onChanged: (v) {
                      setModalState(() => _currentAgeRange = v);
                      setState(() => _currentAgeRange = v);
                    },
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Uygula"),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String targetGender = widget.userGender == "Erkek" ? "Kadın" : "Erkek";
    final filteredUsers = allUsers
        .where(
          (user) =>
              user['gender'] == targetGender &&
              user['age'] >= _currentAgeRange.start &&
              user['age'] <= _currentAgeRange.end,
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eşleşmeler"),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: filteredUsers.isEmpty
          ? Center(child: Text("Kriterlere uygun $targetGender bulunamadı."))
          : ListView.builder(
              itemCount: filteredUsers.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => ChatDetailScreen(user: user),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Hero(
                          tag: user['name'],
                          child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(user['img']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${user['name']}, ${user['age']}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Tip ${user['type']} • ${user['bio']}",
                                    style: const TextStyle(
                                      color: Color(0xFF6C63FF),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.favorite,
                                color: Color(0xFFFF6584),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// --- TAB 2: SOHBET ---
class ChatsTab extends StatelessWidget {
  const ChatsTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sohbetler")),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          _buildChatTile(
            context,
            "Ayşe Y.",
            "Selam! Test sonucun ilgimi çekti...",
            "14:30",
            "https://i.pravatar.cc/300?u=1",
          ),
          _buildChatTile(
            context,
            "Selin A.",
            "Fotoğrafını beğendim :)",
            "Dün",
            "https://i.pravatar.cc/300?u=3",
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile(
    BuildContext context,
    String name,
    String msg,
    String time,
    String img,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: CircleAvatar(radius: 28, backgroundImage: NetworkImage(img)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(msg, maxLines: 1),
        trailing: Text(
          time,
          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => ChatDetailScreen(user: {'name': name, 'img': img}),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// TAB 3: PROFİL (GELİŞMİŞ & TIKLANABİLİR)
// ---------------------------------------------------------
class ProfileTab extends StatelessWidget {
  final int userType;
  final String name, age, gender, image;

  const ProfileTab({
    super.key,
    required this.userType,
    required this.name,
    required this.age,
    required this.gender,
    required this.image,
  });

  String getTypeName(int type) {
    List<String> names = [
      "",
      "Mükemmeliyetçi (Tip 1)",
      "Yardımsever (Tip 2)",
      "Başarı Odaklı (Tip 3)",
      "Bireyci (Tip 4)",
      "Araştırmacı (Tip 5)",
      "Sadık (Tip 6)",
      "İstekli (Tip 7)",
      "Meydan Okuyan (Tip 8)",
      "Barışçı (Tip 9)",
    ];
    return names[type];
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Çıkış Yap"),
        content: const Text("Hesabından çıkış yapmak istediğine emin misin?"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("İptal", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              (r) => false,
            ),
            child: const Text("Evet, Çık", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profilim")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFF6584),
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(image),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF6C63FF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "$name, $age",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6584).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                getTypeName(userType),
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFFFF6584),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // GELİŞMİŞ MENÜLER
            _buildProfileItem(
              context,
              Icons.security,
              "Gizlilik Ayarları",
              const PrivacySettingsScreen(),
            ),
            _buildProfileItem(
              context,
              Icons.notifications_none,
              "Bildirimler",
              const NotificationSettingsScreen(),
            ),
            _buildProfileItem(
              context,
              Icons.help_outline,
              "Yardım & Destek",
              const HelpSupportScreen(),
            ),
            const Divider(height: 40),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.logout, color: Colors.red),
              ),
              title: const Text(
                "Çıkış Yap",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => _confirmLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(
    BuildContext context,
    IconData icon,
    String title,
    Widget destinationPage,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.black87),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
    );
  }
}

// ---------------------------------------------------------
// YENİ ALT SAYFALAR (PROFİL DETAYLARI)
// ---------------------------------------------------------

// Gizlilik Ayarları Sayfası
class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});
  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _profileVisible = true;
  bool _showAge = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gizlilik")),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Profilim Görünür"),
            subtitle: const Text("Diğer kullanıcılar seni keşfedebilir."),
            value: _profileVisible,
            activeColor: const Color(0xFFFF6584),
            onChanged: (v) => setState(() => _profileVisible = v),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text("Yaşımı Göster"),
            subtitle: const Text("Profilinde yaşın açıkça yazar."),
            value: _showAge,
            activeColor: const Color(0xFFFF6584),
            onChanged: (v) => setState(() => _showAge = v),
          ),
        ],
      ),
    );
  }
}

// Bildirim Ayarları Sayfası
class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});
  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _matchNotif = true;
  bool _msgNotif = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bildirimler")),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Yeni Eşleşmeler"),
            value: _matchNotif,
            activeColor: const Color(0xFF6C63FF),
            onChanged: (v) => setState(() => _matchNotif = v),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text("Mesaj Bildirimleri"),
            value: _msgNotif,
            activeColor: const Color(0xFF6C63FF),
            onChanged: (v) => setState(() => _msgNotif = v),
          ),
        ],
      ),
    );
  }
}

// Yardım & Destek Sayfası (Accordion Stil)
class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yardım & Destek")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ExpansionTile(
            title: Text(
              "Right Person nasıl çalışır?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Enneagram kişilik testini kullanarak sana en uygun karakter tipindeki kişileri eşleştiriyoruz.",
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              "Profilimi nasıl düzenlerim?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Profil sekmesindeki kalem ikonuna tıklayarak avatarını değiştirebilirsin.",
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              "Üyelik ücretli mi?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Right Person şu an tamamen ücretsizdir!"),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              "Hesabımı nasıl silerim?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Güvenlik sebebiyle şu an sadece çıkış yapabilirsiniz, hesap silme yakında eklenecek.",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// SOHBET DETAY
// ---------------------------------------------------------
class ChatDetailScreen extends StatelessWidget {
  final Map<String, dynamic> user;
  const ChatDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Hero(
              tag: user['name'],
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  user['img'] ?? "https://i.pravatar.cc/300",
                ),
                radius: 20,
              ),
            ),
            const SizedBox(width: 10),
            Text(user['name'], style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildBubble(
                  "Selam! Profilini gördüm, çok uyumlu duruyoruz.",
                  false,
                ),
                _buildBubble("Selam, teşekkürler! Nasılsın?", true),
                _buildBubble(
                  "İyiyim ben de. Kişilik testi sonucun ne çıktı?",
                  false,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Mesaj yaz...",
                      fillColor: Colors.grey[100],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const CircleAvatar(
                  backgroundColor: Color(0xFFFF6584),
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble(String msg, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 10),
        constraints: const BoxConstraints(maxWidth: 250),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF6C63FF) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isMe ? 20 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          msg,
          style: TextStyle(color: isMe ? Colors.white : Colors.black87),
        ),
      ),
    );
  }
}
