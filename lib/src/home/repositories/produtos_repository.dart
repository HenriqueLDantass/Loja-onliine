import 'dart:convert';

import 'package:estudoshttp/src/home/htpp/http_client.dart';
import 'package:estudoshttp/src/home/models/produto_model.dart';

abstract class IProductoReposity {
  Future<List<ProdutosModel>> getProdutos();
}

class ProdutosRepository implements IProductoReposity {
  final IHttpClient client;

  ProdutosRepository({required this.client});

  final List<ProdutosModel> produtos = [];
  @override
  Future<List<ProdutosModel>> getProdutos() async {
    final response = await client.get(url: "https://dummyjson.com/products");

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      body['products'].map((item) {
        final ProdutosModel produto = ProdutosModel.fromMap(item);
        produtos.add(produto);
      }).toList();

      return produtos;
    } else {
      return [];
    }
  }
}
