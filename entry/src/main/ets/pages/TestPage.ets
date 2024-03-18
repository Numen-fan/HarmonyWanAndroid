import { PullToRefresh } from '@ohos/pulltorefresh';
import { Constants } from '../common/Constants';

@Entry
@Component
struct TestPage {
  @State message: string = 'Hello World';
  @State articles: Object[] = []
  private scroller: Scroller = new Scroller();

  @Builder
  buildListView() {
    // 列表
    List({ space: '15vp' }) {
      ForEach(this.articles, (item: number, index) => {
        ListItem() {
          Text(item.toString())
            .font({ size: 20 })
            .fontColor(Color.Red)
        }
      })
    }
    .width('100%')
    .height(Constants.FULL_HEIGHT)
    .padding({ left: '15vp', right: '15vp' })
  }

  @Builder
  buildContent() {

  }

  build() {
    Row() {
      Column() {
        Text("来了")
        PullToRefresh({
          data: this.articles,
          scroller: this.scroller,
          customList: this.buildListView,
          customRefresh: null,
          customLoad: null
        })
          .width(Constants.FULL_WIDTH)
          .height(Constants.FULL_HEIGHT)
      }
      .width('100%')
    }
    .height('100%')
  }
}