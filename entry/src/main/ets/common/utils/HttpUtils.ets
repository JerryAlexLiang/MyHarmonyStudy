import ResponseBean from '../bean/ResponseBean';
import http from '@ohos.net.http';
import CommonConstants, { ContentType } from '../constants/CommonConstants';

/**
 * HTTP请求方法封装-GET
 */
export function httpRequestByGet(url: string): Promise<ResponseBean> {
  let httpRequest = http.createHttp();
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.GET,
    readTimeout: CommonConstants.HTTP_READ_TIMEOUT,
    header: {
      'Content-Type': ContentType.JSON
    },
    connectTimeout: CommonConstants.HTTP_READ_TIMEOUT,
    extraData: {}
  });
  let serverData: ResponseBean = new ResponseBean();
  // 处理数据并返回
  return responseResult.then((value: http.HttpResponse) => {
    if (value.responseCode == CommonConstants.HTTP_CODE_200) {
      let result = `${value.result}`;
      let resultJson: ResponseBean = JSON.parse(result);
      if (resultJson.errorCode === CommonConstants.SERVER_CODE_SUCCESS) {
        serverData.data = resultJson.data;
      }
      serverData.errorCode = resultJson.errorCode;
      serverData.errorMsg = resultJson.errorMsg;
    } else {
      serverData.errorMsg = `${$r('app.string.http_error_message')}&${value.responseCode}`;
    }
    return serverData;
  }).catch(() => {
    serverData.errorMsg = $r('app.string.http_error_message');
    return serverData;
  })
}



