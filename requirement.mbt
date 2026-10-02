///|
pub(all) enum Requirement {
  Space(Int)
  Infinite
}

///|
pub impl Show for Requirement with fn output(self, buf) {
  match self {
    Space(n) => {
      buf.write_string("Space(")
      buf.write_string(n.to_string())
      buf.write_string(")")
    }
    Infinite => buf.write_string("Infinite")
  }
}

///|
pub impl Add for Requirement with fn add(self, other) {
  match (self, other) {
    (Space(a), Space(b)) => Space(a + b)
    _ => Infinite
  }
}

///|
pub impl Compare for Requirement with fn compare(self, other) {
  match (self, other) {
    (Space(a), Space(b)) => a - b
    (Infinite, _) => 1
    (_, Infinite) => -1
  }
}

///|
pub impl Eq for Requirement with fn equal(self, other) {
  match (self, other) {
    (Space(a), Space(b)) => a == b
    (Infinite, Infinite) => true
    _ => false
  }
}

///|
pub fn Document::requirement(doc : Self) -> Requirement {
  match doc {
    Empty => Space(0)
    MandatoryLine | Line => Infinite
    MandatorySpace | Space => Space(1)
    Text(s) => Space(s.length())
    Concat(req, _, _)
    | Switch(req, _, _)
    | Nest(req, _, _)
    | Group(req, _)
    | Dynamic(req, _) => req
  }
}

///|
/// Keep the trait methods callable as regular methods
/// (implicit impl-to-method promotion is deprecated).
pub extend Requirement with Show::{to_string, output}

///|
pub extend Requirement with Add::{add}

///|
pub extend Requirement with Compare::{op_lt, op_le, op_ge, compare, op_gt}

///|
pub extend Requirement with Eq::{not_equal, equal}
