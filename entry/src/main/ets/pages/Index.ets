import router from '@ohos.router';

const TAG = '[Index]';

@Entry
@Component
struct Index {
  @State backMessage: string = '';

  onPageShow() {
    this.backMessage = router.getParams()?.['backMessage'];
    console.log(TAG, 'StudentDetailPage返回数据：Index => ' + this.backMessage)
  }

  build() {

  }
}

