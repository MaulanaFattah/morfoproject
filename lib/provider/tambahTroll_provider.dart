import 'package:flutter/foundation.dart';
import 'package:morfo/model/troll_model.dart';

class TrollProvider extends ChangeNotifier {
  List<Troll> listBarang = [];

  List<Troll> get users => listBarang;

  void addTroll(Troll barang) {
    listBarang.add(barang);
    notifyListeners();
  }

  void removeTroll(Troll barang) {
    listBarang.remove(barang);
    notifyListeners();
  }
}
