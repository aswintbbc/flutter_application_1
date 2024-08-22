import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/lazy_loading/model.dart';
import 'package:flutter_lazy_listview/flutter_lazy_listview.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const LazyListingScreen());

class LazyListingScreen extends StatefulWidget {
  const LazyListingScreen({super.key});

  @override
  State<LazyListingScreen> createState() => _LazyListingScreenState();
}

class _LazyListingScreenState extends State<LazyListingScreen> {
  final _controller = DataFeedController<YourModel>();
  @override
  void initState() {
    fetchAlbum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FlutterLazyListView<YourModel>(
          dataFeedController: _controller,
          offset: 250,
          onReachingEnd: () async {
            // async function which is called when scrolls to end
            await fetchAlbum();
          },
          itemBuilder: (BuildContext c, YourModel m, int d) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(m.author ?? ''),
                    Image.network(m.downloadUrl ?? ''),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  int pageNumber = 0;
  Future<void> fetchAlbum() async {
    pageNumber++;
    final res = await http.get(
        Uri.parse('https://picsum.photos/v2/list?page=$pageNumber&limit=10'));
    final list = jsonDecode(res.body) as List;
    final models = list
        .map(
          (e) => YourModel.fromJson(e),
        )
        .toList();
    _controller.appendData(models);
  }
}
