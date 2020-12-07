import 'dart:io';

import 'package:proyectoIA/helpers/ApiHelper.dart';
import 'package:proyectoIA/helpers/StatePanel.dart';
import 'package:proyectoIA/helpers/bloc.dart';
import 'package:proyectoIA/models/Entidad.dart';
import 'package:rxdart/rxdart.dart';

class ScanBloc extends Bloc {
  final ApiHelper api = new ApiHelper();
  final _statePanel = BehaviorSubject<StatePanel>();
  var _type;
  get type => _type;
  Stream<StatePanel> get statePanel => _statePanel.stream;
  Entidad _entidad;
  Entidad get entidad => _entidad;
  void init(int type) {
    _type = type;
    _statePanel.add(new StatePanel.none());
  }

  Future sendFile(File path) async {
    try {
      _statePanel.add(new StatePanel.loading());
      if (_type == 1) {
        _entidad = await api.postPlantFile(path);
      } else {
        _entidad = await api.postPetFile(path);
      }
      //await api.test();
      _statePanel.add(new StatePanel.success("OK", null, 200));
    } catch (err) {
      _statePanel.add(new StatePanel.error("ups", 300));
    }
  }

  @override
  void dispose() {
    _statePanel.close();
  }
}
