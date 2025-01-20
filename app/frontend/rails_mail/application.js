import { Application } from "stimulus";
import "turbo";
import EmailHighlightController from "email_highlight_controller";

const application = Application.start();
application.register("email-highlight", EmailHighlightController);

window.Stimulus = Application.start();
import "emails_channel";