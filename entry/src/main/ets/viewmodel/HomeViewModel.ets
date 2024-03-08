import HomeItemBean from '../beans/ArticlePageData'

enum PAGE_STATE {LOADING, FILL, EMPTY, INIT}

export class HomeViewModel {
  pageState: PAGE_STATE = PAGE_STATE.INIT


  data:Array<HomeItemBean> = []




}

export default new HomeViewModel()