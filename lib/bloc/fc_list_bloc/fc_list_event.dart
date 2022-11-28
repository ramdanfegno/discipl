part of 'fc_list_bloc.dart';

abstract class FCListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadListingPage extends FCListEvent {
  final bool forceRefresh;
  final String? slug;
  final int pageNo;
  final String? searchQ;
  final String? categoryId;

  LoadListingPage({required this.forceRefresh,required this.slug,required this.pageNo,this.searchQ,this.categoryId});
}

class RefreshListingPage extends FCListEvent {
  final bool forceRefresh;
  final String? slug;
  final int pageNo;
  final String? searchQ;
  final String? categoryId;

  RefreshListingPage({required this.forceRefresh,required this.slug,required this.pageNo,this.searchQ,this.categoryId});
}

class SearchListingPage extends FCListEvent {
  final bool forceRefresh;
  final String? slug;
  final String? searchQ;
  final int pageNo;
  final String? categoryId;

  SearchListingPage({required this.forceRefresh,required this.slug,required this.searchQ,required this.pageNo,this.categoryId});
}

class PaginateListingPage extends FCListEvent {
  final bool forceRefresh;
  final String? slug;
  final int pageNo;
  final String? searchQ;
  final List<FitnessCenterModel>? fcList;
  final String? categoryId;

  PaginateListingPage({required this.forceRefresh,this.searchQ,required this.slug,required this.pageNo,required this.fcList,this.categoryId});
}
