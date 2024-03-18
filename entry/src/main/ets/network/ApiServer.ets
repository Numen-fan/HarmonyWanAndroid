import { http } from '@kit.NetworkKit'
import { ResponseData } from './ResponseData'
import { HashMap } from '@kit.ArkTS'

const BASE_URL = 'https://www.wanandroid.com'

async function requestSync<T>(path: String, method: http.RequestMethod = http.RequestMethod.GET, extraData?: Object): Promise<ResponseData<T>> {
  return new Promise<ResponseData<T>>((resolve, reject) => {
    if (!path.startsWith('/')) {
      throw new Error("path must start with '/'")
    }
    let url = BASE_URL + path
    let header: HashMap<string, string> = new HashMap()
    if (method === http.RequestMethod.POST) {
      header["Content-Type"] = "application/x-www-form-urlencoded"
      if (!extraData) {
        extraData = new Map()
      }
    }
    let httpRequest = http.createHttp()
    httpRequest.request(
      url,
      {
        method: method,
        expectDataType: http.HttpDataType.OBJECT,
        header: header,
        extraData: extraData
      },
      (err, resp) => {
        let res = new ResponseData<T>()
        if (!err && resp.responseCode == 200) {
          res = resp.result as ResponseData<T>
        } else {
          res.errorCode = resp?.responseCode ?? -1
          res.errorMsg = err?.message
        }
        resolve(res)
        // 每次请求完毕必须销毁
        httpRequest.destroy()
      }
    )
  })
}


export default requestSync