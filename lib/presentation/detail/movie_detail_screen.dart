import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/domain/model/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: movie.imageUrl != null ? 250.0 : null,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(movie.title),
              background: movie.imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: movie.imageUrl!,
                    )
                  : null,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    top: 12.0,
                    right: 24.0,
                    bottom: 24.0,
                  ),
                  child: const Text(
                    '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed id massa non mauris ultrices tincidunt. Pellentesque finibus consectetur suscipit. Suspendisse ut consectetur eros. Nullam ac felis nisl. Aliquam eleifend ligula id bibendum cursus. Phasellus egestas sem a tortor tincidunt, nec aliquet diam cursus. Sed sodales rhoncus nunc in vehicula. Quisque pulvinar velit massa, ac tincidunt purus volutpat in. Aliquam convallis, nunc quis luctus aliquet, velit quam consequat libero, vulputate commodo lacus nisl sit amet nunc. Sed lacinia ex purus, nec tristique metus bibendum ac. Integer ut ante in dui luctus accumsan ac id turpis. Duis bibendum tempor sem. In hac habitasse platea dictumst. Suspendisse libero orci, accumsan ac velit convallis, consectetur viverra ligula.

Aliquam iaculis lorem ac neque iaculis consectetur. Integer volutpat elit eu mi blandit, id ultrices leo congue. Donec eros turpis, iaculis sit amet maximus at, eleifend et felis. Nullam efficitur rhoncus bibendum. Sed imperdiet, nisl varius auctor imperdiet, ex ipsum cursus ipsum, non gravida odio nibh vitae augue. Phasellus sit amet suscipit ante. Vestibulum in lacus in nibh iaculis iaculis. Nulla in mauris vel ante blandit molestie sed eget leo. Donec id magna ac ex fermentum posuere. Ut vitae massa vehicula, facilisis sem ultricies, finibus dui. Nunc eleifend cursus aliquam. Nullam sed odio in neque faucibus finibus.

In hac habitasse platea dictumst. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Integer vitae convallis neque. Curabitur ultrices varius leo. Aliquam quis congue lacus. Pellentesque eget varius ipsum. Nam sed nulla in justo pretium dictum. Vivamus ut ligula nisl. Morbi volutpat vehicula diam, euismod dapibus sapien faucibus ac. Duis nunc mi, accumsan blandit ante ac, laoreet tristique mi. Nulla id velit tincidunt, volutpat est vel, aliquet ligula.

Sed consequat nulla enim, in tincidunt lacus laoreet id. Maecenas lacus est, venenatis id feugiat id, fringilla ac odio. Nullam sollicitudin, augue eu dictum egestas, sem orci venenatis eros, nec tempus ante nibh quis velit. Morbi sit amet purus nibh. Donec ut nulla vel libero cursus eleifend in eu nisl. Vivamus mollis, ipsum eu vestibulum tincidunt, sem elit pharetra orci, vitae hendrerit ligula velit in mauris. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed lobortis elit id dapibus tincidunt. Duis posuere, risus quis cursus viverra, ligula sapien dictum dui, sit amet ultrices est justo feugiat dolor. Quisque congue feugiat leo, a mattis odio bibendum vel.

Morbi dignissim, purus a rhoncus iaculis, quam urna tincidunt metus, et congue sem quam eu nisi. Donec et congue velit. Maecenas efficitur augue et enim ultrices, ac feugiat purus gravida. Integer quis arcu ut neque auctor dapibus non vel velit. Quisque condimentum dolor lectus, ut euismod lorem blandit ac. Nullam et fringilla purus. Vestibulum volutpat tempor velit, fringilla elementum sem tristique condimentum. Donec ac sapien vitae ex malesuada tincidunt. Nunc lacus magna, lobortis vitae malesuada ut, accumsan nec massa. Ut porta lacus ac turpis dapibus tincidunt. Etiam cursus, arcu nec auctor pulvinar, sapien nibh rutrum tellus, vitae eleifend ipsum massa vel tortor. Aenean suscipit auctor est id gravida. Ut malesuada commodo nulla quis tempor. Donec lobortis turpis eu enim vehicula, eget commodo quam finibus. Mauris ut nulla rhoncus, malesuada justo quis, scelerisque erat.
              ''',
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
