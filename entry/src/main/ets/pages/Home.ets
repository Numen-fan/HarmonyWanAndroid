import requestSync from '../network/ApiServer'
import { ResponseData } from '../network/ResponseData';
import ArticlePageData, { Article } from '../model/ArticlePageData';
import { ArticleItemBuilder } from '../views/ArticleItemBuilder';
import { promptAction, router } from '@kit.ArkUI';
import { WebPageParams } from './WebPage';
import { LoadState, PageLoadingWidget } from '../views/PageLoadingWidget';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { PullToRefresh } from '@ohos/pulltorefresh'
import { Constants } from '../common/Constants';

@Component
export default struct Home {
  // 成员变量
  private nextPage = 1
  private scroller: Scroller = new Scroller();
  private tag = "Home";
  private hasMore = true
  // 状态变量
  @State articles: Object[] = new Array<Object>()
  @State loadState: LoadState = LoadState.LOADING;
  @State showLoading: boolean = false;

  aboutToAppear(): void {
    this.loadData()
  }

  @Builder
  buildContent() {
    PullToRefresh({
      data: this.articles,
      scroller: this.scroller,
      customList: this.buildListView,
      onRefresh: () => {
        return new Promise<string>((resolve, reject) => {
          // 模拟网络请求操作，2s后返回得到的数据，通知组件，进行列表刷新
          this.getHomeArticleList(0).then((data) => {
            this.nextPage = 1;
            this.articles = data.data.datas
            resolve('刷新成功')
          }, () => {
            resolve('刷新失败')
          })
        })
      },
      onLoadMore: () => {
        return new Promise<string>((resolve, reject) => {
          if (this.hasMore) {
            this.getHomeArticleList(this.nextPage).then(
              (data) => {
                if (data.data.datas.length > 0) {
                  this.nextPage++
                  this.articles = this.articles.concat(data.data.datas)
                  resolve('加载成功')
                } else {
                  this.hasMore = false
                  resolve('没有更多了')
                }
              },
              () => {
                resolve('加载失败')
              }
            )
          } else {
            resolve('没有更多了')
          }
        })
      },
      customRefresh: null,
      customLoad: null
    })
      .width(Constants.FULL_WIDTH)
      .height(Constants.FULL_HEIGHT)
  }

  @Builder
  buildListView() {
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
  }

  build() {
    PageLoadingWidget({
      loadState: this.loadState,
      showLoading: this.showLoading,
      onReload: () => {
        hilog.debug(0, this.tag, "onReload")
        this.loadData();
      },
      content: this.buildContent
    })
  }

  private async loadData() {
    this.loadState = LoadState.LOADING
    this.getHomeArticleList(0).then(
      (data) => {
        this.articles = data.data.datas
        if (this.articles.length === 0) {
          this.loadState = LoadState.EMPTY
        } else {
          this.loadState = LoadState.SUCCESS
        }
      },
      () => {
        this.loadState = LoadState.FAIL
      }
    )
  }

  async getHomeArticleList(page: number): Promise<ResponseData<ArticlePageData>> {
    return requestSync(`/article/list/${page}/json`);
  }

  async getTopArticle(): Promise<ResponseData<Array<Article>>> {
    return requestSync('/article/top/json')
  }
}