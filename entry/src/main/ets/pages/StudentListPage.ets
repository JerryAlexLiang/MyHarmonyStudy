import DataModel from '../viewmodel/DataModel';
import StudentListItem from '../view/StudentListItem';
import router from '@ohos.router';
import prompt from '@system.prompt';
import { DataItemBean } from '../viewmodel/DataItemBean';
// import DataItemBean from '../viewmodel/DataItemBean';

const TAG = '[StudentListPage]';

@Entry
@Component
export struct StudentListPage {
  // private studentList: Array<string> = [];
  private studentList2: Array<DataItemBean> = [];
  @State backMessage: string = '';
  @State isRowModel: boolean = true;

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
          // this.isRowModel = !this.isRowModel
          this.isRowModel = isOn
        })
    }
  }

  build() {
    Navigation() {
      Row() {
        if (this.isRowModel) {
          Scroll() {
            Column() {
              // 列表
              // List组件子组件ListItem之间默认是没有分割线的，部分场景子组件ListItem间需要设置分割线，
              // 这时候可以使用List组件的divider属性。divider属性包含四个参数：
              // 1、strokeWidth: 分割线的线宽。
              // 2、color: 分割线的颜色。
              // 3、startMargin：分割线距离列表侧边起始端的距离。
              // 4、endMargin: 分割线距离列表侧边结束端的距离
              List({ space: 16 }) {
                ForEach(this.studentList2, (item: DataItemBean) => {
                  ListItem() {
                    StudentListItem({ studentData: item, isRowModel: true })
                  }
                }, (item: string) => JSON.stringify(item))
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
          Grid() {
            ForEach(this.studentList2, (item: DataItemBean) => {
              GridItem() {
                StudentListItem({ studentData: item, isRowModel: false })
              }
            }, (item: string) => JSON.stringify(item))
          }
          // .width('90%')
          .columnsTemplate('1fr 1fr 1fr')
          // .rowsTemplate('1fr 1fr 1fr')
          .columnsGap(10)
          .rowsGap(10)
          // .layoutDirection(GridDirection.Row)
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