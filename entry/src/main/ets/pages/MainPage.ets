import Home from '../views/Home';
import Me from '../views/Me';
import WenDa from '../views/WenDa';

@Entry
@Component
struct MainPage {
  @State currentIndex: number = 0;
  private controller: TabsController = new TabsController()

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
      TabContent() {
        Home()
      }
      .tabBar(this.TabBarBuilder($r('app.string.nav_home'), 0, $r('app.media.nav_home_selected'), $r('app.media.nav_home_normal')))
      .backgroundColor($r('app.color.color_F7F8FC'))

      TabContent() {
        WenDa()
      }
      .tabBar(this.TabBarBuilder($r('app.string.nav_wenda'), 1, $r('app.media.nav_wenda_selected'), $r('app.media.nav_wenda_normal')))
      .backgroundColor($r('app.color.color_F7F8FC'))

      TabContent() {
        Me()
      }
      .tabBar(this.TabBarBuilder($r('app.string.nav_me'), 2, $r('app.media.nav_me_selected'), $r('app.media.nav_me_normal')))
      .backgroundColor($r('app.color.color_F7F8FC'))
    }
    .width('100%')
    .barHeight('56vp')
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }

  @Builder
  TabBarBuilder(title: Resource, index: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === index ? selectedImg : normalImg)
        .width('20vp')
        .height('20vp')
      Text(title)
        .margin({ top: '4vp' })
        .fontSize('13fp')
        .fontColor(this.currentIndex === index ? $r('app.color.color_3489FF') : $r('app.color.color_333333'))
    }
    .justifyContent(FlexAlign.Center)
    .height('56vp')
  }
}