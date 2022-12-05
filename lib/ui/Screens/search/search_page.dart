import 'package:flutter/material.dart';

import '../../../repositories/product_repo.dart';
import 'search_page_view.dart';
/*
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ProductRepository _productRepository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchPageBody(productRepository: _productRepository),
    );
  }
}*/


class SearchPage extends StatelessWidget {
  final Function() onBackPressed;
  SearchPage({Key? key,required this.onBackPressed}) : super(key: key);
  final ProductRepository _productRepository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: SearchPageBody(
            productRepository: _productRepository,
          onBackPressed: onBackPressed,
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    onBackPressed();
    return true;
  }
}
