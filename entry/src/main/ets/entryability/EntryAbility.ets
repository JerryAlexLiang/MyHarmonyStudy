import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import PreferencesUtil from '../common/db/PreferencesUtil';
import { GlobalContext } from '../common/utils/GlobalContext';

export default class EntryAbility extends UIAbility {
  onCreate(want, launchParam) {
    // 应用初始化
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

    // 要通过用户首选项实现数据持久化，首先要获取Preferences实例。
    // 读取指定文件，将数据加载到Preferences实例，用于数据操作.
    GlobalContext.getContext().setObject('abilityWant', want);
    PreferencesUtil.createStudentListModelPreferences(this.context);
    // 设置默认学生列表模式-Grid
    PreferencesUtil.saveDefaultStudentListMode(false);
  }

  onDestroy() {
    // onDestroy()在UIAbility实例销毁时触发
    // 可以用于资源的释放，数据的保存等
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // 设置UI页面加载
    // 设置WindowState的事件订阅（获焦/失焦、可见/不可见）
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    // 使用 windowStage.loadContent设置要加载的页面，并根据需要订阅WindowState的事件
    // windowStage.loadContent('pages/Index', (err, data) => {
    // windowStage.loadContent('pages/StudentListPage', (err, data) => {
    windowStage.loadContent('pages/MainPage', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // 释放UI界面资源
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // 申请系统需要的资源，或者重新申请在onBackground中释放的资源
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // 释放UI页面不可见时无用的资源，或者在此回调中执行较为耗时的操作（例如状态保存等）
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
