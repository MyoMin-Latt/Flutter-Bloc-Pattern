part of 'network_cubit.dart';

@immutable
abstract class NetworkState {}

class NetworkInitial extends NetworkState {}
class NetworkSuccess extends NetworkState{
  final String data;
  NetworkSuccess(this.data);
}
class NetworkFailure extends NetworkState{
  final String error;
  NetworkFailure(this.error);
}