import DataModel from '../viewmodel/DataModel';
import StudentListItem from '../view/StudentListItem';
import router from '@ohos.router';

const TAG = '[StudentListPage]';

@Entry
@Component
export struct StudentListPage {
  private studentList: Array<string> = [];
  @State backMessage: string = '';

  // 调用router.back()方法，不会新建页面，返回的是原来的页面，在原来页面中@State声明的变量不会重复声明，
  // 以及也不会触发页面的aboutToAppear()生命周期回调，因此无法直接在变量声明以及页面的aboutToAppear()
  // 生命周期回调中接收和解析router.back()传递过来的自定义参数。
  onPageShow() {
    this.backMessage = router.getParams()?.['backMessage'];
    console.log(TAG, 'StudentDetailPage返回数据：StudentListPage => ' + this.backMessage)
  }

  aboutToAppear() {
    this.studentList = DataModel.getStudentList();
    // this.backMessage = router.getParams()?.['backMessage'];
  }

  build() {
    Column({ space: 16 }) {
      Text($r("app.string.Student_List_Title"))
        .fontSize('28fp')
        .fontWeight(FontWeight.Bold)
        .lineHeight('33vp')
        .width('100%')
        .margin({
          top: '24vp',
          bottom: '12vp',
        })
        .textAlign(TextAlign.Center)

      ForEach(this.studentList, (item: string) => {
        StudentListItem({ name: item })
      }, (item: string) => JSON.stringify(item))


      if (this.backMessage != null && this.backMessage != "") {
        Text('返回数据：' + this.backMessage)
          .fontSize('30fp')
          .fontColor(Color.Red)
          .width('100%')
          .margin({
            top: '100vp',
            left: '30vp'
          })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
}