
export function changeTime(value: number) {
  return new Date(value).toLocaleTimeString()
}