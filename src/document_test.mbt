test "pretty group" {
  let doc = group(
    @prettyprinter.text("hello") +
    @Yoorkin/prettyprinter.nest(
      @prettyprinter.hardline + @prettyprinter.text("world"),
    ),
  )
  inspect!(
    doc.to_string(),
    content=
      #|hello
      #|  world
    ,
  )
}
