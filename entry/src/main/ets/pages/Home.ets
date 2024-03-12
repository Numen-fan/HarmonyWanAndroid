import requestSync from '../network/ApiServer'
import { ResponseData } from '../network/ResponseData';
import { http } from '@kit.NetworkKit';
import ArticlePageData, { Article } from '../model/ArticlePageData';
import { ArticleItemBuilder } from '../views/ArticleItemBuilder';
import { ifaa } from '@kit.OnlineAuthenticationKit';

@Component
export default struct Home {
  private articles: Array<object> = []
  @State loading: boolean = true
  private pageCount = 0
  private currentPage = 0

  aboutToAppear(): void {
    this.getHomeArticleList(this.currentPage).then((data) => {
      this.addData(data?.data)
    })
  }

  private addData(data?: ArticlePageData) {
    this.loading = false;
    if (data) {
      this.pageCount = data.pageCount
      this.articles.push(...data.datas ?? [])
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
            ArticleItemBuilder({ article: item })
            // if (item instanceof Article) {
            //   ArticleItemBuilder({ article: item })
            // }  else {
            //   // 底部
            //   Text(this.showMore() ? "没有更多了" : "加载更多")
            //     .onClick(this.showMore() ? () => {
            //       this.getHomeArticleList(this.currentPage + 1).then((data) => {
            //         this.addData(data?.data)
            //       })
            //     } : null)
            // }
          })
        }
        .width('100%')
        .padding({ left: '15vp', right: '15vp', top: '15vp' })
        .height('500vp')

        Text(this.showMore() ? "加载更多" : "没有更多了")
          .onClick(this.showMore() ? () => {
            this.getHomeArticleList(this.currentPage + 1).then((data) => {
              this.addData(data?.data)
            })
          } : null)
      }.width('100%')
      .margin({ top: '20vp' })
      .justifyContent(FlexAlign.Start)
    }
  }

  private showMore(): boolean {
    return this.currentPage < this.pageCount - 1
  }

  async getHomeArticleList(page: number): Promise<ResponseData<ArticlePageData | undefined>> {
    if (page > 0 && page >= this.pageCount) {
      return new Promise(() => {
      })
    }
    this.loading = true
    this.currentPage = page
    return requestSync(`/article/list/${page}/json`, http.RequestMethod.GET);
  }
}