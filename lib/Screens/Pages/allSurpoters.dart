import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../../Providers/supporterProvider.dart';

class SupportersList extends StatefulWidget {
  @override
  _SupportersListState createState() => _SupportersListState();
}

class _SupportersListState extends State<SupportersList> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchSupporters();
  }

  Future<void> _fetchSupporters() async {
    try {
      await Provider.of<SupporterProvider>(context, listen: false).getSupporterData();
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load supporters.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Supporters List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff009b65), // Set app bar color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff009b65), Color(0xff0d1018)],
          ),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _errorMessage != null
            ? Center(child: Text(_errorMessage!))
            : Consumer<SupporterProvider>(
          builder: (context, supporterProvider, child) {
            if (supporterProvider.supporters.isEmpty) {
              return Center(child: Text('No supporters available',style: TextStyle(color: Colors.white,fontSize: 16),));
            } else {
              return AnimationLimiter(
                child: ListView.builder(
                  itemCount: supporterProvider.supporters.length,
                  itemBuilder: (context, index) {
                    final supporter = supporterProvider.supporters[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child:Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xff009b65),
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${supporter.first_name} ${supporter.last_name}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    supporter.phone_number ?? 'No phone number',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Text(
                                    supporter.other_supporter_details ?? 'No details',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

