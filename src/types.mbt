///|
priv enum Requirement {
  Space(Int)
  Infinite
}

///|
enum Document {
  Empty
  Line
  Text(String)
  Concat(Requirement, Document, Document)
  Group(Requirement, Document)
  Switch(Requirement, Document, Document)
  Nest(Requirement, Int, Document)
}

///|
pub(open) trait Pretty {
  pretty(Self) -> Document
}
