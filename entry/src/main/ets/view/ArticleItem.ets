import { WanArticleBean } from '../common/bean/WanArticleBean'
import prompt from '@system.prompt';
import router from '@ohos.router';
import CommonConstants from '../common/constants/CommonConstants';
import Logger from '../common/utils/Logger';

@Component
export default struct ArticleItem {
  private articleData: WanArticleBean;
  private index: number;

  showToast(message: string) {
    prompt.showToast({
      message: message
    })
  }

  build() {
    Column() {
      Row() {
        Text((this.articleData.tags != null && this.articleData.tags.length > 0) ? this.articleData.tags[0].name : '站内')
          .fontSize('10fp')
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)
          .border({ width: 1 })
          .backgroundColor(Color.Red)
          .borderColor(Color.Red)
          .borderRadius(5)
          .padding({ left: 3, right: 3, top: 1, bottom: 1 })

        Blank()

        Text('发布时间：' + this.articleData.niceDate)
          .fontSize('10fp')
      }
      .width('100%')

      Text(this.articleData.title)
        .width('100%')
        .fontSize('16fp')
        .fontColor(Color.Black)
        .maxLines(2)
        .margin({ top: 8, bottom: 8 })
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Row() {
        Text('No.' + (this.index + 1) + ' ')
          .fontColor(Color.Red)
          .fontSize('14fp')
          .fontWeight(FontWeight.Bold)

        Text(this.articleData.superChapterName)
          .fontColor(Color.Black)
          .fontSize('14fp')

        Text('·')
          .fontColor(Color.Red)
          .margin({ left: 3, right: 3 })

        Text(this.articleData.chapterName)
          .fontColor(Color.Black)
          .fontSize('14fp')

        Blank().layoutWeight(1)

        Text('❤  ' + (this.articleData.author != null ? this.articleData.author : 'author'))
          .fontColor(Color.Blue)
          .fontSize('14fp')
      }
      .width('100%')
    }
    .onClick(() => {
      this.showToast(this.articleData.title)
      router.pushUrl({
        url: CommonConstants.ARTICLE_DETAIL_PAGE,
        params: {
          // linkUrl: this.articleData.link
          articleData: this.articleData
        }
      }).catch((error) => {
        Logger.error('ArticlePage', 'Error：' + JSON.stringify(error))
      })
    })
    .padding('10vp')
    .width('100%')
    .borderRadius('10vp')
    .backgroundColor($r('app.color.start_window_background'))
  }
}