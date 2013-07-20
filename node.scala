class Node (val value:Any) {
  
  var next:Option[None] = None
  var tail = this

  def push(nvalue: Any):Node = {
    val node = new Node(nvalue)
    this.tail.next = Some(node)
    this.tail = node
    return(node)
  }

  def hasNext(): Boolean = {
    return this.next match {
      case None => false
      case Some(v) => true
    }
  }

  def each(callback: (Node) => Unit) = {
    var node = this
    callback(node)
    while(node.hasNext()) {
      node.next match {
        case Some(v) => callback(v)
        case None => null
      }
      node = node.next.getOrElse(null).asInstanceOf[Node]
    }
  }
}


val list = new Node(2)
list.push(3)
list.push(4)

list.each(xs => println(xs.value))
