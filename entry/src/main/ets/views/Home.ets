import requestSync from '../network/ApiServer'
import { ResponseData } from '../network/ResponseData';
import { http } from '@kit.NetworkKit';
import ArticlePageData from '../beans/ArticlePageData';

@Component
export default struct Home {
  aboutToAppear(): void {
    this.getHomeArticleList(0).then((data)=> {
      console.log(data.errorMsg)
    })
  }

  build() {
    Text("Home")
  }

  async getHomeArticleList(page: number): Promise<ResponseData<ArticlePageData>> {
    return requestSync(`/article/list/${page}/json`, http.RequestMethod.GET);
  }
}