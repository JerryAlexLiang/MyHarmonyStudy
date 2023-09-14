@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Normal)
          .fontColor(Color.Red)

        Divider().height(30)

        Text("HarmonyOS")
          .fontSize(30)
          .fontWeight(FontWeight.Normal)
          .fontColor(Color.Pink)
      }
      .width('100%')
    }
    .height('100%')
  }
}