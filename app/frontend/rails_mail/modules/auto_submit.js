import { Controller } from "stimulus";
function debounce(callback, delay) {
  let timeout;
  return (...args) => {
    clearTimeout(timeout), timeout = setTimeout(() => {
      callback.apply(this, args);
    }, delay);
  };
}
const _AutoSubmit = class _AutoSubmit extends Controller {
  initialize() {
    this.submit = this.submit.bind(this);
  }
  connect() {
    this.delayValue > 0 && (this.submit = debounce(this.submit, this.delayValue));
  }
  submit() {
    this.element.requestSubmit();
  }
};
_AutoSubmit.values = {
  delay: {
    type: Number,
    default: 150
  }
};
let AutoSubmit = _AutoSubmit;
export {
  AutoSubmit as default
};
