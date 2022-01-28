import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit() : super(NetworkInitial());
  void loading(){
    emit(NetworkInitial());
  }
  void success(){
    emit(NetworkSuccess('This is Data'));
  }
  void failure(){
    emit(NetworkFailure('This is error'));
  }
}
