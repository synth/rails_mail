import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["htmlTab", "textTab", "htmlContent", "textContent"];

  connect() {
    if (this.hasHtmlContentTarget) {
      this.showHtmlTab();
    } else {
      this.showTextTab();
    }
  }

  showHtmlTab() {
    if (this.hasHtmlContentTarget) {
      this.htmlTabTarget.classList.add("text-blue-600", "border-blue-600");
      this.htmlTabTarget.classList.remove("text-gray-600", "hover:text-blue-600", "hover:border-blue-600");
      this.htmlTabTarget.setAttribute("aria-selected", "true");

      this.textTabTarget.classList.remove("text-blue-600", "border-blue-600");
      this.textTabTarget.classList.add("text-gray-600", "hover:text-blue-600", "hover:border-blue-600");
      this.textTabTarget.setAttribute("aria-selected", "false");

      this.htmlContentTarget.classList.remove("hidden");
      if (this.hasTextContentTarget) {
        this.textContentTarget.classList.add("hidden");
      }


      this.htmlTabTarget.classList.add("text-blue-600", "border-b-2", "border-blue-600");
    }
  }

  showTextTab() {
    if (this.hasTextContentTarget) {
      this.textTabTarget.classList.add("text-blue-600", "border-blue-600");
      this.textTabTarget.classList.remove("text-gray-600", "hover:text-blue-600", "hover:border-blue-600");
      this.textTabTarget.setAttribute("aria-selected", "true");

      this.htmlTabTarget.classList.remove("text-blue-600", "border-blue-600");
      this.htmlTabTarget.classList.add("text-gray-600", "hover:text-blue-600", "hover:border-blue-600");
      this.htmlTabTarget.setAttribute("aria-selected", "false");

      this.textContentTarget.classList.remove("hidden");
      if (this.hasHtmlContentTarget) {
        this.htmlContentTarget.classList.add("hidden");
      }

      this.textTabTarget.classList.add("text-blue-600", "border-b-2", "border-blue-600");
    }
  }
}