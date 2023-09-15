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
}

export default new DataModel();