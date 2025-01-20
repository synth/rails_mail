import consumer from "consumer"    // Your Action Cable consumer setup
import { renderStreamMessage } from "turbo" // If you've got turbo.js available

consumer.subscriptions.create({
  channel: "RailsMail::EmailsChannel"
}, {
  received(data) {
    console.log("received data on Emails Channel", data)
    // data should be a string containing <turbo-stream> tags
    renderStreamMessage(data)
  }
})