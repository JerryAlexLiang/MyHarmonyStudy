/**
 * Common constants for all features.
 */
export default class CommonConstants {
  static readonly NONE_IMAGE_SIZE: number = 120;
  static readonly NONE_TEXT_opacity: number = 0.6;
  static readonly NONE_TEXT_size: number = 16;
  static readonly NONE_TEXT_margin: number = 12;

  /**
   * The off set coefficient.
   */
  static readonly Y_OFF_SET_COEFFICIENT: number = 0.1;

  /**
   * The index page message.
   */
  static readonly INDEX_MESSAGE: string = 'Index Page';

  /**
   * The src msg.
   */
  static readonly SECOND_SRC_MSG: string = 'Index页面传来的数据';

  /**
   * The second page url.
   */
  // static readonly SECOND_URL: string = 'pages/SecondPage';
  static readonly STUDENT_DETAIL_URL: string = 'pages/StudentDetailPage';

  /**
   * The second page message.
   */
  static readonly SECOND_MESSAGE: string = 'Second Page';

  /**
   * The src param.
   */
  static readonly SECOND_SRC_PARAM: string = 'src';

  /**
   * Full the width.
   */
  static readonly FULL_WIDTH: string = '100%';

  /**
   * Full the height.
   */
  static readonly FULL_HEIGHT: string = '100%';

  /**
   * The hello world font size.
   */
  static readonly FONT_SIZE: string = '38fp';

  /**
   * The param font size.
   */
  static readonly PARAMS_FONT_SIZE: string = '20fp';

  /**
   * The button font size.
   */
  static readonly BUTTON_FONT_SIZE: string = '16fp';

  /**
   * The button width.
   */
  static readonly BUTTON_WIDTH: string = '296vp';

  /**
   * The button height.
   */
  static readonly BUTTON_HEIGHT: string = '40vp';

  /**
   * The layout height.
   */
  static readonly LAYOUT_HEIGHT: string = '140vp';

  /**
   * The param opacity.
   */
  static readonly PARAMS_OPACITY: number = 0.6;

  /**
   * StudentList tab index
   */
  static readonly STUDENT_LIST_TAB_INDEX = 0;

  /**
   * Student picture tab index
   */
  // static readonly PICTURE_TAB_INDEX = 1;

  /**
   * Student picture tab index
   */
  static readonly ARTICLE_TAB_INDEX = 1;

  /**
   * Title text of the home page
   */
  static readonly STUDENT_LIST_TITLE = '首页';

  /**
   * Title text of the setting page
   */
  static readonly PICTURE_TITLE = '靓照';

  /**
   * Title text of the Article page
   */
  static readonly ARTICLE_TITLE = '博客';

  /**
   * The http timeout duration.
   */
  static readonly HTTP_READ_TIMEOUT: number = 10000;

  /**
   * Http request success status code.
   */
  static readonly HTTP_CODE_200: number = 200;

  /**
   * The request success status code.
   */
  static readonly SERVER_CODE_SUCCESS: number = 0;

  /**
   * ArticleList第一页起始为0
   */
  static readonly FIRST_PAGE: number = 0

  /**
   * 设置当前页为737，每页Item数量为20,加载两次即可加载完所有数据，看到所有加载UI效果
   */
  static readonly TEST_FIRST_PAGE = 737;

  /**
   * The page size.
   */
  static readonly PAGE_SIZE: number = 5;

  static readonly TEXT_PAGE_SIZE: number = 20;

  /**
   * The animation duration.
   */
  static readonly ANIMATION_DURATION: number = 2000;
}

export class WanAndroidApiService {

  // WanAndroid-BaseUrl
  static readonly WAN_ANDROID_SERVER: string = 'https://www.wanandroid.com';

  // 首页文章 /article/list/0/json
  // https://www.wanandroid.com/article/list/0/json?page_size=2
  static readonly HOME_ARTICLE_LIST: string = '/article/list/';
}
/**
 * The refresh state enum.
 */
export const enum RefreshState {
  DropDown = 0,
  Release = 1,
  Refreshing = 2,
  Success = 3,
  Fail = 4
}

/**
 * The newsList state enum.
 */
export const enum PageState {
  Loading = 0,
  Success = 1,
  Fail = 2
}

/**
 * The request content type enum.
 */
export const enum ContentType {
  JSON = 'application/json'
}