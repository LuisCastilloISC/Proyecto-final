import 'dart:io';

import 'package:proyectoIA/helpers/ApiHelper.dart';
import 'package:proyectoIA/helpers/StatePanel.dart';
import 'package:proyectoIA/helpers/bloc.dart';
import 'package:rxdart/rxdart.dart';

class ScanBloc extends Bloc {
  final ApiHelper api = new ApiHelper();
  final _statePanel = BehaviorSubject<StatePanel>();
  Stream<StatePanel> get statePanel => _statePanel.stream;
  var _entidad;
  get entidad => _entidad;
  void init() {
    _statePanel.add(new StatePanel.none());
  }

  Future sendFile(File path) async {
    try {
      _statePanel.add(new StatePanel.loading());
      _entidad = await api.postUserImageFile(path);
      //await api.test();
       _statePanel.add(new StatePanel.success("OK", null, 200));
    } catch (err) {}
  }

  @override
  void dispose() {
    _statePanel.close();
  }
}
