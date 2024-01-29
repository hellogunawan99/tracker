import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracker/config/app_format.dart';
import '../../../data/model/product.dart';
import '../../controller/c_product.dart';
import 'add_update_product_page.dart';

import '../../../data/source/source_product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final cProduct = Get.put(CProduct());
  deleteProduct(String code) async {
    bool? yes = await DInfo.dialogConfirmation(
        context, 'Delete Product', 'You sure to delete product?');
    if (yes ?? false) {
      bool success = await SourceProduct.delete(code);
      if (success) {
        DInfo.dialogSuccess('Success Delete Product');
        DInfo.closeDialog(actionAfterClose: () {
          cProduct.setList();
        });
      } else {
        DInfo.dialogError('Failed Delete Product');
        DInfo.closeDialog();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barang'),
        titleSpacing: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const AddUpdateProductPage())!.then((value) {
                if (value ?? false) {
                  cProduct.setList();
                }
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (cProduct.loading) return DView.loadingCircle();
              if (cProduct.list.isEmpty) return DView.empty();
              return ListView.separated(
                itemCount: cProduct.list.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 10,
                    color: Colors.black,
                    indent: 16,
                    endIndent: 16,
                  );
                },
                itemBuilder: (context, index) {
                  Product product = cProduct.list[index];
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                      16,
                      index == 0 ? 16 : 8,
                      0,
                      index == 9 ? 16 : 0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                            height: 20,
                            width: 35,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name ?? '',
                                style: textTheme.titleMedium!.copyWith(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              DView.spaceHeight(4),
                              Text(
                                product.code ?? '',
                                style: textTheme.titleSmall!.copyWith(
                                  fontSize: 15,
                                  color: Colors.indigo[300],
                                ),
                              ),
                              DView.spaceHeight(20),
                              Text(
                                product.sn ?? '',
                                style: textTheme.titleSmall!.copyWith(
                                  fontSize: 13,
                                  color: Colors.blueGrey[200],
                                ),
                              ),
                              DView.spaceHeight(16),
                              Text(
                                'Rp ${AppFormat.currency(product.price ?? '0')}',
                                style: textTheme.titleMedium!.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                product.lokasi ?? '',
                                style: textTheme.titleMedium!.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber),
                              ),
                              DView.spaceHeight(4),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Text(
                                product.stock.toString(),
                                style: textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 23,
                                    color: Colors.green[600]),
                              ),
                            ),
                            DView.spaceHeight(4),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Text(
                                product.unit ?? '',
                                style: textTheme.titleSmall!.copyWith(
                                  fontSize: 15,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                            DView.spaceHeight(4),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Text(
                                product.kondisi ?? '',
                                style: textTheme.titleSmall!.copyWith(
                                  fontSize: 17,
                                  color: Colors.cyan[600],
                                ),
                              ),
                            ),
                            PopupMenuButton(
                              color: Colors.blue,
                              onSelected: (value) {
                                if (value == 'update') {
                                  Get.to(() => AddUpdateProductPage(
                                          product: product))!
                                      .then((value) {
                                    if (value ?? false) cProduct.setList();
                                  });
                                } else {
                                  deleteProduct(product.code!);
                                }
                              },
                              icon: const Icon(Icons.more_horiz),
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'update',
                                  child: Text('Update'),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // _searchBar() {
  //   return Padding(
  //     padding: EdgeInsets.all(8),
  //     child: TextField(
  //       decoration: InputDecoration(hintText: 'Search...'),
  //       onChanged: (text) {
  //         text = text.toLowerCase();
  //         setState(() {});
  //       },
  //     ),
  //   );
  // }
}
