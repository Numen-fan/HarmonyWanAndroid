import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';

@Entry
@Component
export struct WebPage {
  url: string = ''
  // Web控制器
  private webController: WebviewController = new webview.WebviewController();

  aboutToAppear(): void {
    this.url = (router.getParams() as WebPageParams).url
  }

  build() {
    Column() {
      Web({
        src: this.url, // 默认加载 www.arkui.club 网址
        controller: this.webController
      }).height('100%')
        .width('100%')
        .padding({ left: 10, right: 10 })
    }.width('100%')
    .height('100%')
  }
}

export class WebPageParams {
  url: string

  constructor(str: string) {
    this.url = str
  }
}