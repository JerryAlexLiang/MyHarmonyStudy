import DataModel from '../viewmodel/DataModel';
import StudentListItem from '../view/StudentListItem';
import router from '@ohos.router';
import prompt from '@system.prompt';
import { DataItemBean } from '../viewmodel/DataItemBean';
import CommonConstants from '../common/constants/CommonConstants';
import { StudentDetailDialog } from '../view/StudentDetailDialog';
// import DataItemBean from '../viewmodel/DataItemBean';

const TAG = '[StudentListPage]';

@Entry
@Component
export struct StudentListPage {
  // private studentList: Array<string> = [];
  private studentList2: Array<DataItemBean> = [];

  // 返回上一层数据
  @State backMessage: string = '';

  // 是否是List组件模式
  // 组件内的状态管理：@State
  @State isListModel: boolean = true;

  // 是否点击当前Item
  @State clickIndex: number = 0;

  // 当前List/Grid点击Item
  @State currentClickItemData: DataItemBean = undefined;

  // Swiper控制器
  private swiperController: SwiperController = new SwiperController();
  @State confirmMessage: string = ""
  dialogController: CustomDialogController = new CustomDialogController({
    builder: StudentDetailDialog({
      // cancel: () => {
      //   this.showToast('Cancel')
      // },
      // confirm: () => {
      //   this.showToast(this.confirmMessage)
      // },
      // studentData: this.studentList2[0],
      studentData: this.currentClickItemData,
    }),
    autoCancel: true,
    alignment: DialogAlignment.Center,
    customStyle: true
  })

  // 调用router.back()方法，不会新建页面，返回的是原来的页面，在原来页面中@State声明的变量不会重复声明，
  // 以及也不会触发页面的aboutToAppear()生命周期回调，因此无法直接在变量声明以及页面的aboutToAppear()
  // 生命周期回调中接收和解析router.back()传递过来的自定义参数。
  onPageShow() {
    this.backMessage = router.getParams()?.['backMessage'];
    console.log(TAG, 'StudentDetailPage返回数据：StudentListPage => ' + this.backMessage)

    if (this.backMessage != undefined && this.backMessage != "") {
      this.showToast(this.backMessage)
    }
  }

  aboutToAppear() {
    // this.studentList = DataModel.getStudentList();
    this.studentList2 = DataModel.getStudentList2();
    // this.backMessage = router.getParams()?.['backMessage'];
  }

  aboutToDisappear() {
    // 在自定义组件即将析构销毁时将dialogControlle删除和置空
    delete this.dialogController // 删除dialogController
    this.dialogController = undefined // 将dialogController置空
  }

  showToast(message: string) {
    prompt.showToast({
      message: message
    })
  }

  @Builder NavigationMenus() {
    Row() {
      Toggle({ type: ToggleType.Switch, isOn: true })
        .selectedColor(Color.Red)
        .switchPointColor(Color.White)
        .onChange((isOn: boolean) => {
          // this.isListModel = !this.isListModel
          this.isListModel = isOn
        })
    }
  }

  @Builder SwiperBuilder(studentList: Array<DataItemBean>) {
    Swiper(this.swiperController) {
      ForEach(studentList, (item: DataItemBean) => {
        Image(item.image)
          .borderRadius($r('app.float.home_swiper_borderRadius'))
          .width('100%')
          .height('240vp')
          .objectFit(ImageFit.Fill)
          .onClick(() => {
            router.pushUrl({
              // url: 'pages/StudentDetailPage',
              url: CommonConstants.STUDENT_DETAIL_URL,
              params: {
                studentData: item
              }
            }).catch((error) => {
              console.log('Next Click', 'IndexPage push error' + JSON.stringify(error));
            })
          })
      }, (item: DataItemBean) => JSON.stringify(item))
    }
    .autoPlay(true)
    .indicatorStyle({ mask: true, bottom: '10vp' })
    .margin({ top: $r('app.float.home_swiper_margin'), bottom: $r('app.float.home_swiper_margin') })
  }

  build() {
    Navigation() {
      Row() {
        if (this.isListModel) {
          Scroll() {
            Column() {
              // Swiper组件
              this.SwiperBuilder(this.studentList2)
              // 列表
              // List组件子组件ListItem之间默认是没有分割线的，部分场景子组件ListItem间需要设置分割线，
              // 这时候可以使用List组件的divider属性。divider属性包含四个参数：
              // 1、strokeWidth: 分割线的线宽。
              // 2、color: 分割线的颜色。
              // 3、startMargin：分割线距离列表侧边起始端的距离。
              // 4、endMargin: 分割线距离列表侧边结束端的距离
              List({ space: 16 }) {
                ForEach(this.studentList2, (item: DataItemBean, index: number) => {
                  ListItem() {
                    // StudentListItem({ studentData: item, isListModel: true })

                    // 将父组件的列表显示模式状态this.isListModel传递给子组件的编辑模式状态isListModel
                    // 此处指定的参数都将在初始渲染时覆盖本地定义的默认值，并不是所有的参数都需要从父组件初始化
                    StudentListItem({
                      studentData: item,
                      index: index,
                      isListModel: this.isListModel,
                      clickIndex: $clickIndex, // 带有“@Link”装饰的属性必须初始化为“$”
                      onItemChildImageClick: () => {
                        this.currentClickItemData = item

                        if (this.dialogController != undefined) {
                          this.dialogController.open()
                          this.showToast(item.title)
                        }
                      }
                    })
                  }
                }, (item, index) => JSON.stringify(item) + index)
              }
              // .width('90%')
              .divider({ strokeWidth: 1, color: Color.Gray, startMargin: 30, endMargin: 0 })
              // .listDirection(Axis.Horizontal)

              Text('---没有更多了---').fontSize('22vp').margin('30vp')
            }
          }
          .scrollBar(BarState.Off)
          .edgeEffect(EdgeEffect.Spring)
        } else {
          Scroll() {
            Column() {
              // Swiper组件
              this.SwiperBuilder(this.studentList2)

              Grid() {
                ForEach(this.studentList2, (item: DataItemBean) => {
                  GridItem() {
                    // StudentListItem({ studentData: item, isListModel: false })
                    // 将父组件的列表显示模式状态this.isListModel传递给子组件的编辑模式状态isListModel
                    // 此处指定的参数都将在初始渲染时覆盖本地定义的默认值，并不是所有的参数都需要从父组件初始化
                    StudentListItem({
                      studentData: item,
                      isListModel: this.isListModel,
                      clickIndex: $clickIndex, // 带有“@Link”装饰的属性必须初始化为“$”
                      onItemChildImageClick: () => {
                        this.currentClickItemData = item

                        if (this.dialogController != undefined) {
                          this.dialogController.open()
                          this.showToast(item.title)
                        }
                      }
                    })
                  }
                }, (item: string) => JSON.stringify(item))
              }
              .columnsTemplate('1fr 1fr 1fr')
              .rowsTemplate('1fr 1fr 1fr 1fr 1fr')
              .columnsGap('10vp')
              .rowsGap('10vp')
              .height('640vp')
              // .layoutDirection(GridDirection.Row)

              Text('---没有更多了---').fontSize('22vp').margin('30vp')
            }
          }
          .scrollBar(BarState.Off)
          .edgeEffect(EdgeEffect.Spring)
        }
      }
      .width('90%')
      // .margin({ left: 10, right: 10 })
    }
    .title('学生名单')
    .size({ width: '100%', height: '100%' })
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(true)
    .menus(this.NavigationMenus())
    .backgroundColor($r('app.color.page_background'))
  }
}