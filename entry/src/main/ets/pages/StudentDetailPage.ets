import router from '@ohos.router'
import CommonConstants from '../common/constants/CommonConstants';
import Logger from '../common/utils/Logger';
import { DataItemBean } from '../viewmodel/DataItemBean';
// import DataItemBean from '../viewmodel/DataItemBean';

const TAG = '[StudentDetailPage]';

@Entry
@Component
struct StudentDetailPage {

  // 接收到的参数，因为UI要跟着参数进行变化，所以需要加@State装饰符
  // @State name: string = (router.getParams() as Record<string, string>)['name'];

  // 使用router.getParams()获取页面传递进来的的数据
  @State studentData: DataItemBean = router.getParams()['studentData']

  // 点击Button-Back返回给上个页面一个参数
  // @State backMessage: string = this.name + "最帅！！！"
  // @State backMessage: string = this.studentData.title + "最帅！！！"
  @State backMessage: string = ""

  // 是否显示加载Progress
  @State isShowLoadingProgress: boolean = true;

  aboutToAppear() {
    console.log(TAG, 'StudentDetailPage接收的参数是: title= ' + this.studentData.title);
    console.log(TAG, 'StudentDetailPage接收的参数是: image= ' + this.studentData.image);
  }

  onPageShow() {
    const params = router.getParams(); // 获取传递过来的参数对象
    const info = params['studentData']; // 获取info属性的值
    const name = params['studentData'].title;
    const image = params['studentData'].image;

    console.log(TAG, "onPageShow params" + params)
    console.log(TAG, "onPageShow info" + info)
    console.log(TAG, "onPageShow info" + name)
    console.log(TAG, "onPageShow info" + image)
  }

  build() {
    Column({ space: 16 }) {

      if (this.isShowLoadingProgress) {
        LoadingProgress()
          .color(Color.Blue)
          .height(60)
          .width(60)
      }

      Image(this.studentData.image)
        // Image('https://c-ssl.duitang.com/uploads/item/201805/06/20180506084619_2svWA.jpeg')
        // ImageFit包含以下几种类型：
        // Contain：保持宽高比进行缩小或者放大，使得图片完全显示在显示边界内
        // Cover（默认值）：保持宽高比进行缩小或者放大，使得图片两边都大于或等于显示边界。
        // Auto：自适应显示。
        // Fill：不保持宽高比进行放大缩小，使得图片充满显示边界。
        // ScaleDown：保持宽高比显示，图片缩小或者保持不变。
        // None：保持原有尺寸显示。
        .objectFit(ImageFit.Contain)
        .backgroundColor(Color.Pink)
        .width(360)
        .height(200)
        .border({ width: 2 })
        .borderColor(Color.Blue)
        .borderRadius(10)
        .borderStyle(BorderStyle.Dotted)
        .onComplete(() => {
          this.isShowLoadingProgress = false
        })
          // 共享元素转场：通过修改共享元素的sharedTransition属性设置元素在不同页面之间过渡动效。
          // 例如，如果两个页面使用相同的图片（但位置和大小不同），图片就会在这两个页面之间流畅地平移和缩放。
        .sharedTransition(CommonConstants.SHARE_TRANSITION_ID_STUDENT_IMAGE, {
          duration: CommonConstants.TRANSITION_ANIMATION_DURATION,
          curve: Curve.Smooth,
          delay: CommonConstants.SHARE_ITEM_ANIMATION_DELAY
        })
        .onClick(() => {
          router.pushUrl({
            url: CommonConstants.BIG_IMAGE_URL,
            params: {
              imageUrl: this.studentData.image
            }
          }).catch((error) => {
            Logger.error('Push BigImagePage error: ' + JSON.stringify(error))
          })
        })


      // Text(this.name)
      Text(this.studentData.title)
        .fontSize('22fp')
        .fontColor(Color.Blue)
        .fontWeight(FontWeight.Bold)
          // .lineHeight('33vp')
        .width('100%')
        .margin({
          top: '5vp',
          bottom: '5vp',
        })
        .textAlign(TextAlign.Center)

      // Text(this.studentData.title.repeat(50))
      //   .margin({
      //     top: '30vp',
      //     bottom: '30vp',
      //   })

      Text("justifyContent-Start")
        .fontSize('14fp')
        .fontWeight(FontWeight.Bold)

      Row() {
        Text(this.studentData.title + "1")
        Text(this.studentData.title + "2")
        Text(this.studentData.title + "3")
        Text(this.studentData.title + "4")
      }
      .width("100%")
      // 主轴方向的对齐（justifyContent）
      // 1、Start：元素在主轴方向首端对齐，第一个元素与行首对齐，同时后续的元素与前一个对齐。
      .justifyContent(FlexAlign.Start)
      .backgroundColor(Color.Pink)

      Text("justifyContent-Center")
        .fontSize('14fp')
        .fontWeight(FontWeight.Bold)

      Row() {
        Text(this.studentData.title + "1")
        Text(this.studentData.title + "2")
        Text(this.studentData.title + "3")
        Text(this.studentData.title + "4")
      }
      .width("100%")
      // 2、Center：元素在主轴方向中心对齐，第一个元素与行首的距离以及最后一个元素与行尾距离相同。
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Color.Pink)

      Text("justifyContent-End")
        .fontSize('14fp')
        .fontWeight(FontWeight.Bold)

      Row() {
        Text(this.studentData.title + "1")
        Text(this.studentData.title + "2")
        Text(this.studentData.title + "3")
        Text(this.studentData.title + "4")
      }
      .width("100%")
      // 3、End：元素在主轴方向尾部对齐，最后一个元素与行尾对齐，其他元素与后一个对齐。
      .justifyContent(FlexAlign.End)
      .backgroundColor(Color.Pink)

      Text("justifyContent-SpaceBetween")
        .fontSize('14fp')
        .fontWeight(FontWeight.Bold)

      Row() {
        Text(this.studentData.title + "1")
        Text(this.studentData.title + "2")
        Text(this.studentData.title + "3")
        Text(this.studentData.title + "4")
      }
      .width("100%")
      // 4、SpaceBetween：元素在主轴方向均匀分配弹性元素，相邻元素之间距离相同。 第一个元素与行首对齐，最后一个元素与行尾对齐。
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor(Color.Pink)

      Text("justifyContent-SpaceAround")
        .fontSize('14fp')
        .fontWeight(FontWeight.Bold)

      Row() {
        Text(this.studentData.title + "1")
        Text(this.studentData.title + "2")
        Text(this.studentData.title + "3")
        Text(this.studentData.title + "4")
      }
      .width("100%")
      // 5、SpaceAround：元素在主轴方向均匀分配弹性元素，相邻元素之间距离相同。 第一个元素到行首的距离和最后一个元素到行尾的距离是相邻元素之间距离的一半。
      .justifyContent(FlexAlign.SpaceAround)
      .backgroundColor(Color.Pink)

      Text("justifyContent-SpaceEvenly")
        .fontSize('14fp')
        .fontWeight(FontWeight.Bold)

      Row() {
        Text(this.studentData.title + "1")
        Text(this.studentData.title + "2")
        Text(this.studentData.title + "3")
        Text(this.studentData.title + "4")
      }
      .width("100%")
      // 6、SpaceEvenly：元素在主轴方向等间距布局，无论是相邻元素还是边界元素到容器的间距都一样。
      .justifyContent(FlexAlign.SpaceEvenly)
      .backgroundColor(Color.Pink)

      TextInput({ placeholder: '请输入返回信息' })
        .fontColor(Color.Blue)
        .fontSize(20)
        .fontStyle(FontStyle.Italic)
        .fontWeight(FontWeight.Bold)
        .fontFamily('Arial')
        .caretColor(Color.Blue)
        .onChange((value: string) => {
          this.backMessage = this.studentData.title + "  " + value + "最帅！"
        })

      // 可以通过调用router.back()方法实现返回到上一个页面，
      // 或者在调用router.back()方法时增加可选的options参数（增加url参数）返回到指定页面
      Blank()

      Button('返回')
        .fontSize('16fp')
        .width('300vp')
        .height('35vp')
        .backgroundColor($r('app.color.page_background2'))
        .onClick(() => {
          // 返回上一个页面
          // router.back();

          // 返回到指定页面
          // router.back({ url: 'pages/StudentListPage' });

          // 调用router.back()方法返回上一个页面或者返回指定页面时，根据需要继续增加自定义参数，例如在返回时增加一个自定义参数src
          router.back({
            // url: 'pages/StudentListPage',
            url: 'pages/MainPage',
            params: {
              backMessage: this.backMessage,
            }
          })

        })
    }
    .width('100%')
    .height('100%')
    .padding('16vp')
    .backgroundColor($r('app.color.page_background'))
    ////    "pages/BigImagePage"
  }
}