import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'product_layout.dart';

class ProductSkeletonView extends StatelessWidget {
  final ProductLayout layout;

  const ProductSkeletonView({
    super.key,
    required this.layout,
  });

  @override
  Widget build(BuildContext context) {
    if (layout == ProductLayout.grid) {
      return GridView.builder(
        padding:
            const EdgeInsets.fromLTRB(16, 12, 16, 16),
        itemCount: 6,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.68,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (_, __) =>
            const _GridSkeletonCard(),
      );
    }

    return ListView.separated(
      padding:
          const EdgeInsets.fromLTRB(16, 12, 16, 16),
      itemCount: 6,
      separatorBuilder: (_, __) =>
          const SizedBox(height: 12),
      itemBuilder: (_, __) =>
          const _ListSkeletonCard(),
    );
  }
}

//////////////////////////////////////////////////////////////
/// GRID
//////////////////////////////////////////////////////////////

class _GridSkeletonCard extends StatelessWidget {
  const _GridSkeletonCard();

  @override
  Widget build(BuildContext context) {
    return _shimmer(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              height: 140,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(
                        top: Radius.circular(16)),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    _line(),
                    const SizedBox(height: 6),
                    _line(width: 80),
                    const Spacer(),
                    _line(width: 60, height: 18),
                    const SizedBox(height: 8),
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////
/// LIST
//////////////////////////////////////////////////////////////

class _ListSkeletonCard extends StatelessWidget {
  const _ListSkeletonCard();

  @override
  Widget build(BuildContext context) {
    return _shimmer(
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(12),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  _line(),
                  const SizedBox(height: 6),
                  _line(width: 140),
                  const SizedBox(height: 8),
                  _line(width: 60, height: 18),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////
/// HELPERS
//////////////////////////////////////////////////////////////

Widget _shimmer(Widget child) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: child,
  );
}

Widget _line({double width = double.infinity,
double height = 14}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(4),
    ),
  );
}
