@Component
export default struct GalleryPage {
  build() {
    Column() {
      Text('Gallery')
        .fontSize('22fp')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('app.color.page_background'))
  }
}