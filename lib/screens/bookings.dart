import 'package:final_year_project/screens/rating_screen.dart';

import '../providers/users.dart';
import 'package:final_year_project/providers/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_drawer.dart';

class BookingsScreen extends StatelessWidget {
  static const routeName = '/user-jobs';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Users>(context, listen: false).fetchAndSetJobs();
  }

  @override
  Widget build(BuildContext context) {
    //  final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<Users>(
                      builder: (ctx, jobsData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: jobsData.alljobs.length,
                          itemBuilder: (ctx, i) => Column(children: <Widget>[
                            ListTile(
                              title: Text(
                                jobsData.alljobs[i].techName,
                              ),
                              subtitle: Text(jobsData.alljobs[i].techNumber),
                              trailing: Text(jobsData.alljobs[i].jobstat.toString() , style: TextStyle(color: Colors.blue),),
                              onTap: () {
                                if (jobsData.alljobs[i].jobstat.toString() == "COMPLETED" && jobsData.alljobs[i].rating == false)
                                {
                                  Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RatingCard(jobsData.alljobs[i].techId,jobsData.alljobs[i].jobId)));

                                }
                              },                       
                            ),
                            Divider(),
                          ]),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
