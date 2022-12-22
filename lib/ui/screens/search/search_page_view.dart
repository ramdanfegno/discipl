import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habitoz_fitness_app/bloc/fc_detail_bloc/fc_detail_bloc.dart';

import '../../../bloc/search_center_bloc/search_center_bloc.dart';
import '../../../models/fitness_center_list_model.dart';
import '../../../repositories/product_repo.dart';
import '../../../utils/constants.dart';
import '../../../utils/habitoz_icons.dart';
import '../../../utils/size_config.dart';
import '../../widgets/others/color_loader.dart';
import '../gym/fitnes_center_details/fitness_center_detail_page.dart';
import 'components/searchlist_tile.dart';

class SearchPageBody extends StatefulWidget {
  final ProductRepository productRepository;
  final Function() onBackPressed;

  // ignore: use_key_in_widget_constructors
  const SearchPageBody(
      {required this.productRepository, required this.onBackPressed});

  @override
  _SearchPageBodyState createState() => _SearchPageBodyState();
}

class _SearchPageBodyState extends State<SearchPageBody> {
  late ProductRepository _productRepository;
  late bool forceRefresh;
  late TextEditingController textEditingController;
  List<FitnessCenterModel?>? searchList;
  late SearchBLoc _searchBLoc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchList = [];
    forceRefresh = false;
    _productRepository = widget.productRepository;
    textEditingController = TextEditingController();
    _searchBLoc = BlocProvider.of<SearchBLoc>(context);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Stack(
        children: [
          /*(searchList!.isNotEmpty)?
          displaySearchResult(searchList) : Container(),*/

          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: const Color.fromRGBO(244, 244, 244, 1),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.blockSizeHorizontal * 20,
                    bottom: SizeConfig.blockSizeHorizontal * 20),
                child: BlocBuilder<SearchBLoc, SearchState>(
                    builder: (context, state) {
                  if (state is SearchDisplay) {
                    return displaySearchResult(state.fcList);
                  }
                  if (state is SearchLoading) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: ColorLoader5(),
                      ),
                    );
                  }
                  if (state is SearchEmpty) {
                    return emptySearch();
                  }
                  if (state is SearchFailure || state is SearchError) {
                    return failedSearch();
                  }
                  return Container();
                }),
              ),
            ),
          ),
          _topBar(context),
        ],
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeHorizontal * 20,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Constants.primaryColor,
          border: Border.all(width: 0, color: Constants.primaryColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              //dismiss search page
              widget.onBackPressed();
              Navigator.pop(context, true);
            },
            child: Container(
              height: SizeConfig.blockSizeHorizontal * 13,
              width: SizeConfig.blockSizeHorizontal * 12,
              alignment: Alignment.center,
              color: Constants.primaryColor,
              child:
                  const Icon(Icons.arrow_back, color: Colors.white, size: 24),
            ),
          ),
          Container(
            height: SizeConfig.blockSizeHorizontal * 13,
            width: SizeConfig.blockSizeHorizontal * 83,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    controller: textEditingController,
                    autofocus: false,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14,
                        fontFamily: Constants.fontMedium),
                    onFieldSubmitted: (val) {},
                    onChanged: (v) {
                      EasyDebounce.debounce(
                          'Search-Debounce', const Duration(milliseconds: 500),
                          () {
                        //getSearchList(v);
                        _searchBLoc.add(SearchInitiate(
                            searchQ: v, forceRefresh: forceRefresh));
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Find your fitness center here ...',
                      hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontFamily: Constants.fontMedium),
                      //suffixIcon:
                      contentPadding: EdgeInsets.only(
                          top: SizeConfig.blockSizeHorizontal * 5,
                          bottom: SizeConfig.blockSizeHorizontal * 2,
                          right: SizeConfig.blockSizeHorizontal * 2,
                          left: SizeConfig.blockSizeHorizontal * 3),
                      errorStyle: const TextStyle(color: Colors.red),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          borderSide:
                              BorderSide(color: Colors.red[400]!, width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          borderSide:
                              BorderSide(color: Colors.red[400]!, width: 2)),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1)),
                      disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 2),
                  child: SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 10,
                    height: SizeConfig.blockSizeHorizontal * 10,
                    child: BlocBuilder<SearchBLoc, SearchState>(
                        builder: (context, state) {
                      if (textEditingController.text != '') {
                        return IconButton(
                            icon: Icon(
                              Icons.close_rounded,
                              size: 20,
                              color: Colors.red[500],
                            ),
                            onPressed: () {
                              textEditingController.text = '';
                              FocusScope.of(context).requestFocus(FocusNode());
                            });
                      }
                      return Icon(
                        HabitozIcons.epSearch,
                        size: 22,
                        color: Colors.grey[700],
                      );
                    }),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget displaySearchResult(List<FitnessCenterModel?>? searchList) {
    return (searchList!.isNotEmpty)
        ? ListView.builder(
            itemCount: searchList.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: SearchTile(
                    title: searchList[index]!.name!,
                    onPressed: () {
                      print(searchList[index]!.id);
                      BlocProvider.of<FCDetailBloc>(context).add(LoadDetailPage(
                          forceRefresh: true,
                          id: searchList[index]!.id.toString()));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FitnessCenterDetailPage(
                                    onBackPressed: () {},
                                  )));
                    },
                  ));
            })
        : Container();
  }

  Widget emptySearch() {
    return Container(
      height: SizeConfig.blockSizeHorizontal * 35,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 25,
            width: SizeConfig.blockSizeHorizontal * 25,
            child: Center(
              child: SvgPicture.asset('assets/images/svg/search_empty.svg'),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'No results found for ${textEditingController.text}',
            style: const TextStyle(
                color: Color.fromRGBO(153, 153, 153, 1),
                fontFamily: Constants.fontRegular,
                fontSize: 14),
          )
        ],
      ),
    );
  }

  Widget failedSearch() {
    return Container(
      height: SizeConfig.blockSizeHorizontal * 35,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 25,
            width: SizeConfig.blockSizeHorizontal * 25,
            child: Center(
              child: SvgPicture.asset('assets/images/svg/search_empty.svg'),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Something went wrong!',
            style: TextStyle(
                color: Color.fromRGBO(153, 153, 153, 1),
                fontFamily: Constants.fontRegular,
                fontSize: 14),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
    EasyDebounce.cancelAll();
  }
}
