import { Article } from '../model/ArticlePageData'

@Component
export struct ArticleItemBuilder {
  article: Article = Object()

  build() {
    Column() {
      Row() {

      }.width('100%')
      Text(this.article.title)
        .font({size:'16fp', style:FontStyle.Italic}).fontColor($r('app.color.color_333333'))
    }.width('100%')
    .padding({ left: '10vp', top: '15vp', right: '10vp', bottom: '15vp' })
    .justifyContent(FlexAlign.Center)
  }
}