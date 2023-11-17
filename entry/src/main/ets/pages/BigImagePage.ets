import { DataItemBean } from '../viewmodel/DataItemBean'
import router from '@ohos.router'
import CommonConstants from '../common/constants/CommonConstants'

@Entry
@Component
struct BigImagePage {

  // 使用router.getParams()获取页面传递进来的的数据
  // @State studentData: DataItemBean = router.getParams()['studentData']
  @State imageUrl: string = router.getParams()['imageUrl']

  build() {
    Column() {
      // Image(this.studentData.image)
      Image(this.imageUrl)
        // Image('https://c-ssl.duitang.com/uploads/item/201805/06/20180506084619_2svWA.jpeg')
        // ImageFit包含以下几种类型：
        // Contain：保持宽高比进行缩小或者放大，使得图片完全显示在显示边界内
        // Cover（默认值）：保持宽高比进行缩小或者放大，使得图片两边都大于或等于显示边界。
        // Auto：自适应显示。
        // Fill：不保持宽高比进行放大缩小，使得图片充满显示边界。
        // ScaleDown：保持宽高比显示，图片缩小或者保持不变。
        // None：保持原有尺寸显示。
        .objectFit(ImageFit.Contain)
          // 共享元素转场：通过修改共享元素的sharedTransition属性设置元素在不同页面之间过渡动效。
          // 例如，如果两个页面使用相同的图片（但位置和大小不同），图片就会在这两个页面之间流畅地平移和缩放。
        .sharedTransition(CommonConstants.SHARE_TRANSITION_ID_STUDENT_IMAGE, {
          duration: CommonConstants.TRANSITION_ANIMATION_DURATION,
          curve: Curve.Smooth,
          delay: CommonConstants.SHARE_ITEM_ANIMATION_DELAY
        })
    }
    .onClick(() => {
      router.back()
    })
  }
}