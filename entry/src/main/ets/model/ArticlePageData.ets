export default class ArticlePageData {
  curPage: number = 0
  datas: Array<Article> = []
  offset: number = 0
  over: boolean = false
  pageCount: number = 0
  size: number = 0
  total: number = 0
}

export class Article {
  adminAdd: boolean = false
  apkLink?: string
  audit?: number
  author?: string
  canEdit = false
  chapterId = 0
  chapterName?: string
  collect = false
  courseId = 0
  desc = ''
  fresh = false
  id = 0
  isAdminAdd = false
  link?: string
  niceDate?: string
  niceShareDate?: string
  publishTime = 0
  realSuperChapterId = 0
  selfVisible = 0
  shareDate = 0
  shareUser?: string
  superChapterId = 0
  superChapterName?: string
  title?: string
  type = 0
  userId = 0
  visible = 0
  zan = 0
  tags: Array<Tag> = []
}

export class Tag {
  name: string = ''
  url: string = ''
}

export function getTagColor(tag: Tag): Resource {
  switch (tag.name) {
    case "置顶":
      return $r("app.color.red")
    case "本站发布":
      return $r("app.color.blue")
    case "问答":
      return $r("app.color.cyan")
    case "公众号":
      return $r("app.color.main")
    case "项目":
      return $r("app.color.teal")
    default:
      return $r("app.color.main")
  }
}