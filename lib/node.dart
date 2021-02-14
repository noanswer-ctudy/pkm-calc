class Node {
  Node left;
  double operand;
  String noperator;
  Node right;
  Node({Node left, double operand, String noperator, Node right}) {
    this.left = left;
    this.operand = operand;
    this.noperator = noperator;
    this.right = right;
  }
}
/* nodeCalculate(){
  if (targetNode.left.operand != null || targetNode.right.operand != null){
    switch(targetNode.operator){
      case '+':targetNode.operand = (targetNode.left.operand) + targetNode.right.operand;
      break;
      case '-':targetNode.operand = (targetNode.left.operand) - targetNode.right.operand;
      break;
      case '×':targetNode.operand = (targetNode.left.operand) * targetNode.right.operand;
      break;
      case '÷':targetNode.operand = (targetNode.left.operand) / targetNode.right.operand;
      break;
    }
  }
} */
