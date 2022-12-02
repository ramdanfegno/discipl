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
  SearchPage({Key? key}) : super(key: key);
  final ProductRepository _productRepository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchPageBody(productRepository: _productRepository),
    );
  }
}
