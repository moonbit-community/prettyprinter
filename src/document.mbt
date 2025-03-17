///| Empty document.
/// `render(empty) == ""`
pub let empty : Document = Empty

///| Force line break with current indentation.
/// This document will always doesn't fit in the current line.
/// 
/// # Example
/// 
/// ```
/// render(text("hello") + nest(hardline + text("world")))
/// |> inspect!(
///   content=
///     #|hello
///     #|  world
///   ,
/// )
/// ```
/// 
pub let hardline : Document = Line

///| Space character.
/// `render(space) == " "`
pub let space : Document = char(' ')

///| Represents a line break if the line is too long, or nothing if it fits.
pub let softline : Document = switch(empty, line)

///| Represents a line break if the line is too long, or a space if it fits.
pub let line : Document = switch(space, hardline)

///|
pub fn text(s : String) -> Document {
  Text(s)
}

///|
pub fn char(c : Char) -> Document {
  Text(c.to_string())
}

///| Concatenate documents.
pub fn list(ls : Array[Document]) -> Document {
  fn aux {
    ([] : ArrayView[_]) => Empty
    [x, y] => concat(x, y)
    [x, .. xs] => concat(x, aux(xs))
  }

  aux(ls[:])
}

///| `group(doc)` tries to render the `doc` on a single line, 
/// but if the `doc` doesn't fit, or contains a `hardline`, all the `switch` 
/// inside the `doc` will be rendered with the right document.
pub fn group(doc : Document) -> Document {
  Group(requirement(doc), doc)
}

///| Switch between two documents based on the available space.
/// The left document represents the flatten mode, and the right one the pretty mode.
/// If the left document fits, it will be rendered, otherwise the right one.
pub fn switch(l : Document, r : Document) -> Document {
  Switch(requirement(l), l, r)
}

///| Nest the document by `n` spaces.
/// Any line breaks inside the nested document will be indented by `n` spaces.
pub fn nest(indent~ : Int = 2, doc : Document) -> Document {
  Nest(requirement(doc), indent, doc)
}

///| Concatenate two documents.
/// You can also use the `+` operator.
pub fn concat(l : Document, r : Document) -> Document {
  Concat(requirement(l) + requirement(r), l, r)
}

///|
pub fn op_add(self : Document, other : Document) -> Document {
  concat(self, other)
}

///|
pub fn to_string(self : Document) -> String {
  render_document(80, self)
}

///|
pub impl Show for Document with output(self, buf) {
  buf.write_string(render_document(80, self))
}

///|
fn render_document(width : Int, doc : Document) -> String {
  let buf = StringBuilder::new()
  let queue = [(0, false, doc)]
  let mut column = 0
  while queue.pop() is Some((indent, flat_mode, doc)) {
    match doc {
      Empty => ()
      Text(s) => {
        buf.write_string(s)
        column += s.length()
      }
      Concat(_, l, r) => {
        queue.push((indent, flat_mode, r))
        queue.push((indent, flat_mode, l))
      }
      Switch(_, l, r) =>
        if flat_mode {
          queue.push((indent, flat_mode, l))
        } else {
          queue.push((indent, flat_mode, r))
        }
      Line => {
        buf.write_char('\n')
        for i = 0; i < indent; i = i + 1 {
          buf.write_char(' ')
        }
        column = indent
      }
      Nest(_, i, d) => queue.push((indent + i, flat_mode, d))
      Group(req, d) => {
        let flat_mode = Space(column) + req <= Space(width)
        queue.push((indent, flat_mode, d))
      }
    }
  }
  buf.to_string()
}
