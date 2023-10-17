import CommonConstants from '../common/constants/CommonConstants'
import GalleryPage from '../view/GalleryPage';
import { StudentListPage } from './StudentListPage';
import router from '@ohos.router';
import prompt from '@system.prompt';

const TAG = '[MainPage]';

@Entry
@Component
struct MainPage {
  @State backMessage: string = '';
  @State currentIndex: number = CommonConstants.STUDENT_LIST_TAB_INDEX

  // 设置Tabs控制器 Tabs组件的控制器，用于控制Tabs组件进行页签切换。不支持一个TabsController控制多个Tabs组件
  private tabsController: TabsController = new TabsController();

  // 调用router.back()方法，不会新建页面，返回的是原来的页面，在原来页面中@State声明的变量不会重复声明，
  // 以及也不会触发页面的aboutToAppear()生命周期回调，因此无法直接在变量声明以及页面的aboutToAppear()
  // 生命周期回调中接收和解析router.back()传递过来的自定义参数。
  onPageShow() {
    this.backMessage = router.getParams()?.['backMessage'];
    console.log(TAG, 'StudentDetailPage返回数据：StudentListPage => ' + this.backMessage)

    if (this.backMessage != undefined && this.backMessage != "") {
      this.showToast(TAG + " " + this.backMessage)
    }
  }

  showToast(message: string) {
    prompt.showToast({
      message: message
    })
  }

  // TabContent的tabBar属性除了支持string类型，还支持使用@Builder装饰器修饰的函数。
  // 可以使用@Builder装饰器，构造一个生成自定义TabBar样式的函数，实现上面的底部页签效果
  @Builder TabBuilder(title: string, index: number, selectImage: Resource, normalImage: Resource) {
    Column() {
      Image(this.currentIndex === index ? selectImage : normalImage)
        .width($r('app.float.mainPage_baseTab_size'))
        .height($r('app.float.mainPage_baseTab_size'))

      Text(title)
        .margin({ top: $r('app.float.mainPage_baseTab_top') })
        .fontSize(this.currentIndex === index ? $r('app.float.main_tab_selected_fontSize')
                                              : $r('app.float.main_tab_normal_fontSize'))
        .fontColor(this.currentIndex === index ? $r('app.color.mainPage_selected_color')
                                               : $r('app.color.mainPage_normal_color'))
    }
    .justifyContent(FlexAlign.Center)
    .height($r('app.float.mainPage_barHeight'))
    .width(CommonConstants.FULL_WIDTH)
    .onClick(() => {
      this.currentIndex = index;
      // 控制Tabs切换到指定页签
      this.tabsController.changeIndex(this.currentIndex);
    })
  }

  build() {
    Tabs({
      barPosition: BarPosition.End,
      controller: this.tabsController,
    }) {
      TabContent() {
        StudentListPage()
      }
      .tabBar(
        this.TabBuilder(
          CommonConstants.STUDENT_LIST_TITLE, CommonConstants.STUDENT_LIST_TAB_INDEX,
          $r('app.media.ic_home_selected'), $r('app.media.ic_home_normal')
        ))

      TabContent() {
        GalleryPage()
      }
      .tabBar(
        this.TabBuilder(
          CommonConstants.PICTURE_TITLE, CommonConstants.PICTURE_TAB_INDEX,
          $r('app.media.ic_checked'), $r('app.media.ic_unchecked')
        ))
    }
    .vertical(false)
    // .vertical(true)
    .scrollable(true) // 设置为true时可以通过滑动页面进行页面切换，为false时不可滑动切换页面。默认值：true
    .width(CommonConstants.FULL_WIDTH) // 设置Tabs组件宽度
    .height(CommonConstants.FULL_HEIGHT) // 设置Tabs组件高度
    .backgroundColor(Color.White) // 设置Tabs组件背景颜色
    .barWidth(CommonConstants.FULL_WIDTH) // 设置TabBar宽度
    .barHeight($r('app.float.mainPage_barHeight')) // 设置TabBar高度
    // .barWidth($r('app.float.mainPage_barWidth')) // 设置TabBar宽度
    // .barHeight('100%') // 设置TabBar高度
    .barMode(BarMode.Fixed) // Tabs的布局模式有Fixed（默认）和Scrollable两种
    // .barMode(BarMode.Scrollable) // Tabs的布局模式有Fixed（默认）和Scrollable两种
    .onChange((index: number) => {
      // Tabs的布局模式有Fixed（默认）和Scrollable两种
      this.currentIndex = index;
    })
  }
}