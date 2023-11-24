import router from '@ohos.router'
import { WanArticleBean } from '../common/bean/WanArticleBean'
import web_webview from '@ohos.web.webview';
import Logger from '../common/utils/Logger';
import CommonConstants from '../common/constants/CommonConstants';

@Entry
@Component
export default struct ArticleDetailPage {

  // 使用router.getParams()获取页面传递进来的的数据
  // @State linkUrl: string = router.getParams()['linkUrl']
  @State articleData: WanArticleBean = router.getParams()['articleData']

  // 进度条加载
  @State loadingProgress: number = 0;

  // Web控制器
  private webViewController: web_webview.WebviewController = new web_webview.WebviewController();

  // darkMode(mode: WebDarkMode):设置Web深色模式，默认关闭
  @State darkMode: WebDarkMode = WebDarkMode.Off

  // 自定义方式：完全自定义转场过程的效果
  @State scale2: number = 1
  @State opacity2: number = 1

  /**
   * 自定义方式：完全自定义转场过程的效果
   *
   */
  pageTransition() {
    // // 配置了当前页面的入场动画为淡入，退场动画为缩小
    // // 进场过程中会逐帧触发onEnter回调，入参为动效的归一化进度(0% -- 100%)
    // PageTransitionEnter({ duration: 1200, curve: Curve.Linear })
    //   .onEnter((type: RouteType, progress: number) => {
    //     this.scale2 = 1
    //     this.opacity2 = progress
    //   });
    // // 退场过程中会逐帧触发onExit回调，入参为动效的归一化进度(0% -- 100%)
    // PageTransitionExit({ duration: 1500, curve: Curve.Ease })
    //   .onExit((type: RouteType, progress: number) => {
    //     this.scale2 = 1 - progress
    //     this.opacity2 = 1
    //   });

    // 配置了当前页面的入场动画为放大，退场动画为缩小
    // 进场过程中会逐帧触发onEnter回调，入参为动效的归一化进度(0% -- 100%)
    PageTransitionEnter({ duration: 1200, curve: Curve.Linear })
      .onEnter((type: RouteType, progress: number) => {
        this.scale2 = progress
        this.opacity2 = progress
      });
    // 退场过程中会逐帧触发onExit回调，入参为动效的归一化进度(0% -- 100%)
    PageTransitionExit({ duration: 1500, curve: Curve.Ease })
      .onExit((type: RouteType, progress: number) => {
        this.scale2 = 1 - progress
        this.opacity2 = 1 - progress
      });
  }

  build() {
    Stack() {
      Navigation() {
        Column() {
          if (this.loadingProgress < 100) {
            // 创建一个进度总长为100，初始进度值为0的线性进度条 ,默认蓝色
            Progress({ value: 0, total: 100, type: ProgressType.Linear })
              .value(this.loadingProgress)
              .color(Color.Red)
              .width('100%')
                // .height(1)
              .style({ strokeWidth: 1 }) // 进度条‘高度’

          }
          Web({
            // src: 'https://juejin.cn/post/7295237661617831988',
            src: this.articleData.link,
            controller: this.webViewController
          })
            .darkMode(this.darkMode)
              // domStorageAccess: 设置是否开启文档对象模型存储接口（DOM Storage API）权限，默认未开启。
              // 不开启情况下网页会显示不全
            .domStorageAccess(true)
            .onPageBegin(() => {
              // 网页开始加载时触发该回调，且只在主frame触发，iframe或者frameset的内容加载时不会触发此回调。
              Logger.debug('ArticleDetailPage', '=====> onPageBegin')
            })
            .onPageVisible(() => {
              // 设置旧页面不再呈现，新页面即将可见时触发的回调函数。
              Logger.debug('ArticleDetailPage', '=====> onPageVisible')
            })
            .onPageEnd(() => {
              // 网页加载完成时触发该回调，且只在主frame触发。
              Logger.debug('ArticleDetailPage', '=====> onPageEnd')
            })
            .onProgressChange((event) => {
              // 网页加载进度变化时触发该回调。
              Logger.debug('ArticleDetailPage', '=====> onProgressChange：' + event.newProgress)
              this.loadingProgress = event.newProgress;
            })
            .onRefreshAccessedHistory((event) => {
              // 加载网页页面完成时触发该回调，用于应用更新其访问的历史链接。
              Logger.debug('ArticleDetailPage', '=====> onProgressChange：' + event.url)
              Logger.debug('ArticleDetailPage', '=====> onProgressChange：' + event.isRefreshed)
            })
        }
        .width('100%')
        .height('100%')
      }
      .title(this.articleData.title)
      .subTitle(this.articleData.author)
      .size({ width: '100%', height: '100%' })
      .titleMode(NavigationTitleMode.Mini)
      // .backgroundColor(this.darkMode === WebDarkMode.Off ? $r('app.color.page_background') : $r('app.color.page_background_dark'))
      .backgroundColor(Color.Black)
      .menus([
        {
          value: "刷新",
          icon: '/image/ic_refresh.png',
          action: () => {
            try {
              // 刷新页面
              this.webViewController.refresh();
            } catch (error) {
              Logger.error(`ErrorCode: ${error.code},  Message: ${error.message}`)
            }
          }
        },
        {
          value: this.darkMode === WebDarkMode.Off ? "浅色" : "深色",
          icon: this.darkMode === WebDarkMode.Off ? '/image/ic_day.png' : "/image/ic_night.png",
          action: () => {
            // 切换模式
            if (this.darkMode === WebDarkMode.On) {
              this.darkMode = WebDarkMode.Off;
            } else {
              this.darkMode = WebDarkMode.On;
            }
          }
        },
      ])
      .backgroundColor($r('app.color.page_background'))

      if (this.loadingProgress < 100) {
        // 设置环形有刻度进度条宽度15，总刻度数为20，刻度宽度为3vp
        Progress({ value: 0, total: 100, type: ProgressType.ScaleRing })
          .width(100)
          .height(100)
          .backgroundColor(Color.Gray)
          .color(Color.Pink)
          .style({ strokeWidth: 15, scaleCount: 20, scaleWidth: 3 })
          .value(this.loadingProgress)
      }
    }
    .scale({ x: this.scale2, y: this.scale2 })
    .opacity(this.opacity2)
  }
}
