// ===============================
//   FINAL CODE main.dart
//   5 LAYER + DARK MODE
// ===============================

import 'package:flutter/material.dart';

void main() {
  runApp(CoffeeApp(mode: ThemeMode.light));
}

class CoffeeApp extends StatelessWidget {
  final ThemeMode mode;
  const CoffeeApp({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Coffee App",

      // Mengatur mode tampil
      themeMode: mode,

      // LIGHT MODE
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8EFE6),
        primarySwatch: Colors.brown,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF6F4E37),
          foregroundColor: Colors.white,
        ),
      ),

      // DARK MODE
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1B1B1B),
        cardColor: const Color(0xFF2A2A2A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF3A2D25),
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // halaman awal
      home: RootPage(mode: mode),
    );
  }
}

// =====================================================
// MODEL DATA
// =====================================================

class Coffee {
  final String id;
  final String name;
  final String category;
  final double price;
  final String desc;
  final String img;

  Coffee({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.desc,
    required this.img,
  });
}

class CartItem {
  final Coffee coffee;
  int qty;
  CartItem({required this.coffee, this.qty = 1});
}

// SAMPLE DATA
final List<Coffee> coffeeList = [
  Coffee(
    id: "1",
    name: "Cappuccino",
    category: "Classic",
    price: 25000,
    desc: "Cappuccino creamy dengan foam lembut.",
    img: "https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800",
  ),
  Coffee(
    id: "2",
    name: "Latte",
    category: "Classic",
    price: 22000,
    desc: "Latte lembut dengan espresso premium.",
    img: "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800",
  ),
  Coffee(
    id: "3",
    name: "Espresso",
    category: "Shot",
    price: 18000,
    desc: "Espresso kuat dan pekat.",
    img: "https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=800",
  ),
];

// =====================================================
// ROOT PAGE + THEME CONTROLLER
// =====================================================

class RootPage extends StatefulWidget {
  final ThemeMode mode;
  const RootPage({super.key, required this.mode});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int index = 0;
  late ThemeMode currentMode;

  final favorites = <String>{};
  final cart = <String, CartItem>{};

  String username = "IAM CODING";
  String avatar =
      "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=800";

  @override
  void initState() {
    super.initState();
    currentMode = widget.mode;
  }

  // Switch Dark / Light
  void toggleTheme() {
    setState(() {
      currentMode =
          currentMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => CoffeeApp(mode: currentMode),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(onOpenMenu: () => setState(() => index = 1)),
      MenuPage(onDetail: openDetail),
      FavoritePage(favorites: favorites, onDetail: openDetail),
      CartPage(cart: cart, onUpdate: updateQty, onRemove: removeFromCart),
      ProfilePage(
        username: username,
        avatar: avatar,
        onSave: updateProfile,
        onToggleTheme: toggleTheme,
      ),
    ];

    return Scaffold(
      body: pages[index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        backgroundColor: const Color(0xFF6F4E37),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.coffee), label: "Menu"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorit"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }

  // Open Detail
  void openDetail(Coffee coffee) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailPage(
          coffee: coffee,
          isFav: favorites.contains(coffee.id),
          onFavToggle: () {
            setState(() {
              favorites.contains(coffee.id)
                  ? favorites.remove(coffee.id)
                  : favorites.add(coffee.id);
            });
          },
          onAdd: (qty) {
            setState(() {
              cart.containsKey(coffee.id)
                  ? cart[coffee.id]!.qty += qty
                  : cart[coffee.id] = CartItem(coffee: coffee, qty: qty);
            });
          },
        ),
      ),
    );
  }

  void updateQty(String id, int qty) {
    setState(() {
      if (qty <= 0) cart.remove(id);
      else cart[id]!.qty = qty;
    });
  }

  void removeFromCart(String id) {
    setState(() => cart.remove(id));
  }

  void updateProfile(String img, String name) {
    setState(() {
      avatar = img;
      username = name;
    });
  }
}

// =====================================================
// HOME PAGE (DESAIN BARU LEBIH MENARIK)
// =====================================================

class HomePage extends StatelessWidget {
  final VoidCallback onOpenMenu;
  const HomePage({super.key, required this.onOpenMenu});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Home"),
        backgroundColor: isDark ? const Color(0xFF3A2D25) : const Color(0xFF6F4E37),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // HEADER GREETING
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF3A2D25) : const Color(0xFF6F4E37),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(26)),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=800",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("SELAMAT DATANG,", 
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        Text("KOPI NAKO",
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.notifications, color: Colors.white),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // SEARCH BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Cari kopi favoritmu...",
                  filled: true,
                  fillColor: isDark ? Colors.white10 : Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // PROMO CARD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: onOpenMenu,
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://images.unsplash.com/photo-1511920170033-f8396924c348?w=1200",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Promo Spesial Minggu Ini",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text("Diskon 20% untuk menu Special!",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // KATEGORI POPULER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text("Kategori Populer", 
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  GestureDetector(
                    onTap: onOpenMenu,
                    child: const Text("Lihat Menu", 
                        style: TextStyle(color: Colors.brown)),
                  )
                ],
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  categoryChip(Icons.coffee, "Classic", isDark),
                  categoryChip(Icons.local_cafe, "Special", isDark),
                  categoryChip(Icons.icecream, "Iced", isDark),
                  categoryChip(Icons.bolt, "Shot", isDark),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // REKOMENDASI
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("Rekomendasi", 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),

            const SizedBox(height: 14),

            SizedBox(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: coffeeList.length,
                itemBuilder: (_, i) {
                  final c = coffeeList[i];
                  return recommendationCard(c, isDark);
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // CATEGORY CHIP
  Widget categoryChip(IconData icon, String title, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      width: 100,
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.09),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.brown),
          const SizedBox(height: 8),
          Text(title),
        ],
      ),
    );
  }

  // CARD REKOMENDASI
  Widget recommendationCard(Coffee c, bool isDark) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(c.img, height: 120, width: 180, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text("Rp ${c.price.toInt()}",
                    style: const TextStyle(color: Colors.brown)),
              ],
            ),
          )
        ],
      ),
    );
  }
}


// =====================================================
// MENU PAGE
// =====================================================

class MenuPage extends StatelessWidget {
  final void Function(Coffee) onDetail;

  const MenuPage({super.key, required this.onDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu Kopi")),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: coffeeList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: .78),
        itemBuilder: (_, i) {
          final c = coffeeList[i];
          return GestureDetector(
            onTap: () => onDetail(c),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              elevation: 4,
              child: Column(
                children: [
                  Image.network(c.img, height: 120, fit: BoxFit.cover),
                  const SizedBox(height: 8),
                  Text(c.name,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold)),
                  Text("Rp ${c.price.toInt()}",
                      style: const TextStyle(color: Colors.brown)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// =====================================================
// FAVORITE PAGE
// =====================================================

class FavoritePage extends StatelessWidget {
  final Set<String> favorites;
  final void Function(Coffee) onDetail;

  const FavoritePage({
    super.key,
    required this.favorites,
    required this.onDetail,
  });

  @override
  Widget build(BuildContext context) {
    final list = coffeeList.where((c) => favorites.contains(c.id)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Favorit")),
      body: list.isEmpty
          ? const Center(child: Text("Belum ada favorit ⭐"))
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: list.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: .78),
              itemBuilder: (_, i) {
                final c = list[i];
                return GestureDetector(
                  onTap: () => onDetail(c),
                  child: Card(
                    child: Column(
                      children: [
                        Image.network(c.img, height: 120, fit: BoxFit.cover),
                        Text(c.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold)),
                        Text("Rp ${c.price.toInt()}"),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// =====================================================
// DETAIL PAGE
// =====================================================

class DetailPage extends StatefulWidget {
  final Coffee coffee;
  final bool isFav;
  final VoidCallback onFavToggle;
  final void Function(int qty) onAdd;

  const DetailPage({
    super.key,
    required this.coffee,
    required this.isFav,
    required this.onFavToggle,
    required this.onAdd,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coffee.name),
        actions: [
          IconButton(
            icon: Icon(
              widget.isFav ? Icons.favorite : Icons.favorite_border,
              color: Colors.yellow,
            ),
            onPressed: widget.onFavToggle,
          )
        ],
      ),
      body: Column(
        children: [
          Image.network(widget.coffee.img, height: 220, fit: BoxFit.cover),
          const SizedBox(height: 12),

          Text(widget.coffee.name,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text("Rp ${widget.coffee.price.toInt()}",
              style: const TextStyle(fontSize: 18, color: Colors.brown)),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(widget.coffee.desc),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              qtyButton("-", () {
                setState(() {
                  if (qty > 1) qty--;
                });
              }),
              const SizedBox(width: 10),
              Text(qty.toString(), style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 10),
              qtyButton("+", () {
                setState(() => qty++);
              }),
            ],
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              widget.onAdd(qty);
              Navigator.pop(context);
            },
            child: const Text("Tambah ke Keranjang"),
          ),
        ],
      ),
    );
  }

  Widget qtyButton(String label, VoidCallback onTap) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Text(label,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

// =====================================================
// CART PAGE
// =====================================================

class CartPage extends StatefulWidget {
  final Map<String, CartItem> cart;
  final void Function(String id, int qty) onUpdate;
  final void Function(String id) onRemove;

  const CartPage({
    super.key,
    required this.cart,
    required this.onUpdate,
    required this.onRemove,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final items = widget.cart.values.toList();
    final total = items.fold<double>(
        0, (s, i) => s + (i.coffee.price * i.qty));

    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang")),
      body: items.isEmpty
          ? const Center(child: Text("Keranjang kosong"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (_, i) {
                      final item = items[i];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Image.network(item.coffee.img,
                              width: 60, fit: BoxFit.cover),
                          title: Text(item.coffee.name),
                          subtitle: Text(
                              "Rp ${item.coffee.price.toInt()} x ${item.qty}"),
                          trailing: Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  widget.onUpdate(
                                      item.coffee.id, item.qty + 1);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.add_circle),
                              ),
                              IconButton(
                                onPressed: () {
                                  widget.onUpdate(
                                      item.coffee.id, item.qty - 1);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.remove_circle),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // TOTAL
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total: Rp ${total.toInt()}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() => widget.cart.clear());
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Checkout berhasil! Terima kasih 🤎")),
                          );
                        },
                        child: const Text("Checkout"),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

// =====================================================
//   PROFILE PAGE — NEW MODERN VERSION
// =====================================================

class ProfilePage extends StatelessWidget {
  final String username;
  final String avatar;
  final void Function(String img, String name) onSave;
  final VoidCallback onToggleTheme;

  const ProfilePage({
    super.key,
    required this.username,
    required this.avatar,
    required this.onSave,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ==========================
            // PROFIL CARD (GLASS)
            // ==========================
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDark ? Colors.white10 : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.08),
                  )
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(avatar),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // MEMBER BADGE
                  _memberBadge(),

                  const SizedBox(height: 14),

                  ElevatedButton(
                    onPressed: () => openEditDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6F4E37),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text("Edit Profil"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ==========================
            // PENGATURAN MENU
            // ==========================
            _settingsTitle("Pengaturan Akun"),

            _settingsItem(Icons.history, "Riwayat Pesanan", () {}),
            _settingsItem(Icons.payment, "Metode Pembayaran", () {}),
            _settingsItem(Icons.lock, "Keamanan Akun", () {}),
            _settingsItem(Icons.help_outline, "Bantuan & FAQ", () {}),

            const SizedBox(height: 16),

            // DARK MODE SWITCH
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark ? Colors.white10 : Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.dark_mode, size: 26),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      "Mode Gelap / Terang",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Switch(
                    value: isDark,
                    activeColor: Colors.brown,
                    onChanged: (_) => onToggleTheme(),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // LOGOUT
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              label: const Text(
                "Keluar",
                style: TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // WIDGET: MEMBER BADGE
  // =====================================================

  Widget _memberBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.brown.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.emoji_events, size: 16, color: Colors.brown),
          SizedBox(width: 6),
          Text(
            "Gold Member",
            style: TextStyle(fontSize: 13, color: Colors.brown),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // WIDGET: TITLE
  // =====================================================

  Widget _settingsTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }

  // =====================================================
  // WIDGET: SETTINGS ITEM
  // =====================================================

  Widget _settingsItem(IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, size: 26),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  // =====================================================
  // EDIT PROFIL DIALOG
  // =====================================================

  void openEditDialog(BuildContext context) {
    String tempName = username;
    String tempAvatar = avatar;

    final avatarList = [
      "https://1drv.ms/i/c/172da474cfdf2c7c/EQVRmbZrcldOoOijuijbFrkBE5KKXTY7tGGzWxJXexcRQw?e=7zncx1",
      "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=800",
      "https://images.unsplash.com/photo-1547425260-76bcadfb4f2c?w=800",
    ];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Profil"),
        content: StatefulBuilder(
          builder: (ctx, setStateDialog) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: "Nama Pengguna"),
                  controller: TextEditingController(text: tempName),
                  onChanged: (v) => tempName = v,
                ),
                const SizedBox(height: 12),
                const Text("Pilih Avatar:"),
                Wrap(
                  children: avatarList.map((img) {
                    return GestureDetector(
                      onTap: () {
                        setStateDialog(() => tempAvatar = img);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(6),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: tempAvatar == img
                                ? Colors.brown
                                : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(img),
                        ),
                      ),
                    );
                  }).toList(),
                )
              ],
            );
          },
        ),
        actions: [
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Simpan"),
            onPressed: () {
              onSave(tempAvatar, tempName);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

