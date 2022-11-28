part of 'fc_detail_bloc.dart';

abstract class FCDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadDetailPage extends FCDetailEvent {
  final bool forceRefresh;
  final String? id;
  LoadDetailPage({required this.forceRefresh,required this.id});
}
