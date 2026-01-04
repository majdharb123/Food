import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final String title;
  final String subtitle;
  final String image;
  final String calories;

  const Details({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.calories,
  }) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String? _selectedOption;

  double get finalPrice {
    double basePrice = double.tryParse(widget.subtitle) ?? 0.0;
    switch (_selectedOption) {
      case 'Rice':
        return basePrice + 5;
      case 'Vegetables':
        return basePrice + 10;
      case 'Sauce':
        return basePrice + 3;
      case 'None':
        return basePrice;
      default:
        return basePrice;
    }
  }

  int get finalCalories {
    int baseCalories = int.tryParse(widget.calories) ?? 0;
    switch (_selectedOption) {
      case 'Rice':
        return baseCalories + 50;
      case 'Vegetables':
        return baseCalories + 30;
      case 'Sauce':
        return baseCalories + 20;
      default:
        return baseCalories;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 212, 9, 9),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: widget.image.isNotEmpty
                    ? Image.network(
                        widget.image.startsWith('http')
                            ? widget.image
                            : "https://food-kghd.onrender.com/uploads/${widget.image}",
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 300,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 50,
                            ),
                          );
                        },
                      )
                    : Container(
                        width: double.infinity,
                        height: 300,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 50,
                        ),
                      ),
              ),

              const SizedBox(height: 20),

              // Price
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Price: ',
                    style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
                  ),
                  Text(
                    '\$${finalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Calories
              Text(
                'Calories: ${finalCalories}',
                style: const TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 20),

              // Toppings
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Choose Your Extra Topping:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    ...['Rice', 'Vegetables', 'Sauce', 'None'].map(
                      (option) => ListTile(
                        title: Text(option),
                        leading: Radio<String>(
                          value: option,
                          groupValue: _selectedOption,
                          onChanged: (value) {
                            setState(() {
                              _selectedOption = value;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Selected Toppings: ${_selectedOption ?? "None"}',
                      style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                    const Text(
                      '(You will be charged extra for selected toppings)',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
