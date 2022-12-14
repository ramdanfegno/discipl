import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habitoz_fitness_app/bloc/fc_list_bloc/fc_list_bloc.dart';
import 'package:habitoz_fitness_app/models/zone_list_model.dart';
import 'package:habitoz_fitness_app/repositories/product_repo.dart';
import 'package:habitoz_fitness_app/ui/Screens/gym/fitnes_center_details/fitness_center_detail_page.dart';
import 'package:habitoz_fitness_app/ui/screens/gym/fitness_center_list/components/search_widget.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/app_bar.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';
import '../../../../bloc/fc_detail_bloc/fc_detail_bloc.dart';
import '../../../../bloc/home_screen_bloc/home_bloc.dart';
import '../../../../bloc/search_center_bloc/search_center_bloc.dart';
import '../../../../models/fitness_center_list_model.dart';
import '../../../../utils/habitoz_icons.dart';
import '../../../widgets/others/color_loader.dart';
import '../../zone_search/choose_location.dart';
import '../../search/search_page.dart';
import 'components/gym_list_view_tile.dart';

class FitnessCenterListView extends StatefulWidget {
  final String? title;
  final String? slug;
  final String? categoryId;
  final ZoneResult? zone;

  const FitnessCenterListView(
      {Key? key,
      required this.title,
      required this.slug,
      this.categoryId,
      required this.zone})
      : super(key: key);

  @override
  _FitnessCenterListViewState createState() => _FitnessCenterListViewState();
}

class _FitnessCenterListViewState extends State<FitnessCenterListView> {
  final _scrollController = ScrollController();
  late FCListBloc _fcListBloc;
  late FCDetailBloc _fcDetailBloc;
  late HomeBloc _homeBloc;
  final ProductRepository productRepository = ProductRepository();
  late int _pageNo;
  late ZoneResult? _zone;
  late List<FitnessCenterModel> _fcList;

  //late TextEditingController textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _zone = widget.zone;
    _scrollController.addListener(_onScroll);
    _fcListBloc = BlocProvider.of<FCListBloc>(context);
    _fcDetailBloc = BlocProvider.of<FCDetailBloc>(context);
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    //textEditingController = TextEditingController();
    _pageNo = 1;
    _fcList = [];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _onScroll() {
    //print('_onScroll');
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print('PaginateListingPage');
      print(_pageNo);
      //service();
      _fcListBloc.add(PaginateListingPage(
          fcList: _fcList,
          forceRefresh: true,
          pageNo: _pageNo,
          slug: widget.slug,
          categoryId: widget.categoryId,
          zone: widget.zone));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle:
            (widget.title != null) ? widget.title! : 'Fitness Center List',
        isHomeAppBar: false,
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refresh,
          color: Constants.primaryColor,
          backgroundColor: Colors.white,
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: Constants.primaryColor.withOpacity(0.3),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal * 7.5,
                    width: MediaQuery.of(context).size.width,
                  ),
                  searchWidget(),

                  /*SearchWidget(
                    onChanged: (v){
                      _pageNo = 1;
                      _fcList.clear();
                      _fcListBloc.add(SearchListingPage(
                          forceRefresh: true,
                          pageNo: _pageNo,
                          slug: widget.slug,
                          searchQ: v,
                          categoryId: widget.categoryId,
                          zone: _zone
                      ));
                    },
                    onCleared: () {
                      _pageNo = 1;
                      _fcList.clear();
                      FocusScope.of(context).requestFocus(FocusNode());
                      _fcListBloc.add(RefreshListingPage(
                          forceRefresh: true,
                          pageNo: _pageNo,
                          slug: widget.slug,
                          categoryId: widget.categoryId,
                          zone: _zone
                      ));
                    },
                  ),*/

                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal * 7,
                  ),
                  BlocBuilder<FCListBloc, FCListState>(
                    builder: (context, state) {
                      if (state is FCListingFetchSuccess) {
                        print('FCListingFetchSuccess');
                        _pageNo = state.pageNo;
                        print(_pageNo);
                        _fcList.clear();
                        _fcList = state.fcList;
                        if (state.errorMsg != null) {
                          showToast(state.errorMsg!);
                        }

                        if (state.fcList.isNotEmpty) {
                          print('state.fcList.isNotEmpty');
                          return fcListView(state.fcList, state.isLoading);
                        } else {
                          print('state.fcList.empty');
                          return buildErrorView(state.fcList, 'List is empty');
                        }
                      }
                      if (state is FCListingFetchFailure) {
                        return buildErrorView(state.fcList!, state.message);
                      }
                      if (state is FCListingFetchLoading) {
                        return buildLoadingView();
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget locationWidget(List<FitnessCenterModel> fcList) {
    String s = 'Locatiob';
    if (_zone != null && _zone!.name != null) {
      s = _zone!.name!;
    }

    String v = '';
    if (fcList.isNotEmpty) {
      v = fcList.length.toString();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Padding(
        padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 42.5,
              child: Text(
                'Showing $v results',
                style: const TextStyle(
                    fontSize: 13,
                    fontFamily: Constants.fontMedium,
                    color: Constants.fontColor1),
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 3,
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 45,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(),
                    const Icon(
                      Icons.location_on,
                      color: Constants.primaryColor,
                    ),
                    Text(' $s'),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChooseLocation(
                                      onLocationUpdated: (zone) {
                                        _pageNo = 1;
                                        _zone = zone;
                                        _fcListBloc.add(LoadListingPage(
                                          forceRefresh: true,
                                          slug: widget.slug,
                                          pageNo: _pageNo,
                                          categoryId: widget.categoryId,
                                          zone: zone,
                                        ));
                                        _homeBloc.add(LoadHome(
                                            forceRefresh: true, zone: _zone));
                                      },
                                      onBackPressed: () {
                                        print('ChooseLocation onBackPressed');
                                        _pageNo = 1;
                                        _fcList.clear();
                                        _fcListBloc.add(RefreshListingPage(
                                            forceRefresh: true,
                                            pageNo: _pageNo,
                                            slug: widget.slug,
                                            categoryId: widget.categoryId,
                                            zone: _zone));
                                      },
                                    )));
                      },
                      child: Text(
                        'Change',
                        style: TextStyle(
                            color: Constants.primaryColor,
                            fontFamily: Constants.fontBold,
                            fontSize: SizeConfig.blockSizeHorizontal * 3.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchWidget() {
    return Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 4,
            right: SizeConfig.blockSizeHorizontal * 4),
        child: InkWell(
          onTap: () {
            Navigator.push(context, _createSearchRoute());
          },
          child: Container(
            height: SizeConfig.blockSizeHorizontal * 13,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    enabled: false,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14,
                        fontFamily: Constants.fontMedium),
                    onFieldSubmitted: (val) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    onChanged: (v) {
                      /*EasyDebounce.debounce(
                          'Search-Debounce', const Duration(milliseconds: 500), () {
                        _pageNo = 1;
                        _fcList.clear();
                        _fcListBloc.add(SearchListingPage(
                            forceRefresh: true,
                            pageNo: _pageNo,
                            slug: widget.slug,
                            searchQ: textEditingController.text,
                            categoryId: widget.categoryId,
                            zone: _zone
                        ));
                      });*/
                    },
                    decoration: InputDecoration(
                      hintText: 'Search ...',
                      hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontFamily: Constants.fontMedium),
                      //suffixIcon:
                      contentPadding: EdgeInsets.only(
                          top: SizeConfig.blockSizeHorizontal * 5,
                          bottom: SizeConfig.blockSizeHorizontal * 2,
                          right: SizeConfig.blockSizeHorizontal * 2,
                          left: SizeConfig.blockSizeHorizontal * 4),
                      errorStyle: const TextStyle(color: Colors.red),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          borderSide:
                              BorderSide(color: Colors.red[400]!, width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          borderSide:
                              BorderSide(color: Colors.red[400]!, width: 2)),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1)),
                      disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
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
                      child: Icon(
                        HabitozIcons.epSearch,
                        size: 20,
                        color: Colors.grey[700],
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  Widget fcListView(List<FitnessCenterModel> fcList, bool isLoading) {
    return Column(
      children: [
        (fcList.isNotEmpty)
            ? locationWidget(fcList)
            : Container(
                height: 20,
                width: 500,
                color: Colors.red,
              ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: fcList.length,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return GymListViewTile(
                  fcData: fcList[index],
                  onListTilePressed: () {
                    /*============Gym detail Page===============*/
                    _fcDetailBloc.add(LoadDetailPage(
                        forceRefresh: true, id: fcList[index].id.toString()));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FitnessCenterDetailPage(
                                  onBackPressed: () {
                                    print(
                                        'FitnessCenterDetailPage onBackPressed');
                                    _pageNo = 1;
                                    _fcList.clear();
                                    _fcListBloc.add(RefreshListingPage(
                                        forceRefresh: true,
                                        pageNo: _pageNo,
                                        slug: widget.slug,
                                        categoryId: widget.categoryId,
                                        zone: _zone));
                                  },
                                )));
                  });
            }),
        (isLoading)
            ? Container(
                height: SizeConfig.blockSizeHorizontal * 40,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: ColorLoader5(),
              )
            : Container()
      ],
    );
  }

  Widget buildErrorView(List<FitnessCenterModel> fcList, String msg) {
    return Column(
      children: [
        locationWidget(fcList),



        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: SizeConfig.blockSizeVertical * 60,
          child: Center(
            child: Text(
              msg,
              style: const TextStyle(
                  color: Constants.fontColor1,
                  fontSize: 22,
                  fontFamily: Constants.fontRegular),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLoadingView() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: SizeConfig.blockSizeVertical * 60,
      child: Center(
        child: ColorLoader5(),
      ),
    );
  }

  showToast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  Future<void> refresh() async {
    _pageNo = 1;
    _fcList.clear();
    _fcListBloc.add(RefreshListingPage(
        forceRefresh: true,
        pageNo: _pageNo,
        slug: widget.slug,
        categoryId: widget.categoryId,
        zone: _zone));
    await Future.delayed(const Duration(seconds: 2), () {});
  }

  Route _createSearchRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
              create: (context) => SearchBLoc(
                productRepository: productRepository,
              ),
              child: SearchPage(
                onBackPressed: () {
                  print('SearchPage onBackPressed');
                  _pageNo = 1;
                  _fcList.clear();
                  _fcListBloc.add(RefreshListingPage(
                      forceRefresh: true,
                      pageNo: _pageNo,
                      slug: widget.slug,
                      categoryId: widget.categoryId,
                      zone: _zone));
                },
              ),
            ),
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }
}
