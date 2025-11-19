import {Login} from 'security'
import router from '@ohos.router';
@Entry
@Component
struct Index {

  private navigateToHomePage(): void {
    try {

    } catch (error) {
      console.error('跳转失败:', error)
    }
  }

  build() {
    Column(){
      Login({onLoginSuccess: this.navigateToHomePage})
    }
  }
}