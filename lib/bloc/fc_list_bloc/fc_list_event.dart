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

  LoadListingPage({required this.forceRefresh,required this.slug,required this.pageNo,this.searchQ});
}

class RefreshListingPage extends FCListEvent {
  final bool forceRefresh;
  final String? slug;
  final int pageNo;
  final String? searchQ;

  RefreshListingPage({required this.forceRefresh,required this.slug,required this.pageNo,this.searchQ});
}

class SearchListingPage extends FCListEvent {
  final bool forceRefresh;
  final String? slug;
  final String? searchQ;
  final int pageNo;

  SearchListingPage({required this.forceRefresh,required this.slug,required this.searchQ,required this.pageNo});
}

class PaginateListingPage extends FCListEvent {
  final bool forceRefresh;
  final String? slug;
  final int pageNo;
  final String? searchQ;
  final List<FitnessCenterModel>? fcList;

  PaginateListingPage({required this.forceRefresh,this.searchQ,required this.slug,required this.pageNo,required this.fcList});
}
