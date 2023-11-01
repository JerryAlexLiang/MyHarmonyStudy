import { WanArticleBean } from './WanArticleBean';

export interface ArticlePageListBean {
  curPage: number;
  datas: WanArticleBean[];
  offset: number;
  over: boolean;
  pageCount: number;
  size: number;
  total: number;
}