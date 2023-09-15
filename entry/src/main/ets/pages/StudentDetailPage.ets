import router from '@ohos.router'

const TAG = '[StudentDetailPage]';

@Entry
@Component
struct StudentDetailPage {

  // 接收到的参数，因为UI要跟着参数进行变化，所以需要加@State装饰符
  @State name: string = (router.getParams() as Record<string, string>)['name'];

  // 点击Button-Back返回给上个页面一个参数
  @State backMessage: string = this.name + "最帅！！！"

  aboutToAppear() {
    console.log(TAG, 'StudentDetailPage接收的参数是: ' + this.name);
  }

  build() {
    Column({ space: 16 }) {
      Text(this.name)
        .fontSize('28fp')
        .fontColor(Color.Blue)
        .fontWeight(FontWeight.Bold)
        .lineHeight('33vp')
        .width('100%')
        .margin({
          top: '24vp',
          bottom: '12vp',
        })
        .textAlign(TextAlign.Center)

      Text(this.name.repeat(100))
        .margin({
          top: '30vp',
          bottom: '30vp',
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
            url: 'pages/StudentListPage',
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
  }
}