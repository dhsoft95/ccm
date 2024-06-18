import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  final List<Package> packages = [
    Package(smsCount: 500, price: 12500),
    Package(smsCount: 1000, price: 25000),
    Package(smsCount: 1500, price: 37500),
    Package(smsCount: 2000, price: 50000),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Subscribe to Packages',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xff009b65),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff009b65), Color(0xff0d1018)],
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: packages.length,
          itemBuilder: (context, index) {
            return PackageCard(package: packages[index]);
          },
        ),
      ),
    );
  }
}

class Package {
  final int smsCount;
  final double price;

  Package({required this.smsCount, required this.price});
}

class PackageCard extends StatefulWidget {
  final Package package;

  PackageCard({required this.package});

  @override
  _PackageCardState createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      color: Color(0xff009b65),
      child: InkWell(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isExpanded
                  ? [Color(0xffa1ffce), Color(0xffd5ff80)]
                  : [Color(0xff009b65), Color(0xff009b65)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.package.smsCount} SMS',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'TZS ${widget.package.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              if (isExpanded)
                Text(
                  'Get ${widget.package.smsCount} SMS for just TZS ${widget.package.price.toStringAsFixed(2)}. '
                      'This package is perfect for staying connected with your friends and family.',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.info,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                  ),
                  SizedBox(width: 10.0),
                  if (!isExpanded)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                      ),
                      onPressed: () {
                        // Handle subscription logic here
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Subscribed'),
                            content: Text(
                                'You have subscribed to ${widget.package.smsCount} SMS for TZS ${widget.package.price.toStringAsFixed(2)}'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text(
                        'Subscribe',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xff009b65),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

