# pretty printer

A declarative-style pretty printer engine, which includes printers for built-in 
types such as `Array`, `Map`, and `Json`.

## Usage

Use `render` to pretty print any type implemented `Pretty` trait.

```mbt check
///|
test {
  let record : Map[String, Array[String]] = {
    "name": ["John", "Mike"],
    "age": ["15", "18"],
    "id": ["11109121", "2000012312"],
  }
  inspect(
    record |> @prettyprinter.render(),
    content=(
      #|{
      #|  "name": ["John", "Mike"],
      #|  "age": ["15", "18"],
      #|  "id": ["11109121", "2000012312"]
      #|}
    ),
  )
}
```

## Implement Pretty Trait

Write declarative code to implement a printer for your type. 

```mbt check
///|
enum Tree[A] {
  Leaf(A)
  Node(Array[Tree[A]])
}

///|
impl[A : @prettyprinter.Pretty] @prettyprinter.Pretty for Tree[A] with pretty(
  tree : Tree[A],
) {
  match tree {
    Leaf(x) => x.pretty()
    Node(xs) =>
      @prettyprinter.group(
        @prettyprinter.text("Node(") +
        @prettyprinter.nest(
          @prettyprinter.line +
          @prettyprinter.separate(
            @prettyprinter.char(',') + @prettyprinter.line,
            xs.map(@prettyprinter.Pretty::pretty),
          ),
        ) +
        @prettyprinter.line +
        @prettyprinter.char(')'),
      )
  }
}

///|
test {
  let tree = Node([
    Leaf(100),
    Leaf(200),
    Leaf(300000000),
    Node([
      Leaf(400),
      Leaf(500),
      Node([Leaf(6000000), Leaf(7000000), Leaf(80000000), Leaf(80000001)]),
      Leaf(900),
    ]),
    Leaf(1000),
  ])
  inspect(
    @prettyprinter.render(tree, width=50),
    content=(
      #|Node(
      #|  100,
      #|  200,
      #|  300000000,
      #|  Node(
      #|    400,
      #|    500,
      #|    Node( 6000000, 7000000, 80000000, 80000001 ),
      #|    900
      #|  ),
      #|  1000
      #|)
    ),
  )
}
```

