//
import { DataItemBean } from '../viewmodel/DataItemBean';

@CustomDialog
export struct StudentDetailDialog {
  private studentData: DataItemBean;
  controller: CustomDialogController
  // 若尝试在CustomDialog中传入多个其他的Controller，以实现在CustomDialog中打开另一个或另一些CustomDialog，那么此处需要将指向自己的controller放在最后
  // cancel: () => void
  // confirm: () => void

  build() {
    // dialog默认的borderRadius为24vp，如果需要使用border属性，请和borderRadius属性一起使用。
    RelativeContainer() {
      Image(this.studentData.image)
        // Image('https://c-ssl.duitang.com/uploads/item/201805/06/20180506084619_2svWA.jpeg')
        // ImageFit包含以下几种类型：
        // Contain：保持宽高比进行缩小或者放大，使得图片完全显示在显示边界内
        // Cover（默认值）：保持宽高比进行缩小或者放大，使得图片两边都大于或等于显示边界。
        // Auto：自适应显示。
        // Fill：不保持宽高比进行放大缩小，使得图片充满显示边界。
        // ScaleDown：保持宽高比显示，图片缩小或者保持不变。
        // None：保持原有尺寸显示。
        .objectFit(ImageFit.Cover)
          // .backgroundColor(Color.Pink)
        .width('300vp')
        .height('450vp')
          // .border({ width: 2 })
          // .borderColor(Color.Blue)
        .borderRadius(24)
          // .borderStyle(BorderStyle.Dotted)
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          left: { anchor: "__container__", align: HorizontalAlign.Start }
        })
        .id("image")

      Text(this.studentData.title)
        .fontSize('18fp')
        .fontColor(Color.White)
        .backgroundColor($r('app.color.transparent_backgroundColor'))
          // .height('16vp')
        .borderRadius({ topLeft: 24, bottomRight: 24 })
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .alignRules({
          bottom: { anchor: "image", align: VerticalAlign.Bottom },
          right: { anchor: "image", align: HorizontalAlign.End }
        })
        .id("text")

      // Row()
      //   .width(100)
      //   .height(100)
      //   .backgroundColor(Color.Red)
      //   .alignRules({
      //     top: {anchor: "__container__", align: VerticalAlign.Top},
      //     left: {anchor: "__container__", align: HorizontalAlign.Start}
      //   })
      //   .id("row1")
      //
      // Row()
      //   .width(100)
      //   .height(100)
      //   .backgroundColor(Color.Blue)
      //   .alignRules({
      //     top: {anchor: "__container__", align: VerticalAlign.Top},
      //     right: {anchor: "__container__", align: HorizontalAlign.End}
      //   })
      //   .id("row2")
      //
      // Row()
      //   .height(100)
      //   .backgroundColor(Color.Green)
      //   .alignRules({
      //     top: {anchor: "row1", align: VerticalAlign.Bottom},
      //     left: {anchor: "row1", align: HorizontalAlign.End},
      //     right: {anchor: "row2", align: HorizontalAlign.Start}
      //   })
      //   .id("row3")
      //
      // Row()
      //   .backgroundColor(Color.Yellow)
      //   .alignRules({
      //     top: {anchor: "row3", align: VerticalAlign.Bottom},
      //     bottom: {anchor: "__container__", align: VerticalAlign.Bottom},
      //     left: {anchor: "__container__", align: HorizontalAlign.Start},
      //     right: {anchor: "row1", align: HorizontalAlign.End}
      //   })
      //   .id("row4")
      //
      // Row()
      //   .backgroundColor(Color.Gray)
      //   .alignRules({
      //     top: {anchor: "row3", align: VerticalAlign.Bottom},
      //     bottom: {anchor: "__container__", align: VerticalAlign.Bottom},
      //     left: {anchor: "row2", align: HorizontalAlign.Start},
      //     right: {anchor: "__container__", align: HorizontalAlign.End}
      //   })
      //   .id("row5")
    }
    .width('300vp')
    .height('450vp')
    .onClick(() => {
      this.controller.close()
    })
  }
}
