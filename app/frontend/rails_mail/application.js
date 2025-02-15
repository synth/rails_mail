import { Application } from "stimulus";
import "turbo";
import EmailHighlightController from "email_highlight_controller";
import RedirectController from "redirect_controller";
import AutoSubmit from 'auto_submit'
import Timeago from 'timeago'

const application = Application.start();

application.register("email-highlight", EmailHighlightController);
application.register("redirect", RedirectController);
application.register('auto-submit', AutoSubmit)
application.register('timeago', Timeago)

window.Stimulus = Application.start();

import "emails_channel";
