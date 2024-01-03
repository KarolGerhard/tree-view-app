import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:animated_tree_view/tree_view/widgets/expansion_indicator.dart';
import 'package:animated_tree_view/tree_view/widgets/indent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tree_view_desafio/app/modules/assets/presentation/widgets/search_filter.dart';
import '../domain/usecases/list_data.dart';
import 'assets_controller.dart';
import 'utils/item_extensions.dart';

class AssetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssetsController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Assets'),
        ),
        body: Column(
          children: [
            const SearchFilter(),
            SingleChildScrollView(
              child: controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : buildTreeView(controller.assets),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTreeView(List<Item> items) {
    final tree = buildTree(items);
    return TreeView.simpleTyped<Item, TreeNode<Item>>(
      tree: tree,
      padding: const EdgeInsets.all(8),
      expansionBehavior: ExpansionBehavior.collapseOthersAndSnapToTop,
      shrinkWrap: true,
      showRootNode: false,
      indentation: const Indentation(style: IndentStyle.squareJoint),
      expansionIndicatorBuilder: (context, node) {
        return ChevronIndicator.rightDown(
          alignment: Alignment.centerLeft,
          tree: node,
          color: Colors.black,
          icon: Icons.keyboard_arrow_right,
          // padding: const EdgeInsets.all(4),
        );
      },
      builder: (context, node) => ListTile(
        leading: Image.asset(node.data?.icon ?? '', width: 20, height: 20),
        title: Text(node.data?.name ?? ''),
        trailing: node.data?.sensorIcon,
      ),
    );
  }

  TreeNode<Item> buildTree(List<Item> items) {
    final tree = TreeNode<Item>.root();
    return buildNodes(items, tree);
  }

  buildNodes(List<Item> items, TreeNode<Item> tree) {
    for (var item in items) {
      if (item is Asset) {
        buildAssetNode(tree, item);
      } else if (item is Local) {
        buildLocalNode(item, tree);
      } else if (item is Component) {
        buildComponentNode(tree, item);
      }
    }
    return tree;
  }

  void buildLocalNode(Local item, TreeNode<Item> tree) {
    final localNode = TreeNode<Local>(data: item);
    tree.add(localNode);
    if (item.subItems.isNotEmpty) {
      buildNodes(item.subItems, localNode);
    } else if (item.assets.isNotEmpty) {
      buildNodes(item.assets, localNode);
    }
  }

  void buildAssetNode(TreeNode<Item> tree, Asset item) {
    final assetNode = TreeNode<Asset>(data: item);
    tree.add(assetNode);
    if (item.subAssets.isNotEmpty) {
      buildNodes(item.subAssets, assetNode);
    } else if (item.components.isNotEmpty) {
      buildNodes(item.components, assetNode);
    }
  }

  void buildComponentNode(TreeNode<Item> tree, Component item) {
    final assetNode = TreeNode<Component>(data: item);
    tree.add(assetNode);
    if (item.components.isNotEmpty) {
      buildNodes(item.components, assetNode);
    }
  }
}

