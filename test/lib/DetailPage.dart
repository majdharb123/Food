import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final String image;

  const DetailsPage({
    super.key,
    required this.title,
    required this.image,
    required this.subtitle,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int selectedQuantity = 1; // default quantity
  String selectedColor = 'Silver'; // default color

  // Checkboxes
  bool engraving = false;
  bool giftWrap = false;
  bool certificate = false;

  // Base price from subtitle
  int get basePrice => int.parse(widget.subtitle);

  // Total price calculation
  int get totalPrice {
    int optionsPrice = 0;
    if (engraving) optionsPrice += 25;
    if (giftWrap) optionsPrice += 25;
    if (certificate) optionsPrice += 25;

    return (basePrice + optionsPrice) * selectedQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title} Detail'),
        centerTitle: true,
        backgroundColor:  Color(0xFFF2F2F7),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
               SizedBox(height: 20),
              Image.asset(
                widget.image,
                width: 400,
                height: 400,
              ),
               SizedBox(height: 20),
              Text(
                '\$${widget.subtitle}',
                style:  TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
               SizedBox(height: 20),

              // Quantity Dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text('Select Quantity: '),
                  DropdownButton<int>(
                    value: selectedQuantity,
                    items: List.generate(10, (index) => index + 1)
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.toString()),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedQuantity = value!;
                      });
                    },
                  ),
                ],
              ),

               SizedBox(height: 20),

              // Color Radio Buttons
              Column(
                children: [
                   Text('Select Color:'),
                  ListTile(
                    title:  Text('Silver'),
                    leading: Radio<String>(
                      value: 'Silver',
                      groupValue: selectedColor,
                      onChanged: (value) {
                        setState(() {
                          selectedColor = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title:  Text('Gold'),
                    leading: Radio<String>(
                      value: 'Gold',
                      groupValue: selectedColor,
                      onChanged: (value) {
                        setState(() {
                          selectedColor = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title:  Text('Rose Gold'),
                    leading: Radio<String>(
                      value: 'Rose Gold',
                      groupValue: selectedColor,
                      onChanged: (value) {
                        setState(() {
                          selectedColor = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),

               SizedBox(height: 20),

              // Options Checkboxes
              Column(
                children: [
                   Text('Add Options (\$25 each):'),
                  CheckboxListTile(
                    title:  Text('Engraving'),
                    value: engraving,
                    onChanged: (value) {
                      setState(() {
                        engraving = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title:  Text('Gift Wrap'),
                    value: giftWrap,
                    onChanged: (value) {
                      setState(() {
                        giftWrap = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title:  Text('Certificate of Authenticity'),
                    value: certificate,
                    onChanged: (value) {
                      setState(() {
                        certificate = value!;
                      });
                    },
                  ),
                ],
              ),

               SizedBox(height: 20),

              // Total Price
              Text(
                'Total Price: \$${totalPrice}',
                style:  TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

               SizedBox(height: 20),

              // Purchase Button with Notification
              SizedBox(
                height: 60,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // Show SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Purchased successfully!'),
                        duration: Duration(seconds: 2),
                      ),
                    );

                    // Go back after SnackBar
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pop(context);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                         Color.fromARGB(255, 229, 187, 237),
                    foregroundColor:
                         Color.fromARGB(255, 255, 252, 252),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:  Text(
                    'Purchase',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
