import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ccm/Models/supporter.dart';

import '../../Providers/supporterProvider.dart';

class SupportersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supporters List'),
      ),
      body: Consumer<SupporterProvider>(
        builder: (context, supporterProvider, child) {
          Future<void> supporterData = supporterProvider.getSupporterData();
          return FutureBuilder(
            future: supporterData,
            builder: (context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState != ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return ListView.builder(
                  itemCount: supporterProvider.supporters.length,
                  itemBuilder: (context, index) {
                    final supporter = supporterProvider.supporters[index];
                    return ListTile(
                      title: Text(
                          '${supporter.first_name} ${supporter.last_name}'),
                      subtitle:
                          Text(supporter.phone_number ?? 'No phone number'),
                      trailing: Text(
                          supporter.other_supporter_details ?? 'No details'),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
