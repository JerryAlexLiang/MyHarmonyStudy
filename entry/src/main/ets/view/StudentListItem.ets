import router from '@ohos.router';
import CommonConstants from '../common/constants/CommonConstants';
import { DataItemBean } from '../viewmodel/DataItemBean';
import prompt from '@system.prompt';
// import DataItemBean from '../viewmodel/DataItemBean';

@Component
export default struct StudentListItem {
  // private name?: string;
  // private imageUrl?: string;

  @State studentData?: DataItemBean = undefined;
  private index: number;

  // @State isListModel: boolean = true;
  // 从父组件单向同步状态：@Prop
  @Prop isListModel: boolean;

  // 是否选中当前Item
  @State isChecked: boolean = false;

  // 列表Item子项Image点击事件
  onItemChildImageClick: () => void

  // 1、ArkUI提供了@Link装饰器，用于与父组件双向同步状态。当子组件StudentListItem中的clickIndex用@Link修饰，可与父组件StudentListPage中的clickIndex建立双向同步关系。
  // 2、ArkUI中监听状态变化@Watch的能力。用@Watch修饰的状态，当状态发生变化时，会触发声明时定义的回调。
  // 给StudentListItem的中的clickIndex状态加上@Watch("onClickIndexChanged")。这表示需要监听clickIndex状态的变化。
  @Link @Watch('onClickIndexChanged') clickIndex: number;

  // 当clickIndex状态变化时，将触发onClickIndexChanged回调：如果点击的列表项索引不等于当前列表项索引，则将isExpanded状态置为false，从而收起该目标项。
  onClickIndexChanged() {
    if (this.clickIndex != this.index) {
      this.isChecked = false;
    } else {
      this.isChecked = true;
    }
  }

  aboutToAppear() {
    console.log("DataItemBean", this.studentData.title)
    console.log("DataItemBean", this.studentData.image)
    console.log("isListModel", this.isListModel)
  }

  @Builder checkIcon(icon: Resource, width?: Length, height?: Length) {
    Image(icon)
      .objectFit(ImageFit.Contain)
      .width(width != null ? width : $r('app.float.checkbox_width'))
      .height(height != null ? height : $r('app.float.checkbox_height'))
    // .margin($r('app.float.checkbox_margin'))
  }

  showToast(message: string) {
    prompt.showToast({
      message: message
    })
  }

  build() {
    if (this.isListModel) {
      Column() {
        Row() {
          Row() {
            if (this.isChecked) {
              this.checkIcon($r('app.media.ic_checked'))
            } else {
              this.checkIcon($r('app.media.ic_unchecked'))
            }
          }
          .margin(10)

          // Text(this.name)
          Text(this.studentData.title)
            .fontColor(this.isChecked ? Color.Red : Color.Black)
            .fontSize(this.isChecked ? $r('app.float.item_checked_font_size') : $r('app.float.item_font_size'))
            .fontWeight(this.isChecked ? FontWeight.Bolder : FontWeight.Bold)
            .opacity(this.isChecked ? 0.5 : 1.0)
            .decoration({ type: this.isChecked ? TextDecorationType.Underline : TextDecorationType.None })

          Blank()

          if (this.isChecked) {
            Text("爆")
              .margin({ right: 10 })
              .textAlign(TextAlign.Center)
              .fontWeight(600)
              .fontSize('14fp')
              .backgroundColor(Color.Red)
              .fontColor(Color.White)
              .borderRadius(5)
              .width(22)
              .height(22)
          }

          Image($r('app.media.ic_arrow_next'))
            .width('30vp')
            .height('30vp')
            .margin({ right: '10vp' })
            .onClick(() => {
              // console.log('Next Click' + this.name);
              console.log('Next Click' + this.studentData.title);
              console.log('Next Click' + this.studentData.image);

              router.pushUrl({
                // url: 'pages/StudentDetailPage',
                url: CommonConstants.STUDENT_DETAIL_URL,
                params: {
                  // name: this.name,
                  studentData: this.studentData
                }
              }).catch((error) => {
                console.log('Next Click', 'IndexPage push error' + JSON.stringify(error));
              })
            })
        }
        .width('100%')
        .height($r('app.float.list_item_height'))

        if (this.isChecked) {
          Row() {
            Text(this.studentData.title + " is very handsome!")
              .fontSize('18fp')
              .fontColor(Color.Blue)

            Blank()

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
              .width('50vp')
              .height('50vp')
                // .border({ width: 1 })
                // .borderColor(Color.Yellow)
              .borderRadius(100)
                // .borderStyle(BorderStyle.Solid)
              .onClick(this.onItemChildImageClick)
          }
          .width('100%')
          .padding({ left: 10, right: 10 })
          .justifyContent(FlexAlign.SpaceAround)
          // 组内转场动画
          .transition({ // 设置Image转场动画
            type: TransitionType.Insert, // 设置Image的入场动画
            scale: CommonConstants.COMPONENT_TRANSITION_SCALE_OPEN,
            opacity: CommonConstants.COMPONENT_TRANSITION_OPACITY
          })
          .transition({ // 设置Image转场动画
            type: TransitionType.Delete, // 设置Image的退场动画
            scale: CommonConstants.COMPONENT_TRANSITION_SCALE_CLOSE,
            opacity: CommonConstants.COMPONENT_TRANSITION_OPACITY
          })
        }
      }
      .borderRadius(22)
      .backgroundColor($r('app.color.start_window_background'))
      .width('100%')
      .height(this.isChecked ? $r('app.float.list_item_expand_height') : $r('app.float.list_item_height'))
      // 属性动画
      // animation属性作用域：animation自身也是组件的一个属性，其作用域为animation之前。
      // 即产生属性动画的属性须在animation之前声明，其后声明的将不会产生属性动画
      // 显式动画把要执行动画的属性的修改放在闭包函数中触发动画，而属性动画则无需使用闭包，把animation属性加在要做属性动画的组件的属性后即可
      .animation({ duration: 600 })
      .onClick(() => {
        // this.isChecked = !this.isChecked;

        // 组件内转场动画需要配合 animateTo 才能生效，动效时长、曲线、延时跟随 animateTo 中的配置
        // 📢：组件内的转场动画时长，动画曲线等动画参数以 animationTo 方法设置的为基准
        // 显示动画-添加展开动画
        animateTo({ duration: 1000 }, () => {
          this.isChecked = !this.isChecked;
        })

        // 收起非点击Item
        this.clickIndex = this.index;

      })
    } else {
      Column() {
        Row() {
          Blank()

          Image($r('app.media.ic_arrow_next'))
            .width('15vp')
            .height('15vp')
            .margin(10)
            .onClick(() => {
              // console.log('Next Click' + this.name);
              console.log('Next Click' + this.studentData.title);
              console.log('Next Click' + this.studentData.image);

              router.pushUrl({
                // url: 'pages/StudentDetailPage',
                url: CommonConstants.STUDENT_DETAIL_URL,
                params: {
                  // name: this.name,
                  studentData: this.studentData
                }
              }).catch((error) => {
                console.log('Next Click', 'IndexPage push error' + JSON.stringify(error));
              })
            })
        }
        .width('100%')

        Blank()

        Row() {
          Row() {
            if (this.isChecked) {
              this.checkIcon($r('app.media.ic_checked'), '16vp', '16vp')
            } else {
              this.checkIcon($r('app.media.ic_unchecked'), '16vp', '16vp')
            }
          }
          .onClick(() => {
            this.isChecked = !this.isChecked;
          })
          .margin(5)

          Blank()

          Row() {
            Text(this.studentData.title)
              .fontColor(this.isChecked ? Color.Yellow : Color.White)
              .fontSize('12vp')
              .fontWeight(500)
              .opacity(this.isChecked ? 0.5 : 1.0)
              .decoration({ type: this.isChecked ? TextDecorationType.LineThrough : TextDecorationType.None })
          }
          .backgroundColor($r('app.color.transparent_backgroundColor'))
          .borderRadius({ topLeft: 8, bottomRight: 10 })
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        }
        .alignItems(VerticalAlign.Bottom)
        .width('100%')
      }
      .borderRadius(10)
      .width('100%')
      // .height($r('app.float.grid_item_height'))
      // 指定当前组件的长宽比
      .aspectRatio(1)
      .backgroundImage(this.studentData.image)
      .backgroundImageSize(ImageSize.Cover)
      .onClick(this.onItemChildImageClick)
    }
  }
}