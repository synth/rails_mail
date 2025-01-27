import { Application } from "stimulus";
import "turbo";
import EmailHighlightController from "email_highlight_controller";
import AutoSubmit from 'auto_submit'

const application = Application.start();
application.register("email-highlight", EmailHighlightController);
application.register('auto-submit', AutoSubmit)
window.Stimulus = Application.start();
import "emails_channel";
