import 'package:kapicua/widgets/Item_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kapicua/models/match.dart';

class HomeScreen extends StatelessWidget {
  final Match provider = Match();

  HomeScreen({super.key}) {
    provider.loadFromDisk();
  }

  startNewMatch(BuildContext ctx, Match matchProvider) {
    return showDialog(
      context: ctx,
      builder: (builder) => AlertDialog(
        title: Text('Start a new match'),
        content: Text('Are you sure you want to start a new match?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            style: TextButton.styleFrom(
              foregroundColor: Color(0xffffffff)
            ),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          TextButton(
            child: Text('Accept'),
            onPressed: () {
              matchProvider.clear();
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => provider,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Kapicua'),
          backgroundColor: Theme.of(context).colorScheme.surface,
          actions: [
            Consumer<Match>(
              builder: (context, match, w) => ElevatedButton(
                child: Text('New Match'),
                onPressed: () => startNewMatch(context, match),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Consumer<Match>(
              builder: (context, match, w) => Flexible(
                child: ListView(
                  children: [
                    for (int i = 0; i < match.points.length; i++)
                      ItemRow(
                        index: i,
                        item: match.points[i],
                      ),
                  ],
                ),
              ),
            ),
            Consumer<Match>(
              builder: (context, match, w) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Theirs: ${match.points.fold(0, (prev, p) => prev + p.theirs)}'),
                  SizedBox(width: 100),
                  Text('Us: ${match.points.fold(0, (prev, p) => prev + p.us)}'),
                ],
              ),
            ),
            AddPointCard(),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

class AddPointCard extends StatelessWidget {
  final theirsController = TextEditingController();
  final usController = TextEditingController();

  AddPointCard({super.key}) {
    theirsController.text = '';
    usController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Match>(context);
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        // height: 100,
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Column(
                      children: [
                        Text('They:'),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: '0'),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.end,
                          controller: theirsController,
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Column(
                      children: [
                        Text('Us:'),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: '0'),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.end,
                          controller: usController,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                child: Text('new round'),
                onPressed: () {
                  provider.addItem(
                    theirs: int.parse(theirsController.text != ''
                        ? theirsController.text
                        : '0'),
                    us: int.parse(
                        usController.text != '' ? usController.text : '0'),
                  );
                  theirsController.text = '';
                  usController.text = '';
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
