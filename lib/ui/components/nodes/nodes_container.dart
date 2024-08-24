import 'package:flutter/material.dart';
import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/ui/components/nodes/node_editor_grid_painter.dart';
import 'package:minddy/ui/theme/theme.dart';

class NodesContainer extends StatefulWidget {
  const NodesContainer({super.key});

  @override
  State<NodesContainer> createState() => _NodesContainerState();
}

class _NodesContainerState extends State<NodesContainer> {

  List<Offset> nodes = [Offset(100, 100), Offset(200, 200)];
  int selectedNodeId = 0;
  bool shouldRefreshAll = false;

  Key key = UniqueKey();

  void setIsSelected(int id, bool refreshAll) {
    setState(() {
      selectedNodeId = id;
      shouldRefreshAll = refreshAll;
    });
    if (refreshAll) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          shouldRefreshAll = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);

    return Container(
      color: theme.primaryContainer,
      height: MediaQuery.of(context).size.height / 1.5,
      child: InteractiveViewer(
        minScale: 0.1,
        maxScale: 5,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                setIsSelected(0, true);
              },
              child: CustomPaint(
                size: const Size(double.infinity, double.infinity),
                painter: NodeEditorGridPainter(
                  scale: 1.0,
                  theme: theme
                ),
              ),
            ),
            ...nodes.asMap().entries.map((entry) {
              int index = entry.key;
              Offset nodePosition = entry.value;
              return Positioned(
                left: nodePosition.dx,
                top: nodePosition.dy,
                child: DraggableNode(
                  key: shouldRefreshAll ? UniqueKey() : key,
                  index: index,
                  position: nodePosition,
                  setIsSelected: setIsSelected,
                  getIsSelected: () => selectedNodeId,
                  id: createUniqueId(),
                  onDragEnd: (offset) {
                    setState(() {
                      nodes[index] = offset;
                    });
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

class DraggableNode extends StatefulWidget {
  final int index;
  final Offset position;
  final ValueChanged<Offset> onDragEnd;
  final Function(int, bool) setIsSelected;
  final int Function() getIsSelected;
  final int id;

  const DraggableNode({
    super.key,
    required this.index,
    required this.position,
    required this.onDragEnd,
    required this.id, 
    required this.setIsSelected, 
    required this.getIsSelected
  });

  @override
  State<DraggableNode> createState() => _DraggableNodeState();
}

class _DraggableNodeState extends State<DraggableNode> {

  bool isSelected = false;

  @override
  void initState() {
    setState(() {
      isSelected = widget.id == widget.getIsSelected();  
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        widget.onDragEnd(widget.position + (details.delta * 2.1));
      },
      onPanStart: (details) {
        widget.setIsSelected(widget.id, false);
        setState(() {
          isSelected = widget.id == widget.getIsSelected();
        });
      },
      onTap: () {
        widget.setIsSelected(isSelected ? 0 : widget.id, true);
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? Colors.orange : Colors.transparent, width: isSelected ? 2.0 : 0),
        ),
        child: Center(
          child: Text('Node ${widget.index}'),
        ),
      ),
    );
  }
}
