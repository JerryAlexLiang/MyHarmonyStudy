// import DataItemBean from './DataItemBean';
import { DataItemBean } from './DataItemBean';

export class DataModel {
  private studentList: Array<string> = [
    "丁程鑫",
    "贺峻霖",
    "肖战",
    "成毅",
    "刘耀文",
    "李天泽",
    "马嘉祺",
  ];

  getStudentList(): Array<string> {
    return this.studentList;
  }

  getStudentList2(): Array<DataItemBean> {
    let studentList: DataItemBean[] = [
      {
        "title": "丁程鑫",
        "image": "https://c-ssl.duitang.com/uploads/item/201805/06/20180506084619_2svWA.jpeg",
      },
      {
        "title": "贺峻霖",
        "image": "https://c-ssl.duitang.com/uploads/blog/202107/05/20210705215458_36c2b.jpg",
      },
      {
        "title": "肖战",
        "image": "https://c-ssl.duitang.com/uploads/blog/202112/17/20211217211133_85430.jpeg",
      },
      {
        "title": "成毅",
        "image": "https://tse1-mm.cn.bing.net/th/id/OIP-C.2z8V15bPD1jmtWkBM47b_AHaHa?pid=ImgDet&rs=1",
      },
      {
        "title": "刘耀文",
        "image": "https://c-ssl.duitang.com/uploads/avatar/202202/07/20220207015125_23365.jpg",
      },
      {
        "title": "李天泽",
        "image": "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F202002%2F23%2F20200223151740_uudbp.thumb.1000_0.jpg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1701569400&t=d22c85d97eb299f8b081b0d5f88ea3f5",
      },
      {
        "title": "马嘉祺",
        "image": "https://tse1-mm.cn.bing.net/th/id/OIP-C.vzhdsIrhKA_hJ3mqJMKcVQHaIC?pid=ImgDet&rs=1",
      },
      {
        "title": "丁程鑫2",
        "image": "https://c-ssl.duitang.com/uploads/item/201805/06/20180506084619_2svWA.jpeg",
      },
      {
        "title": "贺峻霖2",
        "image": "https://c-ssl.duitang.com/uploads/blog/202107/05/20210705215458_36c2b.jpg",
      },
      {
        "title": "肖战2",
        "image": "https://c-ssl.duitang.com/uploads/blog/202112/17/20211217211133_85430.jpeg",
      },
      {
        "title": "成毅2",
        "image": "https://tse1-mm.cn.bing.net/th/id/OIP-C.2z8V15bPD1jmtWkBM47b_AHaHa?pid=ImgDet&rs=1",
      },
      {
        "title": "刘耀文2",
        "image": "https://c-ssl.duitang.com/uploads/avatar/202202/07/20220207015125_23365.jpg",
      },
      {
        "title": "李天泽2",
        "image": "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F202002%2F23%2F20200223151740_uudbp.thumb.1000_0.jpg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1701569400&t=d22c85d97eb299f8b081b0d5f88ea3f5",
      },
      {
        "title": "马嘉祺2",
        "image": "https://tse1-mm.cn.bing.net/th/id/OIP-C.vzhdsIrhKA_hJ3mqJMKcVQHaIC?pid=ImgDet&rs=1",
      },
    ];
    return studentList;
  }
}

export default new DataModel();