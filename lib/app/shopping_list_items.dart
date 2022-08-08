import 'package:flutter/material.dart';
import '../../app/product_item.dart';

class ShoppingListItems extends StatelessWidget {
  final List<ProductItem> products;
  final Function(ProductItem)? onTapFavorite;

  const ShoppingListItems({
    Key? key,
    required this.products,
    this.onTapFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: _getAxisCount(context),
      children: List.generate(
        10,
        (index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: CardShoppingItem(
              product: products[index],
              onTapFavorite: onTapFavorite,
            ),
          );
        },
      ),
    );
  }

  int _getAxisCount(BuildContext context) {
    if(MediaQuery.of(context).size.width < 560) {
      return 1;
    } else if(MediaQuery.of(context).size.width < 825) {
      return 2;
    } else if(MediaQuery.of(context).size.width < 1100) {
      return 3;
    }

    return 4;
  }
}

class CardShoppingItem extends StatelessWidget {
  final ProductItem product;
  final Function(ProductItem)? onTapFavorite;

  const CardShoppingItem({
    Key? key,
    required this.product,
    this.onTapFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              spreadRadius: 0.1,
            ),
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => onTapFavorite?.call(product),
                child: Icon(
                  product.favorite ? Icons.favorite : Icons.favorite_border,
                ),
              ),
            ],
          ),
          Expanded(
            child: Image.network(
              product.imgUrl,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w200,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product.price.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
