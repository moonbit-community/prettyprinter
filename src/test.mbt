///|
test "stack-safe test for render" {
  let mut doc = empty
  for i in 0..=3000 {
    doc = doc + text(i.to_string()) + line
  }
  doc.pretty() |> ignore
}
