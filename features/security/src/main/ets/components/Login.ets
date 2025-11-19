import { Event } from "@kit.ArkTS"

@Component
export  struct Login {
  @State username: string = ''
  @State password: string = ''
  @State isLoading: boolean = false
  @State isPasswordVisible: boolean = false
  @State rememberMe: boolean = false
  @Prop onLoginSuccess: () => void

  build() {
    Column() {
      // 顶部装饰区域
      this.buildTopSection()

      // 登录表单卡片
      this.buildLoginCard()
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildTopSection() {
    Column() {
      // 装饰性圆形
      Stack() {
        Circle({ width: 80, height: 80 })
          .opacity(0.1)
          .margin({ bottom: 20 })

        Circle({ width: 60, height: 60 })
          .opacity(0.15)
          .margin({ top: 40, left: 40 })
      }
      .width('100%')
      .height(100)

      Text('请登录您的账号')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20 })
        .borderColor(Color.Red)
    }
    .width('100%')
    .height(220)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  buildLoginCard() {
    Column() {
      // 用户名输入框
      Row() {
        TextInput({ placeholder: '用户名/邮箱', text: this.username })
          .width('100%')
          .fontSize(20)
          .border({width:1,color:Color.Grey})
          .backgroundColor(Color.Transparent)
          .onChange((value: string) => {
            this.username = value
          })
          .height('40.00vp')
      }
      .width('100%')
      .height(56)
      .padding(16)
      .borderRadius(12)
      .shadow({ radius: 10, color: '#00000015', offsetX: 0, offsetY: 4 })
      .margin({ bottom: 16 })

      // 密码输入框
      Row() {
        TextInput({ placeholder: '请输入密码', text: this.password })
          .width('100%')
          .fontSize(16)
          .border({width:1,color:Color.Grey})
          .backgroundColor(Color.Transparent)
          .type(this.isPasswordVisible ? InputType.Normal : InputType.Password)
          .onChange((value: string) => {
            this.password = value
          }).height('40.00vp')
      }
      .width('100%')
      .height(56)
      .padding(16)
      .borderRadius(12)
      .shadow({ radius: 10, color: '#00000015', offsetX: 0, offsetY: 4 })
      .margin({ bottom: 24 })

      // 记住我和忘记密码
      Row() {
       Blank()

        Text('忘记密码？')
          .fontSize(14)
          .fontColor('#6366F1')
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.handleForgotPassword()
          })
      }
      .width('100%')
      .margin({ bottom: 24 })

      // 登录按钮
      Button('登 录', { type: ButtonType.Capsule })
        .width('100%')
        .height(56)
        .backgroundColor(this.canLogin() ? '#6366F1' : '#94A3B8')
        .fontColor('#FFFFFF')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .shadow({
          radius: this.canLogin() ? 15 : 0,
          color: '#6366F160',
          offsetX: 0,
          offsetY: 8
        })
        .enabled(this.canLogin() && !this.isLoading)
        .onClick(() => {
          this.handleLogin()
        })
        .margin({ bottom: 24 })

      // 加载动画
      if (this.isLoading) {
        Row() {
          ForEach([0, 1, 2], (index: number) => {
            Circle({ width: 8, height: 8 })
              .fill('#6366F1')
              .margin({ right: 8 })
              .animation({
                duration: 600,
                delay: index * 200,
                iterations: -1,
                curve: Curve.EaseInOut
              })
              .scale({
                x: this.isLoading ? 1.5 : 1,
                y: this.isLoading ? 1.5 : 1
              })
          })
        }
        .justifyContent(FlexAlign.Center)
        .margin({ bottom: 24 })
      }

      // 分割线
      Row() {
        Line()
          .width('30%')
          .height(1)
          .backgroundColor('#E2E8F0')

        Text('其它登录方式')
          .fontSize(14)
          .fontColor('#94A3B8')
          .margin({ left: 16, right: 16 })

        Line()
          .width('30%')
          .height(1)
          .backgroundColor('#E2E8F0')
      }
      .width('100%')
      .margin({ bottom: 24 })

      // 注册链接
      Row() {
        Text('还没有账号？')
          .fontSize(14)
          .fontColor('#64748B')

        Text('立即注册')
          .fontSize(14)
          .fontColor('#6366F1')
          .fontWeight(FontWeight.Bold)
          .margin({ left: 8 })
          .onClick(() => {
            this.handleRegister()
          })
      }
      .margin({ top: 32 })
    }
    .width('85%')
    .padding({left:30,right:30})
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .shadow({ radius: 25, color: '#00000025', offsetX: 0, offsetY: 10 })
    .alignSelf(ItemAlign.Center)
    .margin({ top: 10 })
  }

  private canLogin(): boolean {
    return this.username.length >= 3 && this.password.length >= 6
  }

  private handleLogin() {
    this.isLoading = true
    if(this.username!="admin"&&this.password=="123456")
    {
      this.isLoading = false
     this.onLoginSuccess()
    }else {
      console.info('忘记密码')
      this.isLoading = false
    }

  }

  private handleForgotPassword() {
    console.info('忘记密码')
  }

  private handleRegister() {
    console.info('跳转注册页面')
  }
}