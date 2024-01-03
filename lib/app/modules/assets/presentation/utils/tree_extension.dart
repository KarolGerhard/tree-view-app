import 'package:animated_tree_view/tree_view/tree_node.dart';
import '../../domain/models/item_model.dart';

extension ListItemExtension on List<Item> {
  TreeNode<Item> toTreeNodes() {
    final tree = TreeNode<Item>.root();
    return buildNodes(this, tree);
  }

  buildNodes(List<Item> items, TreeNode<Item> tree) {
    for (var item in items) {
      final node = TreeNode<Item>(data: item);
      tree.add(node);
      if (item.subItems.isNotEmpty) {
        buildNodes(item.subItems, node);
      }
    }
    return tree;
  }

}
