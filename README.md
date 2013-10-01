# NEU Liferay theme

Getting started:

    % npm install -g grunt-cli
    % npm install -g bower
    % npm install
    % bower install
    % gem install sass

Thereafter, `grunt deploy` builds the theme and deploys it to a local Liferay
instance.


## Notes

CSS changes should be made to the SASS files in the `sass` directory; those
files will be compiled and concatenated to create
`docroot/_diffs/css/custom.css`, which is what Liferay will use on deploy.

Your first `ant deploy` might break, depending on your version of Java
installed. Resave `./docroot/images/calendar/calendar_drop_shadow.png` in any
decent image editor to work around a Liferay [issue][].

[issue]: http://issues.liferay.com/browse/LPS-37433


## Liferay docs

* [Theme developer mode][devmode]
* [Theme settings][settings]

[devmode]: http://www.liferay.com/documentation/liferay-portal/6.1/development/-/ai/lp-6-1-theme-developer-mode
[settings]: http://www.liferay.com/documentation/liferay-portal/6.1/development/-/ai/settin-4
