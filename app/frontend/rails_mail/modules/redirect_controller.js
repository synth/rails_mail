import { Controller } from 'stimulus'

export default class extends Controller {
  static values = { url: String }
  connect () {
    // Need to remove the element
    // Otherwise, if we revisit this page using a Turbo page cache
    // it may end up redirecting again
    this.element.remove();
    Turbo.visit(this.urlValue)
  }
}
