import { WanArticleBean } from '../common/bean/WanArticleBean';
import CommonConstants, { PageState, WanAndroidApiService } from '../common/constants/CommonConstants';
import WanArticleViewModel from '../viewmodel/WanArticleViewModel';
import promptAction from '@ohos.promptAction';
import { ArticlePageListBean } from '../common/bean/ArticlePageListBean';
import ArticleItem from './ArticleItem';

@Component
export default struct ArticlePage {
  // 数据源
  @State articleListData: Array<WanArticleBean> = [];
  // 当前页码 ArticleList第一页起始为0
  // @State currentPage: number = CommonConstants.FIRST_PAGE;
  // 设置当前页为737，每页Item数量为20,加载两次即可加载完所有数据，看到所有加载UI效果
  @State currentPage: number = CommonConstants.TEST_FIRST_PAGE;
  // 每页请求数量
  // @State pageSize: number = CommonConstants.PAGE_SIZE;
  @State pageSize: number = CommonConstants.TEXT_PAGE_SIZE;
  // 请求状态
  @State pageState: number = PageState.Loading;
  // 是否还能加载更多
  @State canLoadMore: boolean = true;
  // 是否正在刷新
  @State isRefreshing: boolean = false;
  // 是否正在刷新2
  @State isRefreshingFromButton: boolean = false;
  // 是否开始加载下一页
  @State isLoadMore: boolean = false;
  // List滑动监听
  private scroller: Scroller = new Scroller();
  // 是否显示悬浮Button，初始状态不显示
  @State isShowFloatingButton: boolean = false;

  /**
   * 请求列表数据
   */
  getWanArticleList() {
    if (this.isRefreshing) {
      // 刷新请偶第一页数据
      // this.currentPage = 0;
      this.currentPage = CommonConstants.TEST_FIRST_PAGE;
    }

    if (this.isRefreshingFromButton) {
      // 刷新请偶第一页数据
      // this.currentPage = 0;
      this.currentPage = CommonConstants.TEST_FIRST_PAGE;
    }

    if (this.isLoadMore) {
      // 加载下一页
      this.currentPage++;
    }

    // 增加耗时
    setTimeout(() => {
      WanArticleViewModel.getWanArticleList(this.currentPage, this.pageSize, WanAndroidApiService.HOME_ARTICLE_LIST)
        .then((data: ArticlePageListBean) => {
          if (this.isRefreshing || this.currentPage === CommonConstants.TEST_FIRST_PAGE) {
            // 赋值
            this.articleListData = data.datas;
            promptAction.showToast({ message: 'Loading ' + this.currentPage })
          } else {
            // 赋值
            // this.articleListData = data.datas;
            this.articleListData = this.articleListData.concat(data.datas);
            promptAction.showToast({ message: 'Loading ' + this.currentPage })
          }

          // 如果是悬浮按钮返回第一页，请求成功后修改状态，且将List滑动到顶部
          if (this.isRefreshingFromButton) {
            this.isRefreshingFromButton = false;
            this.scroller.scrollToIndex(0)
          }

          // 判断是否是最后一页
          // 接口中有个字段over为true代表没有更多数据了
          // 这里使用通用的方法，判断当前请求页返回数据数量是否小于每页数量
          // 如果等于每页请求数量，则还有更多数据，否则当前页即为最后一页
          if (data.datas.length === this.pageSize) {
            this.canLoadMore = true;
          } else {
            this.canLoadMore = false;
          }

          // 请求成功状态更新
          this.pageState = PageState.Success;
          // 停止加载更多
          this.isLoadMore = false;
          // 停止刷新第一页数据
          this.isRefreshing = false;
        }).catch((error: string | Resource) => {
        // 请求失败状态更新
        this.pageState = PageState.Fail;
        // 提示Toast
        promptAction.showToast({
          message: error,
          duration: CommonConstants.ANIMATION_DURATION
        });
      })
    }, 1000)
  }

  aboutToAppear() {
    // 请求列表数据
    this.getWanArticleList()
  }

  @Builder LoadingComponent() {
    Row() {
      LoadingProgress().width(30).height(30)
      Blank().width(10)
      Text('Loading~').fontSize('16vp')
    }
    .margin('30vp')
    .justifyContent(FlexAlign.Center)
  }

  @Builder ClickLoadMoreComponent() {
    Text('---点击加载更多---')
      .fontSize('16vp')
      .margin('30vp')
      .onClick(() => {
        this.isLoadMore = true;
        this.getWanArticleList()
      })
  }

  @Builder LoadMoreAndEnd() {
    Column() {
      if (this.canLoadMore) {
        if (this.isLoadMore) {
          // 加载更多组件
          this.LoadingComponent();
        } else {
          // 点击加载下一页
          this.ClickLoadMoreComponent();
        }
      } else {
        Text('---没有更多了---').fontSize('16vp').margin('30vp')
      }
    }
    .width('100%')
  }

  @Builder ArticleListComponent() {
    List({ space: 16, scroller: this.scroller }) {
      // ListItem() {
      //   Text('重新加载页面数据').onClick(() => {
      //     this.pageState = PageState.Loading;
      //     this.isRefreshing = true;
      //     this.getWanArticleList();
      //   })
      //     .fontColor(Color.Red)
      // }

      ForEach(this.articleListData, (item: WanArticleBean, index: number) => {
        ListItem() {
          ArticleItem({ articleData: item, index: index })
        }
      }, (item, index) => JSON.stringify(item) + index)

      ListItem() {
        this.LoadMoreAndEnd();
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
    .padding({ left: '16vp', right: 16 })
    .divider({ strokeWidth: 0.1, color: Color.Red })
    .onScrollStart(() => {
      // List滑动时不显示悬浮按钮
      this.isShowFloatingButton = false;
    })
    .onScrollStop(() => {
      // List停止滑动时不显示悬浮按钮
      this.isShowFloatingButton = true;
    })
  }

  @Builder ReloadPageButton() {
    Button() {
      Image($r('app.media.ic_refresh'))
        .rotate({ angle: 90 })
        .width(30)
        .height(30)
    }
    .backgroundColor(Color.Yellow)
    .border({ width: 1 })
    .borderColor(Color.Blue)
    .borderStyle(BorderStyle.Dotted)
    .width(35)
    .height(35)
    .position({ x: '80%', y: '70%' })
    .shadow({ radius: 10 })
    .onClick(() => {
      this.pageState = PageState.Loading;
      this.isRefreshing = true;
      this.getWanArticleList();
    })
  }

  @Builder LoadFirstPageButton() {
    Button() {
      Image($r('app.media.ic_back'))
        .rotate({ angle: 90 })
        .width(30)
        .height(30)
    }
    .backgroundColor(Color.Red)
    .border({ width: 1 })
    .borderColor(Color.Blue)
    .borderStyle(BorderStyle.Dotted)
    .width(35)
    .height(35)
    .position({ x: '80%', y: '80%' })
    .shadow({ radius: 10 })
    .onClick(() => {
      // if (this.currentPage > 0) {
      if (this.currentPage > CommonConstants.TEST_FIRST_PAGE) {
        // 不与Refresh组件联动
        this.isRefreshingFromButton = true;
        this.getWanArticleList();
      } else {
        promptAction.showToast({ message: '当前已经是第一页啦~' })
      }
    })
  }

  @Builder LoadNextPageButton() {
    Button() {
      Image($r('app.media.ic_back'))
        .rotate({ angle: -90 })
        .width(30)
        .height(30)
    }
    .backgroundColor(Color.Red)
    .border({ width: 1 })
    .borderColor(Color.Yellow)
    .borderStyle(BorderStyle.Dashed)
    .width(35)
    .height(35)
    .position({ x: '80%', y: '90%' })
    .shadow({ radius: 10 })
    .onClick(() => {
      if (this.canLoadMore === false) {
        promptAction.showToast({ message: '没有更多数据啦~' })
      } else {
        this.isLoadMore = true;
        this.getWanArticleList()
      }
    })
  }

  @Builder ArticleListLayout() {
    // 可以进行页面下拉操作并显示刷新动效的容器组件
    // 1、refreshing	: boolean	必填参数	当前组件是否正在刷新。该参数支持$$双向绑定变量
    // 2、offset	: string | number 非必填参数 (下拉起点距离组件顶部的距离。默认值：16，单位vp，offset取值范围[0vp,64vp]。大于64vp按照64vp处理。不支持百分比，不支持负数)
    // 3、friction	number | string	非必填参数	下拉摩擦系数，取值范围为0到100。默认值：62
    // - 0表示下拉刷新容器不跟随手势下拉而下拉。
    // - 100表示下拉刷新容器紧紧跟随手势下拉而下拉。
    // - 数值越大，下拉刷新容器跟随手势下拉的反应越灵敏。
    Refresh({ refreshing: $$this.isRefreshing, offset: 120, friction: 100 }) {
      Stack() {

        this.ArticleListComponent()

        if (this.isShowFloatingButton) {
          this.ReloadPageButton()
          this.LoadFirstPageButton()
          this.LoadNextPageButton()
        }

        if (this.isRefreshing || this.isRefreshingFromButton) {
          LoadingProgress()
            .width(75)
            .height(75)
            .color(Color.Red)
        }
      }
    }
    .onStateChange((refreshStatus: RefreshStatus) => {

    })
    .onRefreshing(() => {
      this.getWanArticleList();
    })
    // 注意：在List组件上添加了Text组件后，List组件无法拖动到底部
    // 解决方法：
    // 在List的父容器加上代码layoutWeight(1)。
    // 原理：List属于可滚动容器组件，默认高度是占满全屏幕高度，当出现其他固定高度的组件占领了屏幕的部分高度时，
    // 需要开发人员显性的指定List组件占满剩余高度，而不是全屏幕高度。.layoutWeight(1)
    .layoutWeight(1)
  }

  build() {
    if (this.pageState === PageState.Loading) {
      Column() {
        LoadingProgress().width('100vp').width('100vp').color(Color.Red);
      }
    } else if (this.pageState === PageState.Fail) {
      this.FailLayout(() => {
        this.pageState = PageState.Loading;
        this.getWanArticleList();
      })
    } else if (this.pageState === PageState.Success) {
      Column() {
        Text('重新加载页面数据').onClick(() => {
          this.pageState = PageState.Loading;
          this.isRefreshing = true;
          this.getWanArticleList();
        })
          .fontColor(Color.Red)
          .height('30%')

        // 注意：在List组件上添加了Text组件后，List组件无法拖动到底部
        // 解决方法：
        // 在List的父容器加上代码layoutWeight(1)。
        // 原理：List属于可滚动容器组件，默认高度是占满全屏幕高度，当出现其他固定高度的组件占领了屏幕的部分高度时，
        // 需要开发人员显性的指定List组件占满剩余高度，而不是全屏幕高度。.layoutWeight(1)
        this.ArticleListLayout()
      }

    }
  }

  @Builder FailLayout(onClick: () => void) {
    Column() {
      Image($r('app.media.ic_none'))
        .height(CommonConstants.NONE_IMAGE_SIZE)
        .width(CommonConstants.NONE_IMAGE_SIZE)
      Text($r('app.string.page_none_msg'))
        .opacity(CommonConstants.NONE_TEXT_opacity)
        .fontSize(CommonConstants.NONE_TEXT_size)
        .fontColor($r('app.color.fontColor_text3'))
        .margin({ top: CommonConstants.NONE_TEXT_margin })
    }
    .onClick(onClick)
  }
}