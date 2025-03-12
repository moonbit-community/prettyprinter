///|
pub fn pretty[A : Pretty](x : A) -> Document {
  x.pretty()
}

///| Renders a document as a pretty string with a specified width.
///
/// # Arguments
///
/// * `x` - The document to render.
/// * `width` - The maximum width of the rendered string. Defaults to 80.
///
/// # Returns
///
/// The rendered string.
pub fn render[A : Pretty](document : A, width~ : Int = 80) -> String {
  render_document(width, document.pretty())
}

///| Pretty print a string.
/// 
/// ```
/// pretty("Hello, World!") |> inspect!(content="\"Hello, World!\"")
/// ```
pub impl Pretty for String with pretty(str) {
  string(str)
}

///| Pretty print a Bool.
pub impl Pretty for Bool with pretty(b) {
  text(b.to_string())
}

///| Pretty print an Int.
pub impl Pretty for Int with pretty(i) {
  text(i.to_string())
}

///| Pretty print an Int64.
pub impl Pretty for Int64 with pretty(i) {
  text(i.to_string())
}

///| Pretty print a UInt.
pub impl Pretty for UInt with pretty(i) {
  text(i.to_string())
}

///| Pretty print a UInt64.
pub impl Pretty for UInt64 with pretty(i) {
  text(i.to_string())
}

///| Pretty print a character.
pub impl Pretty for Char with pretty(c) {
  char(c)
}

///| Pretty print a double.
pub impl Pretty for Double with pretty(d) {
  text(d.to_string())
}

///| Pretty print a float.
pub impl Pretty for Float with pretty(f) {
  text(f.to_string())
}

///| Pretty print a document.
pub impl Pretty for Document with pretty(doc) {
  doc
}

///| Pretty print a unit value.
pub impl Pretty for Unit with pretty(_unit) {
  text("()")
}

///| Pretty print an array.
/// 
/// ```
/// let arr = [1, 2, 3, 4]
/// inspect!(pretty(arr), content="[1, 2, 3, 4]")
/// ```
pub impl[A : Pretty] Pretty for Array[A] with pretty(xs) {
  group(
    char('[') +
    nest(softline + separate(char(',') + line, xs.map(A::pretty))) +
    softline +
    char(']'),
  )
}

///| Pretty print an option value.
/// 
/// ```
/// let opt = Some(5)
/// inspect!(pretty(opt), content="Some(5)")
/// ``` 
pub impl[A : Pretty] Pretty for A? with pretty(opt) {
  match opt {
    None => text("None")
    Some(x) => group(text("Some(") + x.pretty() + char(')'))
  }
}

///| Pretty print a result value.
/// 
/// ```
/// let ok : Result[Int, String] = Ok(100)
/// let err : Result[Int, String] = Err("error")
/// inspect!(pretty(ok), content="Ok(100)")
/// inspect!(pretty(err), content=
///   #|Err("error")
/// )
/// ```
pub impl[A : Pretty, B : Pretty] Pretty for Result[A, B] with pretty(res) {
  match res {
    Ok(x) => group(text("Ok(") + x.pretty() + char(')'))
    Err(e) => group(text("Err(") + e.pretty() + char(')'))
  }
}

///| Pretty print a map.
/// 
/// ```
/// let score : Map[String, Int] = {
///   "player1": 1009,
///   "player2": 200,
///   "player3": 30,
///   "player4": 999999999,
///   "player5": 999999999,
/// }
/// inspect!(
///   pretty(score),
///   content=
///     #|{
///     #|  "player1": 1009,
///     #|  "player2": 200,
///     #|  "player3": 30,
///     #|  "player4": 999999999,
///     #|  "player5": 999999999
///     #|}
///   ,
/// )
/// ```
/// 
pub impl[A : Pretty, B : Pretty] Pretty for Map[A, B] with pretty(m) {
  let entries = m
    .iter()
    .map(fn { (k, v) => group(k.pretty() + char(':') + space + v.pretty()) })
    .to_array()
  group(
    char('{') +
    nest(softline + separate(concat(char(','), line), entries)) +
    softline +
    char('}'),
  )
}

///| Pretty print a JSON value.
/// 
/// ```
/// let user : Json = {
///   "name": "John Doe",
///   "age": 30,
///   "is_student": false,
///   "grades": [100, 90, 80],
///   "address": { "street": "123 Main St", "city": "Springfield", "state": "IL" },
/// }
/// inspect!(
///   pretty(user),
///   content=
///     #|{
///     #|  "name": John Doe,
///     #|  "age": 30,
///     #|  "is_student": false,
///     #|  "grades": [100, 90, 80],
///     #|  "address": {"street": 123 Main St, "city": Springfield, "state": IL}
///     #|}
///   ,
/// )
/// ``` 
pub impl Pretty for Json with pretty(json : Json) -> Document {
  fn pair(pair : (String, @json.JsonValue)) -> Document {
    string(pair.0) + text(":") + space + Pretty::pretty(pair.1)
  }

  match json {
    True => text("true")
    False => text("false")
    Null => text("null")
    Number(n) => Pretty::pretty(n)
    String(s) => text(s)
    Array(xs) =>
      group(
        brackets(
          nest(
            softline +
            separate(char(',') + line, xs.map(Pretty::pretty)) +
            softline,
          ),
        ),
      )
    Object(map) =>
      group(
        braces(
          nest(softline + separate_map(text(",") + line, map.to_array(), pair)) +
          softline,
        ),
      )
  }
}

///| Pretty print a `@immut/list.T`
/// 
/// ```
/// let list = @immut/list.of([(1,'a'), (2,'b'), (3,'c')])
/// inspect!(pretty(list), content="[(1, a), (2, b), (3, c)]")
/// inspect!(render(list,width=10), content=
///   #|[
///   #|  (1, a),
///   #|  (2, b),
///   #|  (3, c)
///   #|]
/// )
/// ```
pub impl[A : Pretty] Pretty for @immut/list.T[A] with pretty(list) {
  let elems = list
    .map(pretty)
    .intersperse(text(",") + line)
    .fold(init=empty, concat)
  group(brackets(nest(softline + elems) + softline))
}

///| Pretty print a Set
/// 
/// ``` 
/// let set = Set::of([1,2,3])
/// inspect!(pretty(set), content="{1, 2, 3}")
/// inspect!(
///   render(set, width=5),
///   content=
///     #|{
///     #|  1,
///     #|  2,
///     #|  3
///     #|}
///   ,
/// )
/// ```
pub impl[A : Pretty] Pretty for Set[A] with pretty(set) {
  let elems = set
    .iter()
    .map(pretty)
    .intersperse(text(",") + line)
    .fold(init=empty, concat)
  group(braces(nest(softline + elems) + softline))
}

///|
pub impl Pretty for Byte with pretty(byte) {
  text(byte.to_string())
}

///| Pretty print a Bytes
/// 
/// ```
/// let x = Bytes::of([1,2,3,4,5])
/// inspect!(pretty(x), content="[b'\\x01', b'\\x02', b'\\x03', b'\\x04', b'\\x05']")
/// inspect!(
///   render(x, width=15),
///   content=
///     #|[
///     #|  b'\x01', b'\x02',
///     #|  b'\x03', b'\x04',
///     #|  b'\x05'
///     #|]
///   ,
/// )
/// ```
pub impl Pretty for Bytes with pretty(bytes) {
  let elems = bytes
    .iter()
    .map(pretty)
    .intersperse(text(",") + group(line))
    .fold(init=empty, concat)
  group(brackets(nest(softline + elems) + softline))
}

///| Pretty print a FixedArray
/// 
/// ```
/// let x  : FixedArray[_] = [1, 2, 3]
/// inspect!(
///   pretty(x),
///   content="[1, 2, 3]",
/// )
/// inspect!(
///   render(x, width=5),
///   content=
///     #|[
///     #|  1,
///     #|  2,
///     #|  3
///     #|]
///   ,
/// )
/// ```
pub impl[A : Pretty] Pretty for FixedArray[A] with pretty(array) {
  let elems = array
    .iter()
    .map(pretty)
    .intersperse(text(",") + line)
    .fold(init=empty, concat)
  group(brackets(nest(softline + elems) + softline))
}

///| Pretty print a `@hashmap.T`
/// 
/// ```
/// let x = @hashmap.of([("key1",1),("key2",2000)])
/// inspect!(pretty(x), content=
///   #|{"key2": 2000, "key1": 1}
/// )
/// inspect!(
///   render(x, width=5),
///   content=
///     #|{
///     #|  "key2": 2000,
///     #|  "key1": 1
///     #|}
///   ,
/// )
/// ```
pub impl[A : Pretty, B : Pretty] Pretty for @hashmap.T[A, B] with pretty(map) {
  let entries = map
    .iter()
    .map(fn { (k, v) => group(k.pretty() + char(':') + space + v.pretty()) })
    .to_array()
  group(
    braces(
      nest(softline + separate(concat(char(','), line), entries)) + softline,
    ),
  )
}

///|
/// ```
/// let x = @hashset.of(["key1","key2"])
/// inspect!(pretty(x), content=
///   #|{"key1", "key2"}
/// )
/// inspect!(
///   render(x, width=5),
///   content=
///     #|{
///     #|  "key1",
///     #|  "key2"
///     #|}
///   ,
/// )
/// ```
/// 
pub impl[A : Pretty] Pretty for @hashset.T[A] with pretty(set) {
  let elems = set
    .iter()
    .map(pretty)
    .intersperse(text(",") + line)
    .fold(init=empty, concat)
  group(braces(nest(softline + elems) + softline))
}

///|
pub impl[A : Pretty, B : Pretty] Pretty for @sorted_map.T[A, B] with pretty(map) {
  let entries = map
    .iter()
    .map(fn { (k, v) => group(k.pretty() + char(':') + space + v.pretty()) })
    .to_array()
  group(
    braces(
      nest(softline + separate(concat(char(','), line), entries)) + softline,
    ),
  )
}

///|
pub impl[A : Pretty] Pretty for @sorted_set.T[A] with pretty(set) {
  let elems = set
    .iter()
    .map(pretty)
    .intersperse(text(",") + line)
    .fold(init=empty, concat)
  group(braces(nest(softline + elems) + softline))
}

///|
pub impl[A : Pretty] Pretty for @queue.T[A] with pretty(queue) {
  let elems = queue
    .iter()
    .map(pretty)
    .intersperse(text(",") + line)
    .fold(init=empty, concat)
  group(brackets(nest(softline + elems) + softline))
}

///|
pub impl[A : Pretty + Eq + Compare] Pretty for @priority_queue.T[A] with pretty(
  queue
) {
  pretty(queue.to_array())
}

///|
pub impl Pretty for @buffer.T with pretty(buffer) {
  buffer.to_bytes().pretty()
}

///|
pub impl[A : Pretty] Pretty for @deque.T[A] with pretty(deque) {
  deque.iter().to_array().pretty()
}

///|
pub impl[A : Pretty] Pretty for @immut/array.T[A] with pretty(array) {
  array.to_array().pretty()
}

///|
pub impl[A : Pretty, B : Pretty] Pretty for @immut/hashmap.T[A, B] with pretty(
  map
) {
  let entries = map
    .iter()
    .map(fn { (k, v) => group(k.pretty() + char(':') + space + v.pretty()) })
    .to_array()
  group(
    braces(
      nest(softline + separate(concat(char(','), line), entries)) + softline,
    ),
  )
}

///|
pub impl[A : Pretty] Pretty for @immut/hashset.T[A] with pretty(set) {
  let elems = set
    .iter()
    .map(pretty)
    .intersperse(text(",") + line)
    .fold(init=empty, concat)
  group(braces(nest(softline + elems) + softline))
}

///|
pub impl[A : Pretty, B : Pretty] Pretty for @immut/sorted_map.T[A, B] with pretty(
  map
) {
  let entries = map
    .iter()
    .map(fn { (k, v) => group(k.pretty() + char(':') + space + v.pretty()) })
    .to_array()
  group(
    braces(
      nest(softline + separate(concat(char(','), line), entries)) + softline,
    ),
  )
}

///|
pub impl[A : Pretty] Pretty for @immut/sorted_set.T[A] with pretty(set) {
  let elems = set
    .iter()
    .map(pretty)
    .intersperse(text(",") + line)
    .fold(init=empty, concat)
  group(braces(nest(softline + elems) + softline))
}
