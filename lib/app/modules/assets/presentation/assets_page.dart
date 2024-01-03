import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:animated_tree_view/tree_view/widgets/expansion_indicator.dart';
import 'package:animated_tree_view/tree_view/widgets/indent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tree_view_desafio/app/modules/assets/presentation/utils/tree_extension.dart';
import 'package:tree_view_desafio/app/modules/assets/presentation/widgets/search_filter.dart';
import '../domain/models/item_model.dart';
import 'assets_controller.dart';
import 'utils/item_extensions.dart';

class AssetsPage extends StatelessWidget {
  const AssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssetsController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Assets'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchFilter(
                onChanged: (name) => controller.search(name),
              ),
              controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : buildTreeView(controller.assets),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTreeView(List<Item> items) {
    final tree = items.toTreeNodes();
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
}
