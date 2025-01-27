import { Controller } from "stimulus";
import { formatDistanceToNow } from "date-fns";
const _Timeago = class _Timeago extends Controller {
  initialize() {
    this.isValid = !0;
  }
  connect() {
    this.load(), this.hasRefreshIntervalValue && this.isValid && this.startRefreshing();
  }
  disconnect() {
    this.stopRefreshing();
  }
  load() {
    const datetime = this.datetimeValue, date = Date.parse(datetime), options = {
      includeSeconds: this.includeSecondsValue,
      addSuffix: this.addSuffixValue,
      locale: this.locale
    };
    Number.isNaN(date) && (this.isValid = !1, console.error(
      `[@stimulus-components/timeago] Value given in 'data-timeago-datetime' is not a valid date (${datetime}). Please provide a ISO 8601 compatible datetime string. Displaying given value instead.`
    )), this.element.dateTime = datetime, this.element.innerHTML = this.isValid ? formatDistanceToNow(date, options) : datetime;
  }
  startRefreshing() {
    this.refreshTimer = setInterval(() => {
      this.load();
    }, this.refreshIntervalValue);
  }
  stopRefreshing() {
    this.refreshTimer && clearInterval(this.refreshTimer);
  }
};
_Timeago.values = {
  datetime: String,
  refreshInterval: Number,
  includeSeconds: Boolean,
  addSuffix: Boolean
};
let Timeago = _Timeago;
export {
  Timeago as default
};
