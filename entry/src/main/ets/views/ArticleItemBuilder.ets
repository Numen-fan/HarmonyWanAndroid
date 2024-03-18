import { Article, getTagColor, Tag } from '../model/ArticlePageData'

@Component
@Preview
export struct ArticleItemBuilder {
  article: Article = Object()
  onCollectClick?: (article: Article) => void = undefined

  @Builder
  buildTagItem(name: string, color: Resource) {
    Text(name)
      .fontSize(12)
      .fontColor($r('app.color.color_F7F8FC'))
      .backgroundColor(color)
      .border({
        width: 0.5,
        radius: 3,
        color: color
      })
      .padding({ left: 2, top: 1, right: 2, bottom: 1 })
  }

  build() {
    Column() {
      Row() {
        Text(this.article.niceDate)
          .fontSize(12)
        // 添加空白填充
        Blank()
        if (this.article.tags.length == 0 && this.article.fresh) {
          this.buildTagItem("新", $r('app.color.main'))
        } else {
          List({ space: '10vp' }) {
            ForEach(this.article.tags, (tag: Tag, index) => {
              ListItem() {
                this.buildTagItem(tag.name, getTagColor(tag))
              }
            })
          }.listDirection(Axis.Horizontal)
        }
      }.width('100%')
      .margin({ top: 5 })

      // title和收藏
      Row() {
        Text(this.article.title)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Start)
          .font({ size: 16 })
          .width('93%')
          .fontColor($r('app.color.color_333333'))

        // 收藏
        Image(this.article.collect ? $r('app.media.collect_red') : $r('app.media.collect_gray'))
          .width(22)
          .height(22)
          .onClick(() => {
            if (this.onCollectClick) {
              this.onCollectClick(this.article)
            }
          })
      }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 5, bottom: 5 })

      // 作者和分类
      Row() {
        Text(`作者：${this.article.author}`)
          .fontSize(12)
        Blank()
        Text(`分类：${this.article.chapterName}`)
          .fontSize(12)
      }.width('100%')
      .margin({ bottom: 5 })

    }
    .width('100%')
    .padding({ left: '10vp', right: '10vp' })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
    .borderRadius(10)
    .borderWidth(1)
    .borderColor($r('app.color.blue'))
  }
}