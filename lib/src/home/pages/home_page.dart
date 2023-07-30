import 'package:estudoshttp/src/home/htpp/http_client.dart';
import 'package:estudoshttp/src/home/repositories/produtos_repository.dart';
import 'package:estudoshttp/src/home/services/utils_services.dart';
import 'package:estudoshttp/src/home/stores/produtos_store.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final store = ProdutosStore(
    repository: ProdutosRepository(
      client: HttpClient(),
    ),
  );

  UtilsServices utilsServices = UtilsServices();

  @override
  void initState() {
    super.initState();
    store.getProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
            )
          ],
          title: const Text(
            "Loja online",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: AnimatedBuilder(
          animation: Listenable.merge([store.isloading, store.state]),
          builder: (context, child) {
            if (store.isloading.value) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Carregando...")
                  ],
                ),
              );
            }
            if (store.state.value.isEmpty) {
              return const Center(
                child: Text("Lista vazia"),
              );
            } else {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 3,
                ),
                itemCount: store.state.value.length,
                itemBuilder: (_, index) {
                  final item = store.state.value[index];
                  return Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              item.thumbnail,
                              scale: 1.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                utilsServices.convertCoins(item.price),
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          const Text(
                            "Description:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            item.description,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
