
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habitoz_fitness_app/bloc/fc_list_bloc/fc_list_bloc.dart';
import 'package:habitoz_fitness_app/ui/Screens/gym/fitnes_center_details/fitness_center_detail_page.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/app_bar.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';
import '../../../../bloc/fc_detail_bloc/fc_detail_bloc.dart';
import '../../../../bloc/home_screen_bloc/home_bloc.dart';
import '../../../../models/fitness_center_list_model.dart';
import '../../../widgets/others/color_loader.dart';
import '../../others/choose_location.dart';
import 'components/gym_list_view_tile.dart';

class FitnessCenterListView extends StatefulWidget {
  final String? title;
  final String? slug;
  final String? categoryId;
  const FitnessCenterListView({Key? key,required this.title,required this.slug,this.categoryId}) : super(key: key);

  @override
  _FitnessCenterListViewState createState() => _FitnessCenterListViewState();
}

class _FitnessCenterListViewState extends State<FitnessCenterListView> {

  final _scrollController = ScrollController();
  late FCListBloc _fcListBloc;
  late FCDetailBloc _fcDetailBloc;
  late HomeBloc _homeBloc;

  late int _pageNo;
  late List<FitnessCenterModel> _fcList;
  late TextEditingController textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_onScroll);
    _fcListBloc = BlocProvider.of<FCListBloc>(context);
    _fcDetailBloc = BlocProvider.of<FCDetailBloc>(context);
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    textEditingController = TextEditingController();
    _pageNo = 1;
    _fcList = [];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      //service();
      _fcListBloc.add(PaginateListingPage(
        fcList: _fcList,
        forceRefresh: true,
        pageNo: _pageNo,
        slug: widget.slug,
        categoryId: widget.categoryId
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: (widget.title != null) ? widget.title! : 'Fitness Center List',
        isHomeAppBar: false,
        onBackPressed: (){
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

                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal * 7,
                  ),

                  locationWidget(),

                  BlocBuilder<FCListBloc, FCListState>(
                    builder: (context, state) {
                      if (state is FCListingFetchSuccess) {
                        _pageNo = state.pageNo;
                        _fcList.clear();
                        _fcList = state.fcList;
                        if(state.errorMsg != null){
                          showToast(state.errorMsg!);
                        }
                        if(state.fcList.isNotEmpty){
                          return fcListView(state.fcList, state.isLoading);
                        }
                        else{
                          return buildErrorView('List is empty!');
                        }
                      }
                      if (state is FCListingFetchFailure) {
                        return buildErrorView(state.message);
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

  Widget locationWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Row(
        children: [
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 4,
          ),
          Text(
            'Showing 23 results for Fitness centers in Kochi',
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 3.4,
                fontFamily: Constants.fontMedium,
                color: Constants.fontColor1),
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 3,
          ),
          InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChooseLocation(
                            onLocationUpdated: (){
                              _pageNo = 1;
                              _fcListBloc.add(LoadListingPage(
                                  forceRefresh: true,
                                  slug: widget.slug,
                                  pageNo: _pageNo,
                                  categoryId: widget.categoryId
                              ));
                              _homeBloc.add(LoadHome(forceRefresh: true));
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
    );
  }

  Widget searchWidget(){
    return Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 4,
            right: SizeConfig.blockSizeHorizontal * 4),
        child: Container(
          height: SizeConfig.blockSizeHorizontal * 13,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white, border: Border.all(color: Colors.black,width: 1) ,
              borderRadius: BorderRadius.circular(10)),
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
                  onFieldSubmitted: (val) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  onChanged: (v) {
                    EasyDebounce.debounce(
                        'Search-Debounce', const Duration(milliseconds: 500), () {
                      _pageNo = 1;
                      _fcList.clear();
                      _fcListBloc.add(SearchListingPage(
                          forceRefresh: true,
                          pageNo: _pageNo,
                          slug: widget.slug,
                          searchQ: textEditingController.text,
                          categoryId: widget.categoryId
                      ));
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search here ...',
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
                    child: (textEditingController.text != '') ?
                    IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          size: 20,
                          color: Colors.red[500],
                        ),
                        onPressed: () {
                          textEditingController.text = '';
                          _pageNo = 1;
                          _fcList.clear();
                          FocusScope.of(context).requestFocus(FocusNode());
                          _fcListBloc.add(RefreshListingPage(
                              forceRefresh: true,
                              pageNo: _pageNo,
                              slug: widget.slug,
                              categoryId: widget.categoryId
                          ));
                        }) :
                    Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.grey[700],
                    )
                ),
              ),
            ],
          ),
        )
    );

    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 4,
          right: SizeConfig.blockSizeHorizontal * 4),
      child: Container(
        height: SizeConfig.blockSizeHorizontal * 10,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white, border: Border.all(color: Colors.black,width: 1) ,
            borderRadius: BorderRadius.circular(5)),
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
                onFieldSubmitted: (val) {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                onChanged: (v) {
                  EasyDebounce.debounce(
                      'Search-Debounce', const Duration(milliseconds: 500), () {
                        _pageNo = 1;
                        _fcList.clear();
                            _fcListBloc.add(SearchListingPage(
                                forceRefresh: true,
                                pageNo: _pageNo,
                                slug: widget.slug,
                                searchQ: textEditingController.text
                            ));

                      });
                },
                decoration: InputDecoration(
                  hintText: 'Search here ...',
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
                child: (textEditingController.text != '') ?
                IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      size: 20,
                      color: Colors.red[500],
                    ),
                    onPressed: () {
                      textEditingController.text = '';
                      _pageNo = 1;
                      _fcList.clear();
                      FocusScope.of(context).requestFocus(FocusNode());
                      _fcListBloc.add(RefreshListingPage(
                          forceRefresh: true,
                          pageNo: _pageNo,
                          slug: widget.slug
                      ));
                    }) :
                Icon(
                  Icons.search,
                  size: 17,
                  color: Colors.grey[700],
                )
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget fcListView(List<FitnessCenterModel> fcList,bool isLoading){
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: fcList.length,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return GymListViewTile(
                  fcData: fcList[index],
                  onListTilePressed: (){
                    /*============Gym detail Page===============*/
                    _fcDetailBloc.add(LoadDetailPage(forceRefresh: true, id: fcList[index].id.toString()));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const FitnessCenterDetailPage()));
                  });
            }),

        (isLoading) ? Container(
          height: SizeConfig.blockSizeHorizontal*40,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: ColorLoader5(),
        ):Container()

      ],
    );
  }

  Widget buildErrorView(String msg){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: SizeConfig.blockSizeVertical*60,
      child: Center(
        child: Text(
          msg,
          style: const TextStyle(
              color: Constants.fontColor1,
              fontSize: 22,
              fontFamily: Constants.fontRegular
          ),
        ),
      ),
    );
  }

  Widget buildLoadingView(){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: SizeConfig.blockSizeVertical*60,
      child: Center(
        child: ColorLoader5(),
      ),
    );
  }

  showToast(String msg){
    Fluttertoast.showToast(msg: msg);
  }

  Future<void> refresh() async {
    _pageNo = 1;
    _fcList.clear();
    _fcListBloc.add(RefreshListingPage(
        forceRefresh: true,
        pageNo: _pageNo,
        slug: widget.slug,
        categoryId: widget.categoryId
    ));
    await Future.delayed(const Duration(seconds: 2), () {});
  }
}
