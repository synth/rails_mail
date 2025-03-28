import { Application } from "stimulus";
import "turbo";
import EmailHighlightController from "email_highlight_controller";
import RedirectController from "redirect_controller";
import AutoSubmit from 'auto_submit'
import Timeago from 'timeago'
import EmailTabsController from 'email_tabs_controller'

const application = Application.start();

application.register("email-highlight", EmailHighlightController);
application.register("redirect", RedirectController);
application.register('auto-submit', AutoSubmit)
application.register('timeago', Timeago)
application.register('email-tabs', EmailTabsController);

window.Stimulus = Application.start();

import "emails_channel";
