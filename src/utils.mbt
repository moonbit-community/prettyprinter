///| This function takes a separator document, an array of values, and a mapping function, and returns a document
/// where each value in the array is mapped to a document using the mapping function, and then separated by the separator document.
///
/// # Arguments
///
/// * `sep` - The separator document to be used between each mapped value.
/// * `xs` - The array of values to be mapped and separated.
/// * `f` - The mapping function that takes a value from the array and returns a document.
///
/// # Returns
///
/// The resulting document where each value is mapped and separated by the separator document.
///
/// # Example
///
/// ```
/// let doc = separate_map(text(","), [1,2,3], pretty)
/// inspect(doc, content="1,2,3") 
/// ```
pub fn[A] separate_map(
  sep : Document,
  elems : Array[A],
  f : (A) -> Document
) -> Document {
  separate(sep, elems.map(f))
}

///| This function takes a separator document `sep` and an array of documents `docs` and returns a document
/// where each document in the array is separated by the separator document.
///
/// # Example
///
/// ```
/// let sep = text("-")
/// let docs = [text("Hello"), text("World"), text("!")]
/// separate(sep, docs).pretty() |> inspect(content="Hello-World-!")
/// ```
pub fn separate(sep : Document, docs : Array[Document]) -> Document {
  let cat_by_sep = fn(l, r) { concat(l, concat(sep, r)) }
  match docs {
    [] => empty
    [x, .. xs] => xs.iter().fold(init=x, cat_by_sep)
  }
}

///| Surrounds the given document with the left and right documents.
/// 
/// `surround(l, r, doc)` is equivalent to `l + doc + r`
/// 
/// # Example
/// 
/// ```
/// inspect(surround(char('['), char(']'), text("doc")), content="[doc]")
/// ``` 
pub fn surround(left : Document, right : Document, doc : Document) -> Document {
  left + doc + right
}

///| wraps the given document in parentheses.  
/// 
/// ```
/// inspect(parens(text("doc")), content="(doc)")
/// ```
pub fn parens(doc : Document) -> Document {
  surround(char('('), char(')'), doc)
}

///| wraps the given document in brackets.  
/// 
/// ```
/// inspect(brackets(text("doc")), content="[doc]")
/// ```
pub fn brackets(doc : Document) -> Document {
  surround(char('['), char(']'), doc)
}

///| wraps the given document in braces.
/// 
/// ```
/// inspect(braces(text("doc")), content="{doc}")
/// ```
pub fn braces(doc : Document) -> Document {
  surround(char('{'), char('}'), doc)
}

///| print the string with double quotes.
/// 
/// ```
/// inspect(string("Hello, World!"), content="\"Hello, World!\"")
/// ```
pub fn string(str : String) -> Document {
  surround(char('"'), char('"'), text(str))
}

///| print each documents in the same line if it fits, insert a line break otherwise.
/// 
/// ```
/// let words = [
///   "The", "quick", "brown", "fox", "jumps", "over", "the", "lazy", "dog",
/// ]
/// let doc = words.map(fn(x){text(x) + space}) |> flow()
/// inspect(doc, content="The quick brown fox jumps over the lazy dog ")
/// inspect(
///   render(doc, width=10),
///   content=
///     #|The quick brown 
///     #|fox jumps over 
///     #|the lazy dog 
///   ,
/// )
/// ```
pub fn flow(doc : Array[Document]) -> Document {
  let sep = group(softline)
  doc.iter().map(pretty).intersperse(sep).fold(init=empty, concat)
}
