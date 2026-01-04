import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Details.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'models/product.dart';

class ListviewPage extends StatefulWidget {
  const ListviewPage({Key? key}) : super(key: key);

  @override
  State<ListviewPage> createState() => _ListviewPageState();
}

class _ListviewPageState extends State<ListviewPage> {
  Map<String, dynamic>? user;
  bool loading = true;
  List<Product> products = [];
  final String baseUrl = "http://127.0.0.1:5000"; 

  @override
  void initState() {
    super.initState();
    _loadUser();
    fetchProducts();
  }

  // Load user from SharedPreferences
  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString("user");

    if (userData != null) {
      setState(() {
        user = jsonDecode(userData);
      });
    }
    setState(() => loading = false);
  }

  // Logout user
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (!mounted) return;
    context.go('/login');
  }

  // Fetch products from backend
  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/api/product"));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        setState(() {
          products = data.map((item) {
            return Product(
              id: item['id'].toString(),
              title: item['title'] ?? '',
              price: double.tryParse(item['price'].toString()) ?? 0.0,
              calories: item['calories'] ?? '',
              image: item['image'] ?? '',
            );
          }).toList();
        });
      } else {
        debugPrint("Failed to fetch products: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food Menu',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 212, 9, 9),
        actions: [
          if (!loading)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: user == null
                  ? ElevatedButton(
                      onPressed: () {
                        context.go('/login');
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shadowColor: Colors.black45,
                        backgroundColor: const Color(0xFFF5EFE8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    )
                  : Row(
                      children: [
                        Text(
                          "Hi, ${user!['name']}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (user!['isAdmin'] == 1)
                          ElevatedButton(
                            onPressed: () => context.go('/admin'),
                            child: const Text("Admin"),
                          ),
                        IconButton(
                          icon: const Icon(Icons.logout),
                          onPressed: _logout,
                        ),
                      ],
                    ),
            ),
        ],
      ),
      body: SafeArea(
        child: products.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                itemCount: products.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final product = products[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(
                            title: product.title,
                            subtitle: product.price.toString(),
                            image: product.image,
                            calories: product.calories,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: product.image.isNotEmpty
                                  ? Image.network(
                                      "$baseUrl/uploads/${product.image}",
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          width: 120,
                                          height: 120,
                                          color: Colors.grey[300],
                                          child: const Icon(Icons.image_not_supported, size: 50),
                                        );
                                      },
                                    )
                                  : Container(
                                      width: 120,
                                      height: 120,
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.image_not_supported, size: 50),
                                    ),
                            ),
                            const SizedBox(width: 12),

                            // النصوص
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    product.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '\$${product.price}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  CupertinoIcons.chevron_forward,
                                  color: Color(0xFF8E8E93),
                                  size: 30,
                                ),
                                SizedBox(height: 6),
                                Text('Customize'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
