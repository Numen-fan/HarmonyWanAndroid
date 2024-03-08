export class ResponseData<T> {
  errorCode: number = 0
  errorMsg: string = ""
  data: T = null as T

  public isSuccess(): boolean {
    return this.errorCode === 0
  }

  public isSuccessWithData(): boolean {
    return this.errorCode === 0 && !!this.data
  }
}