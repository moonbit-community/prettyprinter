///|
enum Document {
  Empty
  Line
  Text(String)
  Concat(Requirement, Document, Document)
  Group(Requirement, Document)
  Switch(Requirement, Document, Document)
  Nest(Requirement, Int, Document)
} ///|

///|
fn render_document(width : Int, doc : Document) -> String {
  let buf = StringBuilder::new()
  let stack = [(0, false, doc)]
  let mut column = 0
  while stack.pop() is Some((indent, fit, doc)) {
    match doc {
      Empty => ()
      Line => {
        buf.write_char('\n')
        for _ in 0..<indent {
          buf.write_char(' ')
        }
        column = indent
      }
      Text(s) => {
        buf.write_string(s)
        column += s.length()
      }
      Concat(_, l, r) => stack..push((indent, fit, r))..push((indent, fit, l))
      Nest(_, i, d) => stack..push((indent + i, fit, d))
      Switch(_, a, b) =>
        stack.push(if fit { (indent, fit, a) } else { (indent, fit, b) })
      Group(req, d) => {
        let fit = fit || Space(column) + req <= Space(width)
        stack.push((indent, fit, d))
      }
    }
  }
  buf.to_string()
}

///|
pub impl Show for Document with output(self, buf) {
  buf.write_string(render_document(80, self))
}

///|
pub impl Add for Document with op_add(self, other) {
  concat(self, other)
}
