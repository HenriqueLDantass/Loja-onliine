import 'package:estudoshttp/src/home/models/produto_model.dart';
import 'package:estudoshttp/src/home/repositories/produtos_repository.dart';
import 'package:flutter/material.dart';

class ProdutosStore {
  final IProductoReposity repository;
  final ValueNotifier<bool> isloading = ValueNotifier<bool>(false);

  final ValueNotifier<List<ProdutosModel>> state =
      ValueNotifier<List<ProdutosModel>>([]);

  ProdutosStore({required this.repository});

  getProdutos() async {
    isloading.value = true;
    try {
      final results = await repository.getProdutos();
      state.value = results;
    } catch (e) {
      print(e);
    }
    isloading.value = false;
  }
}
