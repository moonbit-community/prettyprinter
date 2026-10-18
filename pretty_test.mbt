///|
test {
  let tuple = (1, 'a')
  inspect(@prettyprinter.pretty(tuple), content="(1, a)")
  inspect(
    @prettyprinter.render(tuple, width=3),
    content=(
      #|(
      #|  1,
      #|  a
      #|)
    ),
  )
  let tuple = (1, 'a', false)
  inspect(@prettyprinter.pretty(tuple), content="(1, a, false)")
  inspect(
    @prettyprinter.render(tuple, width=3),
    content=(
      #|(
      #|  1,
      #|  a,
      #|  false
      #|)
    ),
  )
  let tuple = (1, 'a', false, 1.5)
  inspect(@prettyprinter.pretty(tuple), content="(1, a, false, 1.5)")
  inspect(
    @prettyprinter.render(tuple, width=3),
    content=(
      #|(
      #|  1,
      #|  a,
      #|  false,
      #|  1.5
      #|)
    ),
  )
  let tuple = (1, 'a', false, 1.5, Some(1))
  inspect(@prettyprinter.pretty(tuple), content="(1, a, false, 1.5, Some(1))")
  inspect(
    @prettyprinter.render(tuple, width=10),
    content=(
      #|(
      #|  1,
      #|  a,
      #|  false,
      #|  1.5,
      #|  Some(1)
      #|)
    ),
  )
  let tuple = (1, 'a', false, 1.5, Some(1), "hello")
  inspect(
    @prettyprinter.pretty(tuple),
    content=(
      #|(1, a, false, 1.5, Some(1), "hello")
    ),
  )
  inspect(
    @prettyprinter.render(tuple, width=10),
    content=(
      #|(
      #|  1,
      #|  a,
      #|  false,
      #|  1.5,
      #|  Some(1),
      #|  "hello"
      #|)
    ),
  )
  let tuple = (1, 'a', false, 1.5, Some(1), "hello", 5)
  inspect(
    @prettyprinter.pretty(tuple),
    content=(
      #|(1, a, false, 1.5, Some(1), "hello", 5)
    ),
  )
  inspect(
    @prettyprinter.render(tuple, width=10),
    content=(
      #|(
      #|  1,
      #|  a,
      #|  false,
      #|  1.5,
      #|  Some(1),
      #|  "hello",
      #|  5
      #|)
    ),
  )
  let tuple = (1, 'a', false, 1.5, Some(1), "hello", 5, 6)
  inspect(
    @prettyprinter.pretty(tuple),
    content=(
      #|(1, a, false, 1.5, Some(1), "hello", 5, 6)
    ),
  )
  inspect(
    @prettyprinter.render(tuple, width=10),
    content=(
      #|(
      #|  1,
      #|  a,
      #|  false,
      #|  1.5,
      #|  Some(1),
      #|  "hello",
      #|  5,
      #|  6
      #|)
    ),
  )
  let tuple = (1, 'a', false, 1.5, Some(1), "hello", 5, 6, 7)
  inspect(
    @prettyprinter.pretty(tuple),
    content=(
      #|(1, a, false, 1.5, Some(1), "hello", 5, 6, 7)
    ),
  )
  inspect(
    @prettyprinter.render(tuple, width=10),
    content=(
      #|(
      #|  1,
      #|  a,
      #|  false,
      #|  1.5,
      #|  Some(1),
      #|  "hello",
      #|  5,
      #|  6,
      #|  7
      #|)
    ),
  )
}
