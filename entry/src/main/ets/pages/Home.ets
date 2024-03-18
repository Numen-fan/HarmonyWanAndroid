import requestSync from '../network/ApiServer'
import { ResponseData } from '../network/ResponseData';
import ArticlePageData, { Article } from '../model/ArticlePageData';
import { ArticleItemBuilder } from '../views/ArticleItemBuilder';
import { promptAction, router } from '@kit.ArkUI';
import { WebPageParams } from './WebPage';

@Component
export default struct Home {
  private articles: Array<object> = []
  @State loading: boolean = true
  private pageCount: number = 0
  private currentPage = 0

  aboutToAppear(): void {
    this.getTopArticle().then((data) => {
      this.addData(data?.data)

    })

    setTimeout(() => {
      this.getHomeArticleList(this.currentPage).then((data) => {
        this.pageCount = data?.data.pageCount
        this.addData(data?.data?.datas)
      })
    }, 1000)
  }

  private addData(data?: Array<Article>) {
    this.loading = false;
    if (data) {
      this.articles.push(...data ?? [])
    }
  }

  build() {
    if (this.loading) {
      Text("Loading...")
    } else {
      Column() {
        // 列表
        List({ space: '15vp' }) {
          ForEach(this.articles, (item: Article, index) => {
            ListItem() {
              ArticleItemBuilder({ article: item })
                .onClick(() => {
                  if (item.link) {
                    router.pushUrl({
                      url: 'pages/WebPage',
                      params: new WebPageParams(item.link)
                    }, router.RouterMode.Single)
                  } else {
                    promptAction.showToast({ message: "There is no article link" })
                  }
                })
            }
          })
        }
        .width('100%')
        .padding({ left: '15vp', right: '15vp' })

        Text(this.showMore() ? "加载更多" : "没有更多了")
          .onClick(this.showMore() ? () => {
            this.getHomeArticleList(this.currentPage + 1).then((data) => {
              this.addData(data?.data?.datas)
            })
          } : null)
      }.width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Start)
    }
  }

  private showMore(): boolean {
    return this.currentPage < this.pageCount - 1
  }

  async getHomeArticleList(page: number): Promise<ResponseData<ArticlePageData>> {
    if (page > 0 && page >= this.pageCount) {
      return new Promise(() => {
      })
    }
    this.loading = true
    this.currentPage = page
    return requestSync(`/article/list/${page}/json`);
  }

  async getTopArticle(): Promise<ResponseData<Array<Article>>> {
    this.loading = true
    return requestSync('/article/top/json')
  }
}