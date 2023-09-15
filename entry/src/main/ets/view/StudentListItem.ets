import router from '@ohos.router';
import CommonConstants from '../common/constants/CommonConstants';
import { Logger } from '../common/utils/Logger';

@Component
export default struct StudentListItem {
  @State isChecked: boolean = false;
  private name?: string;

  @Builder checkIcon(icon: Resource) {
    Image(icon)
      .objectFit(ImageFit.Contain)
      .width($r('app.float.checkbox_width'))
      .height($r('app.float.checkbox_height'))
      .margin($r('app.float.checkbox_margin'))
  }

  build() {
    Row() {
      if (this.isChecked) {
        this.checkIcon($r('app.media.ic_checked'))
      } else {
        this.checkIcon($r('app.media.ic_unchecked'))
      }

      Text(this.name)
        .fontColor(this.isChecked ? Color.Red : Color.Black)
        .fontSize(this.isChecked ? $r('app.float.item_checked_font_size') : $r('app.float.item_font_size'))
        .fontWeight(500)
        .opacity(this.isChecked ? 0.5 : 1.0)
        .decoration({ type: this.isChecked ? TextDecorationType.LineThrough : TextDecorationType.None })

      Blank()

      Image($r('app.media.ic_arrow_next'))
        .width('30vp')
        .height('30vp')
        .margin('30vp')
        .onClick(() => {
          console.log('Next Click' + this.name);

          router.pushUrl({
            // url: 'pages/StudentDetailPage',
            url: CommonConstants.STUDENT_DETAIL_URL,
            params: {
              name: this.name,
            }
          }).catch((error) => {
            console.log('Next Click', 'IndexPage push error' + JSON.stringify(error));
          })
        })
    }
    .borderRadius(22)
    .backgroundColor($r('app.color.start_window_background'))
    .width('100%')
    .width('100%')
    .height($r('app.float.list_item_height'))
    .onClick(() => {
      this.isChecked = !this.isChecked;
    })
  }
}