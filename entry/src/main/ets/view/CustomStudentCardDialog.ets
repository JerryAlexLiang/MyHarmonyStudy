import CommonConstants from '../common/constants/CommonConstants';
import { DataItemBean } from '../viewmodel/DataItemBean';

@Component
export struct CustomStudentCardDialog {
  private studentData: DataItemBean;
  onDialogClick: () => void

  build() {
    // dialog默认的borderRadius为24vp，如果需要使用border属性，请和borderRadius属性一起使用。
    Row() {
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
            // 组内转场动画
          .transition({ // 设置Image转场动画
            type: TransitionType.Insert, // 设置Image的入场动画
            scale: CommonConstants.COMPONENT_TRANSITION_SCALE_OPEN,
            rotate: CommonConstants.COMPONENT_TRANSITION_ROTATE,
            opacity: CommonConstants.COMPONENT_TRANSITION_OPACITY
          })
          .transition({ // 设置Image转场动画
            type: TransitionType.Delete, // 设置Image的退场动画
            scale: CommonConstants.COMPONENT_TRANSITION_SCALE_CLOSE,
            rotate: CommonConstants.COMPONENT_TRANSITION_ROTATE,
            opacity: CommonConstants.COMPONENT_TRANSITION_OPACITY
          })

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
            // 组内转场动画
          .transition({ // 设置Image转场动画
            type: TransitionType.Insert, // 设置Image的入场动画
            scale: CommonConstants.COMPONENT_TRANSITION_SCALE_OPEN,
            rotate: CommonConstants.COMPONENT_TRANSITION_ROTATE,
            opacity: CommonConstants.COMPONENT_TRANSITION_OPACITY
          })
          .transition({ // 设置Image转场动画
            type: TransitionType.Delete, // 设置Image的退场动画
            scale: CommonConstants.COMPONENT_TRANSITION_SCALE_CLOSE,
            rotate: CommonConstants.COMPONENT_TRANSITION_ROTATE,
            opacity: CommonConstants.COMPONENT_TRANSITION_OPACITY
          })
      }
      .width('300vp')
      .height('450vp')
      // 组内转场动画
      .transition({ // 设置Image转场动画
        type: TransitionType.Insert, // 设置Image的入场动画
        scale: CommonConstants.COMPONENT_TRANSITION_SCALE_OPEN,
        rotate: CommonConstants.COMPONENT_TRANSITION_ROTATE,
        opacity: CommonConstants.COMPONENT_TRANSITION_OPACITY
      })
      .transition({ // 设置Image转场动画
        type: TransitionType.Delete, // 设置Image的退场动画
        scale: CommonConstants.COMPONENT_TRANSITION_SCALE_CLOSE,
        rotate: CommonConstants.COMPONENT_TRANSITION_ROTATE,
        opacity: CommonConstants.COMPONENT_TRANSITION_OPACITY
      })
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .height('100%')
    // 组内转场动画
    .transition({ // 设置Image转场动画
      type: TransitionType.Insert, // 设置Image的入场动画
      scale: CommonConstants.COMPONENT_TRANSITION_SCALE_OPEN,
      rotate: CommonConstants.COMPONENT_TRANSITION_ROTATE,
      opacity: CommonConstants.COMPONENT_TRANSITION_OPACITY
    })
    .transition({ // 设置Image转场动画
      type: TransitionType.Delete, // 设置Image的退场动画
      scale: CommonConstants.COMPONENT_TRANSITION_SCALE_CLOSE,
      rotate: CommonConstants.COMPONENT_TRANSITION_ROTATE,
      opacity: CommonConstants.COMPONENT_TRANSITION_OPACITY
    })
    .onClick(this.onDialogClick)
  }
}
