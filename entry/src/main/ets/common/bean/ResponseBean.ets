/**
 * 网络请求返回的数据
 */
export default class ResponseBean {
  errorCode: number;
  errorMsg: string | Resource;
  data: string | Object | ArrayBuffer;

  constructor() {
    this.errorMsg = '';
    this.errorMsg = '';
    this.data = '';
  }
}