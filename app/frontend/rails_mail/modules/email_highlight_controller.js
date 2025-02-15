import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["link"]
  
  // Define the Tailwind class as a static property
  static activeClass = "bg-gray-300"

  connect() {
    console.log("EmailHighlightController connected")
    // Listen for Turbo frame load events
    document.addEventListener("turbo:frame-load", this.highlightCurrentEmail.bind(this))
  }

  disconnect() {
    // Clean up event listener when the controller is disconnected
    document.removeEventListener("turbo:frame-load", this.highlightCurrentEmail.bind(this))
  }

  // Called when a link is clicked
  highlight(event) {
    // Remove active class from all email containers
    this.linkTargets.forEach(link => {
      link.closest(".group").classList.remove(this.constructor.activeClass)
    })

    // Add active class to clicked email's container
    const clickedLink = event.currentTarget
    clickedLink.closest(".group").classList.add(this.constructor.activeClass)
  }

  highlightCurrentEmail() {
    // Get the current email ID from the content frame
    const emailContent = document.querySelector("#email_content [data-email-id]")
    if (emailContent) {
      const currentEmailId = emailContent.dataset.emailId

      // Highlight the container with the matching email ID
      this.linkTargets.forEach(link => {
        const container = link.closest(".group")
        if (link.dataset.emailId === currentEmailId) {
          container.classList.add(this.constructor.activeClass)
        } else {
          container.classList.remove(this.constructor.activeClass)
        }
      })
    }
  }
} 