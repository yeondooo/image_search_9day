import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_9day/ui/main/main_view_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색 앱'),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: '이미지를 검색해보세요',
              suffixIcon: IconButton(
                onPressed: () {
                  viewModel.fetchImages(controller.text);
                },
                icon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: state.photos.length,
              itemBuilder: (context, index) {
                final photo = state.photos[index];
                return Hero(
                  tag: photo.id,
                  child: GestureDetector(
                    onTap: () {
                      context.push(
                        '/detail',
                        extra: photo,
                      );
                    },
                    child: Image.network(
                      photo.url,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
