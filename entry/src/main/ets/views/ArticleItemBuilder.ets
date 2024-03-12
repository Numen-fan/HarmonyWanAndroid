import { Article } from '../model/ArticlePageData'

@Component
export struct ArticleItemBuilder {
  article: Article = Object()

  build() {
    Column() {
      Text(this.article?.title)
    }.width('100%')
    .justifyContent(FlexAlign.Center)
  }
}