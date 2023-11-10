import dataPreferences from '@ohos.data.preferences';
import { GlobalContext } from '../utils/GlobalContext';
import Logger from '../utils/Logger';

const TAG = '[PreferencesUtil]';
const PREFERENCES_NAME = 'myPreferences';
const KEY_STUDENT_LIST_MODE = 'key_student_list_mode';

/**
 * PreferencesUtil提供了创建、保存和查询的首选项
 * 用户首选项为应用提供Key-Value键值型的数据处理能力，支持应用持久化轻量级数据，并对其修改和查询。
 * 数据存储形式为键值对，键的类型为字符串型，值的存储数据类型包括数字型、字符型、布尔型以及这3种类型的数组类型。
 */
export class PreferencesUtil {
  createStudentListModelPreferences(context: Context) {
    let fontPreferences: Function = (() => {
      // 要通过用户首选项实现数据持久化，首先要获取Preferences实例。
      // 读取指定文件，将数据加载到Preferences实例，用于数据操作
      let preferences: Promise<dataPreferences.Preferences> = dataPreferences.getPreferences(context,
        PREFERENCES_NAME);
      return preferences;
    });
    GlobalContext.getContext().setObject('getStudentListMode', fontPreferences);
  }

  saveDefaultStudentListMode(isList: boolean) {
    let getStudentListMode: Function = GlobalContext.getContext().getObject('getStudentListMode') as Function;
    getStudentListMode().then((preferences: dataPreferences.Preferences) => {
      // 当对应的键已经存在时，put()方法会修改其值。
      // 如果仅需要在键值对不存在时新增键值对，而不修改已有键值对，需使用has()方法检查是否存在对应键值对；
      // 如果不关心是否会修改已有键值对，则直接使用put()方法即可。
      preferences.has(KEY_STUDENT_LIST_MODE).then(async (isExist: boolean) => {
        Logger.info(TAG, 'preferences StudentListModel is ' + isExist);
        if (!isExist) {
          // 使用put()方法保存数据到缓存的Preferences实例中。
          // 在写入数据后，如有需要，可使用flush()方法将Preferences实例的数据存储到持久化文件。
          await preferences.put(KEY_STUDENT_LIST_MODE, isList);
          preferences.flush();
        }
      }).catch((error: Error) => {
        Logger.error(TAG, 'Has the value failed with err: ' + error);
      });
    }).catch((error: Error) => {
      Logger.error(TAG, 'Get the preferences failed, err: ' + error);
    })
  }

  saveStudentListMode(isList: boolean) {
    let getStudentListMode: Function = GlobalContext.getContext().getObject('getStudentListMode') as Function;
    getStudentListMode().then(async (preferences: dataPreferences.Preferences) => {
      await preferences.put(KEY_STUDENT_LIST_MODE, isList);
      preferences.flush();
    }).catch((error: Error) => {
      Logger.error(TAG, 'put the preferences failed, err: ' + error);
    })
  }

  async getChangeStudentListMode() {
    let isList: boolean = true;
    let getStudentListMode: Function = GlobalContext.getContext().getObject('getStudentListMode') as Function;
    // 使用get()方法获取数据，即指定键对应的值。如果值为null或者非默认值类型，则返回默认数据
    isList = await (await getStudentListMode()).get(KEY_STUDENT_LIST_MODE, isList);
    return isList;
  }

  async deleteChangeStudentListMode() {
    let getStudentListMode: Function = GlobalContext.getContext().getObject('getStudentListMode') as Function;
    const preferences: dataPreferences.Preferences = await getStudentListMode();
    // 删除数据。使用delete()方法删除指定键值对。
    let deleteValue = preferences.delete(KEY_STUDENT_LIST_MODE);
    deleteValue.then(() => {
      Logger.info(TAG, 'Succeeded in deleting the key appFontSize.');
    }).catch((err: Error) => {
      Logger.error(TAG, 'Failed to delete the key appFontSize. Cause: ' + err);
    });
  }
}

export default new PreferencesUtil();
