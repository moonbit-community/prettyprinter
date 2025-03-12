///|
fn Requirement::op_add(x : Requirement, y : Requirement) -> Requirement {
  match (x, y) {
    (Space(a), Space(b)) => Space(a + b)
    _ => Infinite
  }
}

///|
impl Compare for Requirement with compare(self, other) {
  match (self, other) {
    (Space(a), Space(b)) => a - b
    (Infinite, _) => 1
    (_, Infinite) => -1
  }
}

///|
impl Eq for Requirement with op_equal(self, other) {
  match (self, other) {
    (Space(a), Space(b)) => a == b
    (Infinite, Infinite) => true
    _ => false
  }
}

///|
fn requirement(doc : Document) -> Requirement {
  match doc {
    Empty => Space(0)
    Line => Infinite
    Text(s) => Space(s.length())
    Concat(req, _, _) => req
    Switch(req, _, _) => req
    Nest(req, _, _) => req
    Group(req, _) => req
  }
}
