///|
let tuple_sep : Document = text(",") + line

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
