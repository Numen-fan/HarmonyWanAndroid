import { MaterialProgressBar } from '@ohos/materialprogressbar'

export enum LoadState {
  LOADING,
  SUCCESS,
  FAIL,
  EMPTY
}

@Component
export struct PageLoadingWidget {
  @Link loadState: LoadState
  @Link showLoading: boolean
  onReload?: () => void;
  // BuilderParam修饰，content由调用者实现
  @BuilderParam content: () => void

  build() {
    Stack() {
      if (this.loadState == LoadState.LOADING) {
        MaterialProgressBar({
          modelBuild: {
            color: $r('app.color.main'),
            bgColor: $r("app.color.divider"),
            indeterminate: true,
            strokeWidth: 4
          }
        })
          .margin({ left: 16, top: 16 })
          .align(Alignment.Center)
      } else if (this.loadState == LoadState.SUCCESS) {
        this.content()
        if (this.showLoading) {
          
        }

      } else if (this.loadState == LoadState.FAIL) {

      } else {

      }
    }
  }
}