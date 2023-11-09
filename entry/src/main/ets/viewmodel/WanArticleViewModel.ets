import { ArticlePageListBean } from '../common/bean/ArticlePageListBean';
import ResponseBean from '../common/bean/ResponseBean';
import { WanArticleBean } from '../common/bean/WanArticleBean';
import CommonConstants, { WanAndroidApiService } from '../common/constants/CommonConstants';
import { httpRequestByGet } from '../common/utils/HttpUtils';
import Logger from '../common/utils/Logger';
import List from '@ohos.util.List';
import { WanBannerBean } from '../common/bean/WanBannerBean';
import ArrayList from '@ohos.util.ArrayList';

class WanArticleViewModel {
  // 首页文章 https://www.wanandroid.com/article/list/0/json?page_size=2
  getWanArticleList(currentPage: number, pageSize: number, path: string): Promise<ArticlePageListBean> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${WanAndroidApiService.WAN_ANDROID_SERVER}${path}${currentPage}`
      url += '/json' + '?page_size=' + pageSize;
      httpRequestByGet(url).then((data: ResponseBean) => {
        Logger.debug('接口请求地址: HomeArticleList：' + url);
        if (data.errorCode === CommonConstants.SERVER_CODE_SUCCESS) {
          Logger.debug('getWanArticleList success', JSON.stringify(data));
          resolve(data.data);
        } else {
          Logger.error('getWanArticleList failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      }).catch((error: Error) => {
        Logger.error('getWanArticleList failed', JSON.stringify(error));
        reject($r('app.string.http_error_message'))
      })
    })
  }

  // 首页Banner-GET-https://www.wanandroid.com/banner/json
  getWanHomeBanner(): Promise<WanBannerBean[]> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${WanAndroidApiService.WAN_ANDROID_SERVER}${WanAndroidApiService.HOME_BANNER_LIST}`
      httpRequestByGet(url).then((data: ResponseBean) => {
        Logger.debug('接口请求地址: HomeBanner：' + url);
        if (data.errorCode === CommonConstants.SERVER_CODE_SUCCESS) {
          Logger.debug('getWanHomeBanner success', JSON.stringify(data));
          resolve(data.data);
        } else {
          Logger.error('getWanHomeBanner failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      }).catch((error: Error) => {
        Logger.error('getWanHomeBanner failed', JSON.stringify(error));
        reject($r('app.string.http_error_message'))
      })
    })
  }
}


let wanArticleViewModel = new WanArticleViewModel();

export default wanArticleViewModel as WanArticleViewModel;