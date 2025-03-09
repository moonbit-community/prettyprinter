///|
let tuple_sep : Document = text(",") + line

test {
  let tuple = (1, 'a')
  inspect!(pretty(tuple), content="(1, a)")
  inspect!(
    render(tuple, width=3),
    content=
      #|(
      #|  1,
      #|  a
      #|)
    ,
  )
  let tuple = (1, 'a', false)
  inspect!(pretty(tuple), content="(1, a, false)")
  inspect!(
    render(tuple, width=3),
    content=
      #|(
      #|  1,
      #|  a,
      #|  false
      #|)
    ,
  )
  let tuple = (1, 'a', false, 1.5)
  inspect!(pretty(tuple), content="(1, a, false, 1.5)")
  inspect!(
    render(tuple, width=3),
    content=
      #|(
      #|  1,
      #|  a,
      #|  false,
      #|  1.5
      #|)
    ,
  )
  let tuple = (1, 'a', false, 1.5, Some(1))
  inspect!(pretty(tuple), content="(1, a, false, 1.5, Some(1))")
  inspect!(
    render(tuple, width=10),
    content=
      #|(
      #|  1,
      #|  a,
      #|  false,
      #|  1.5,
      #|  Some(1)
      #|)
    ,
  )
  let tuple = (1, 'a', false, 1.5, Some(1), "hello")
  inspect!(
    pretty(tuple),
    content=
      #|(1, a, false, 1.5, Some(1), "hello")
    ,
  )
  inspect!(
    render(tuple, width=10),
    content=
      #|(
      #|  1,
      #|  a,
      #|  false,
      #|  1.5,
      #|  Some(1),
      #|  "hello"
      #|)
    ,
  )
  let tuple = (1, 'a', false, 1.5, Some(1), "hello", 5)
  inspect!(
    pretty(tuple),
    content=
      #|(1, a, false, 1.5, Some(1), "hello", 5)
    ,
  )
  inspect!(
    render(tuple, width=10),
    content=
      #|(
      #|  1,
      #|  a,
      #|  false,
      #|  1.5,
      #|  Some(1),
      #|  "hello",
      #|  5
      #|)
    ,
  )
  let tuple = (1, 'a', false, 1.5, Some(1), "hello", 5, 6)
  inspect!(
    pretty(tuple),
    content=
      #|(1, a, false, 1.5, Some(1), "hello", 5, 6)
    ,
  )
  inspect!(
    render(tuple, width=10),
    content=
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
    ,
  )
  let tuple = (1, 'a', false, 1.5, Some(1), "hello", 5, 6, 7)
  inspect!(
    pretty(tuple),
    content=
      #|(1, a, false, 1.5, Some(1), "hello", 5, 6, 7)
    ,
  )
  inspect!(
    render(tuple, width=10),
    content=
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
    ,
  )
}

///|
pub impl[A : Pretty, B : Pretty] Pretty for (A, B) with pretty(pair) {
  parens(
    group(
      nest(softline + pretty(pair.0) + tuple_sep + pretty(pair.1)) + softline,
    ),
  )
}

///|
pub impl[A : Pretty, B : Pretty, C : Pretty] Pretty for (A, B, C) with pretty(
  tuple
) {
  parens(
    group(
      nest(
        softline +
        pretty(tuple.0) +
        tuple_sep +
        pretty(tuple.1) +
        tuple_sep +
        pretty(tuple.2),
      ) +
      softline,
    ),
  )
}

///|
pub impl[A : Pretty, B : Pretty, C : Pretty, D : Pretty] Pretty for (A, B, C, D) with pretty(
  tuple
) {
  parens(
    group(
      nest(
        softline +
        pretty(tuple.0) +
        tuple_sep +
        pretty(tuple.1) +
        tuple_sep +
        pretty(tuple.2) +
        tuple_sep +
        pretty(tuple.3),
      ) +
      softline,
    ),
  )
}

///|
pub impl[A : Pretty, B : Pretty, C : Pretty, D : Pretty, E : Pretty] Pretty for (
  A,
  B,
  C,
  D,
  E,
) with pretty(tuple) {
  parens(
    group(
      nest(
        softline +
        pretty(tuple.0) +
        tuple_sep +
        pretty(tuple.1) +
        tuple_sep +
        pretty(tuple.2) +
        tuple_sep +
        pretty(tuple.3) +
        tuple_sep +
        pretty(tuple.4),
      ) +
      softline,
    ),
  )
}

///|
pub impl[A : Pretty, B : Pretty, C : Pretty, D : Pretty, E : Pretty, F : Pretty] Pretty for (
  A,
  B,
  C,
  D,
  E,
  F,
) with pretty(tuple) {
  parens(
    group(
      nest(
        softline +
        pretty(tuple.0) +
        tuple_sep +
        pretty(tuple.1) +
        tuple_sep +
        pretty(tuple.2) +
        tuple_sep +
        pretty(tuple.3) +
        tuple_sep +
        pretty(tuple.4) +
        tuple_sep +
        pretty(tuple.5),
      ) +
      softline,
    ),
  )
}

///|
pub impl[A : Pretty, B : Pretty, C : Pretty, D : Pretty, E : Pretty, F : Pretty, G : Pretty] Pretty for (
  A,
  B,
  C,
  D,
  E,
  F,
  G,
) with pretty(tuple) {
  parens(
    group(
      nest(
        softline +
        pretty(tuple.0) +
        tuple_sep +
        pretty(tuple.1) +
        tuple_sep +
        pretty(tuple.2) +
        tuple_sep +
        pretty(tuple.3) +
        tuple_sep +
        pretty(tuple.4) +
        tuple_sep +
        pretty(tuple.5) +
        tuple_sep +
        pretty(tuple.6),
      ) +
      softline,
    ),
  )
}

///|
pub impl[A : Pretty, B : Pretty, C : Pretty, D : Pretty, E : Pretty, F : Pretty, G : Pretty, H : Pretty] Pretty for (
  A,
  B,
  C,
  D,
  E,
  F,
  G,
  H,
) with pretty(tuple) {
  parens(
    group(
      nest(
        softline +
        pretty(tuple.0) +
        tuple_sep +
        pretty(tuple.1) +
        tuple_sep +
        pretty(tuple.2) +
        tuple_sep +
        pretty(tuple.3) +
        tuple_sep +
        pretty(tuple.4) +
        tuple_sep +
        pretty(tuple.5) +
        tuple_sep +
        pretty(tuple.6) +
        tuple_sep +
        pretty(tuple.7),
      ) +
      softline,
    ),
  )
}

///|
pub impl[A : Pretty, B : Pretty, C : Pretty, D : Pretty, E : Pretty, F : Pretty, G : Pretty, H : Pretty, I : Pretty] Pretty for (
  A,
  B,
  C,
  D,
  E,
  F,
  G,
  H,
  I,
) with pretty(tuple) {
  parens(
    group(
      nest(
        softline +
        pretty(tuple.0) +
        tuple_sep +
        pretty(tuple.1) +
        tuple_sep +
        pretty(tuple.2) +
        tuple_sep +
        pretty(tuple.3) +
        tuple_sep +
        pretty(tuple.4) +
        tuple_sep +
        pretty(tuple.5) +
        tuple_sep +
        pretty(tuple.6) +
        tuple_sep +
        pretty(tuple.7) +
        tuple_sep +
        pretty(tuple.8),
      ) +
      softline,
    ),
  )
}
